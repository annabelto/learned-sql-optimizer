import os
import argparse
import subprocess
import numpy as np
import pandas as pd

from openai import OpenAI

from parse_markdown import extract_queries

api_key = os.environ.get("OPENAI_API_KEY")
if api_key is None:
    raise ValueError("API key not found. Please set the OPENAI_API_KEY environment variable.")

client = OpenAI()

def send_request(prompt, messages, model="gpt-4-turbo", temperature=0):
    response = client.chat.completions.create(
        model=model,
        messages=messages,
        temperature=temperature
    )
    return response.choices[0].message.content.strip()

def check_error(output_path):
    # First parse the markdown file
    sql_query = extract_queries(output_path)
    if sql_query is None:
        return "Incorrect format of output, \
                please provide it in the header under '### Optimized Query'."
    
    with open("temp_query", "w") as f:
        f.write(sql_query)

    os.system("psql -h localhost -U excalibur tpcds < temp_query > temp_result 2> temp_error")

    # psql -h localhost -U $USER $DBNAME < $q > $RESULTS/results/$n 2> $RESULTS/errors/$n
    out = subprocess.run(['wc', '-l', 'temp_error'], stdout=subprocess.PIPE)
    if out.stdout.decode('utf-8').split(' ')[0] != '0':
        return open("temp_error", "r").read()
    os.system("rm temp_error")
    return ""
    
def make_dataframe(file):
    f = open(file, "r")
    lines = f.readlines()
    if len(lines) < 1:
        return None
    s_ind = -1
    e_ind = -1

    for i in range(len(lines)):
        if s_ind == -1 and '|' in lines[i]:
            s_ind = i
        if "row" in lines[i]:
            e_ind = i
    
    cols = [s.strip() for s in lines[s_ind].split('|')]
    rows = [[s.strip() for s in line.split('|')] for line in lines[s_ind+2:e_ind]]

    return pd.DataFrame(rows, columns=cols)

def check_correct(q_number):
    inp1_dir = '../experimentation/tpcds_results'
    inp2_dir = '.'

    r1 = os.path.join(inp1_dir, "results", "{}".format(q_number))
    r2 = os.path.join(inp2_dir, "temp_result")

    df1 = make_dataframe(r1)
    df2 = make_dataframe(r2)

    ans = True
    if df1 is None or df2 is None:
        # print("outputs do not match!".format(i))
        ans = False
    elif (len(df2) != len(df1)) or (len(df1.columns) != len(df2.columns)):
        # print("outputs do not match!".format(i))
        ans = False
    elif not df1.eq(df2.values).all().all():
        # print("outputs do not match!".format(i))
        ans = False

    os.system("rm temp_result")
    return ans

def do_check(output_path, q_number):
    error = check_error(output_path)
    if len(error) > 0:
        return False, error
    else:
        solved = check_correct(q_number)
        return solved, error

def do_performance_check(q_number):
    
    gpt_result = []
    tpch_result = []

    for _ in range(2):
        os.system("/usr/bin/time -o temp_time -f '%e' psql -h localhost \
                -U excalibur tpcds < ../experimentation/tpcds_queries/{}.sql \
                >/dev/null 2>/dev/null".format(q_number))
        with open("temp_time", "r") as t:
            tpch_result.append(float(t.read().strip()))

        os.system("/usr/bin/time -o temp_time -f '%e' psql -h localhost \
                -U excalibur tpcds < temp_query >/dev/null 2>/dev/null")
        with open("temp_time", "r") as t:
            gpt_result.append(float(t.read().strip()))

    return np.mean(gpt_result), np.mean(tpch_result)

def parse_sql_query(input_file):
    lines = []
    with open(input_file, 'r') as file:
        for line in file:
            line = line.strip()
            if line.startswith(":") or line.startswith("--"):
                continue
            lines.append(line)
    sql_query = " ".join(lines)
    # Remove line breaks
    sql_query = sql_query.replace('\n', ' ')
    sql_query = sql_query.replace('\t', ' ')
    # Escape special characters
    sql_query = sql_query.replace('"', r'\"')
    sql_query = sql_query.replace("'", r"\'")
    return sql_query

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input_dir", required=True)
    parser.add_argument("-o", "--out_dir", required=True)
    parser.add_argument("-c", "--chat", type=bool, required=False, default=False)
    parser.add_argument("-p", "--performance", type=bool, required=False, default=False)
    parser.add_argument("-l", "--leetcode", type=bool, required=False)
    
    return parser.parse_args()

if __name__ == "__main__":

    args = parse_args()

    input_dir = args.input_dir
    output_dir = args.out_dir

    # input_dir = input("Enter the path to the directory containing queries: ")
    # output_dir = input("Enter the path to the directory at which you want to output results: ")
    skip = True
    for filename in os.listdir(input_dir):
        # if filename == "1.sql":
        #     skip = False
        # if skip:
        #     continue
        
        if "explain" in filename or filename.split('.')[0] in ['1', '4', '11', '74']:
            continue
        
        input_file = os.path.join(input_dir, filename)
        if os.path.isfile(input_file):
            # prompt = "Using any combination or ordering of data-independent rewrite rules, correctly optimize the following query. Tell me which rules you applied and in what order, and make sure the output follows Postgres SQL syntax: " + parse_sql_query(input_file)
            # Create a message list to maintain history
            messages = [{"role" : "system", "content" : "You are a PostgreSQL expert"}]
            prompt = "Given a syntactically correct PostgreSQL query of TPC-DS as the input, \
                      optimize the query using any combination or ordering of data-independent rewrite \
                      rules that you are inherently aware of and those provided here - \
                      1. Use explicit join syntax instead of comma-separated tables in the FROM clause. \
                      2. Replace implicit joins with explicit joins. \
                      3. Use JOIN instead of WHERE for linking tables. \
                      4. Use JOIN instead of WHERE for combining tables. \
                      5. Use explicit join conditions. \
                      6. Move conditions from WHERE clause to ON clause in JOINs. \
                      List the rules you use and the order in which you applied them. Finally, output \
                      the rewritten query under the heading '### Optimized Query.'. Here's the query : " + parse_sql_query(input_file)
            messages.append({"role" : "user", "content" : prompt})
            output_path = os.path.join(output_dir, "q"+filename.split('.')[0]+"_output.md")
            
            print("Running Query : {}".format(filename))
            with open(output_path, "w") as f:
                result = send_request(prompt, messages)
                messages.append({"role" : "assistant", "content" : result})
                f.write(result)

            if args.chat:
                solved, error = do_check(output_path, int(filename.split('.')[0]))
                counter = 0
                while counter < 10:
                    if len(error) > 0:
                        prompt = "The optimized query provided was wrong. \
                                Here's the error : {}. Please provide the \
                                correct optimized query under the heading \
                                '### Optimized Query'.".format(error)
                    else:
                        if not solved:
                            prompt = "The output of the original query does not \
                                    match your optimized version! Please rectify \
                                    the optimization and provide the query under the \
                                    heading '### Optimized Query.'."
                        else:
                            if args.performance:
                                gpt, tpch = do_performance_check(int(filename.split('.')[0]))
                                if gpt < tpch:
                                    print("GPT: {}, TPCDS: {}".format(gpt, tpch))
                                    break
                                else:
                                    prompt = "The optimized query performs worse compared \
                                              to the original query. Please try to correctly \
                                              optimize it to perform better. Your query runs \
                                              in {} seconds while the original query runs in \
                                              {} seconds. Provide the new optimized query under \
                                              the heading '### Optimized Query.'".format(gpt, tpch)
                            else:
                                break

                    messages.append({"role" : "user", "content" : prompt})

                    with open(output_path, "w") as f:
                        result = send_request(prompt, messages)
                        messages.append({"role" : "assistant", "content" : result})
                        f.write(result)
                    
                    solved, error = do_check(output_path, int(filename.split('.')[0]))
                    counter += 1

                print("Took {} tries, and solved : {}".format(counter, solved))

   # /usr/bin/time -a -f "$n = %e" -o $RESULTS/results.log psql -h localhost -U $USER $DBNAME < $q > $RESULTS/results/$n 2> $RESULTS/errors/$n &

"""
Experiment 1 : Model : gpt-4-turbo, Original prompt

Experiment 2 : Model : gpt-4-turbo, Improved prompt

Experiment 4 : Model : gpt-4-turbo, Chat with GPT to refine
    Q15 took 3 tries

Experiment 5 : Model : gpt-4-turbo, Chat with performance refinement
    Running Query : 5.sql
    Took 5 tries, and solved : True
    Running Query : 18.sql
    Took 0 tries, and solved : True
    Running Query : 1.sql
    Took 1 tries, and solved : True
    Running Query : 2.sql
    Took 8 tries, and solved : True
    Running Query : 3.sql
    Took 5 tries, and solved : True
    Running Query : 17.sql
    Took 2 tries, and solved : True
    Running Query : 13.sql
    Took 7 tries, and solved : True
    Running Query : 21.sql
    Took 0 tries, and solved : True
    Running Query : 15.sql
    Took 4 tries, and solved : True
    Running Query : 6.sql
    Took 5 tries, and solved : True
    Running Query : 10.sql
    Took 0 tries, and solved : True
    Running Query : 9.sql
    Took 3 tries, and solved : True
    Running Query : 20.sql
    Took 0 tries, and solved : True
    Running Query : 11.sql
    Took 0 tries, and solved : True
    Running Query : 12.sql
    Took 0 tries, and solved : True
    Running Query : 4.sql
    Took 5 tries, and solved : True
    Running Query : 22.sql
    Took 3 tries, and solved : True
    Running Query : 8.sql
    Took 2 tries, and solved : True
    Running Query : 14.sql
    Took 2 tries, and solved : True
    Running Query : 19.sql
    Took 8 tries, and solved : True
    Running Query : 7.sql
    Took 3 tries, and solved : True
    Running Query : 16.sql
    Took 0 tries, and solved : True

    Experiment 7: Prompt with rewrite rules and chat
    Experiment 8: Prompt with rewrite rules and chat & performance

"""