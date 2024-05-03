import os
import argparse
import subprocess

import pandas as pd

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-g", "--gpt_dir", required=True)
    parser.add_argument("-t", "--tpch_dir", required=True)
    parser.add_argument("-r", "--result_file", required=True)
    return parser.parse_args()

def parse_results(file):
    with open(file, "r") as f:
        results = {}
        for line in f.readlines():
            key, value = line.split('=')
            results[int(key)] = float(value)
    return results

def main():
    # Fetch commandline args
    args = parse_args()
    
    # check if both directories are valid
    if not (os.path.isdir(args.gpt_dir) and os.path.isdir(args.tpch_dir)):
        print("One of the directories are not correct! Exiting...")
        exit()

    # Fetch timing results for both runs
    gpt_results  = parse_results(os.path.join(args.gpt_dir, "results.log"))
    tpch_results = parse_results(os.path.join(args.tpch_dir, "results.log"))

    # Run diff_checker
    out = subprocess.run(['./diff_checker.sh', args.gpt_dir, args.tpch_dir], stdout=subprocess.PIPE)
    # Check if no error occurred
    if out.stderr:
        print(out.stderr)
        exit()
    # Find bad queries
    bad_queries = []
    for line in out.stdout.decode('utf-8').split('\n'):
        if len(line.split(' ')) > 2:
            bad_queries.append(int(line.split(' ')[1]))

    # Appropriately build out the timings list
    result = []
    for i in range(1, 100):
        if i in [1, 4, 11, 74]:
            continue
        if i not in bad_queries:
            result.append(
                {
                    "Query" : i,
                    "TPCDS" : tpch_results[i],
                    "GPT" : gpt_results[i],
                    "Improvement" : (tpch_results[i] - gpt_results[i])/tpch_results[i]
                }
            )

    result_df = pd.DataFrame(result, columns=["Query", "TPCDS", "GPT", "Improvement"])
    print(result_df)
    print("Average improvment via GPT : ", result_df["Improvement"].mean())
    result_df.to_csv(args.result_file)

if __name__ == "__main__":
    main()