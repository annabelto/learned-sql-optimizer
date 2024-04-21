import os
import sys
import requests
from openai import OpenAI
import json

api_key = os.environ.get("OPENAI_API_KEY")
if api_key is None:
    raise ValueError("API key not found. Please set the OPENAI_API_KEY environment variable.")

client = OpenAI()
# openai.api_key = api_key

def send_request(prompt, model="gpt-4", temperature=0):
    response = client.chat.completions.create(
        model=model,
        messages=[{"role": "user", "content": prompt}],
        temperature=temperature
    )

    # print("full response: ", str(response))
    return response.choices[0].message.content.strip()

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
    # print("query: ", sql_query)
    return sql_query

if __name__ == "__main__":
    input_dir = sys.argv[1]
    output_dir = sys.argv[2]

    # input_dir = input("Enter the path to the directory containing queries: ")
    # output_dir = input("Enter the path to the directory at which you want to output results: ")
    for filename in os.listdir(input_dir):
        if "explain" in filename:
            continue
        input_file = os.path.join(input_dir, filename)
        if os.path.isfile(input_file):
            prompt = "Using any combination or ordering of data-independent rewrite rules, correctly optimize the following query. Tell me which rules you applied and in what order, and make sure the output follows Postgres SQL syntax: " + parse_sql_query(input_file)
            output_path = os.path.join(output_dir, "q"+filename.split('.')[0]+"_output.md")
            print("running input file, output file: ", input_file, output_path)
            with open(output_path, "w") as f:
                f.write(send_request(prompt))

    # input_file = input("Enter the file path containing the SQL query: ")
    # output_path = input("Enter the file path at which to output the result: ")
    # print("prompt: ", prompt)


    