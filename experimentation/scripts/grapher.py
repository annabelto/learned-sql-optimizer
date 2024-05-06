import argparse
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input_csv", required=True)
    parser.add_argument("-o", "--output_file", required=True)
    return parser.parse_args()


def plot(in_csv, out):
    results = pd.read_csv(in_csv)    
    results = results.sort_values(by=["Improvement"], ignore_index=True)

    # print(results[["Improvement", "Query"]])
    # print("Average improvment via GPT : ", results[results["Improvement"] >= -0.1].mean())

    # Set colors for positive and negative bars
    colors = ['blue' if x >= 0 else 'red' for x in results["Improvement"]]
    
    # Create the bar plot
    plt.bar(range(len(results["Improvement"])), results["Improvement"], color=colors)
    
    for i, (q, val) in enumerate(zip(results["Query"], results["Improvement"])):
        if val > 0:
            plt.text(i, val, str(" query {} ".format(q)), ha='center', va='bottom', rotation=-90, fontsize=5)
        else:
            plt.text(i, val, str("query {}".format(q)), ha='center', va='top', rotation=-90, fontsize=5)

    # Add labels and title
    plt.xlabel('Queries', fontsize=14)
    plt.ylabel('Improvement', fontsize=14)
    plt.title('Postgres vs GPT (TPC-DS)', fontsize=22)
    
    plt.gca().axes.get_xaxis().set_ticks([])
    plt.gca().axes.set_ylim(bottom=-0.5, top=1.2) # TPCDS E1
    # plt.gca().axes.set_ylim(bottom=-0.13, top=0.55) # TPCH E5
    # plt.gca().axes.set_ylim(bottom=-0.5, top=0.6) # TPCH E4
    # plt.gca().axes.set_ylim(bottom=-0.25, top=0.25) # TPCH E2
    # plt.gca().axes.set_ylim(bottom=-4, top=0.5) # TPCH E1
    plt.tight_layout()
    
    plt.savefig(out)
    plt.show()


def main():
    args = parse_args()
    plot(args.input_csv, args.output_file)
    # csv = "../tpcds_vs_gpt_exp{}.csv"
    # new_df = pd.DataFrame()
    # new_df["Query"] = np.arange(1, 100)
    # new_df["Benchmark"] = ["-"] * 99
    # new_df["Exp 1"] = ["-"] * 99
    # new_df["Exp 2"] = ["-"] * 99
    # new_df["Exp 3"] = ["-"] * 99
    # j = 2
    # for i in [1, 3, 4]:
    #     df = pd.read_csv(csv.format(i))
    #     for q, val, t in zip(df["Query"], df["GPT"], df["TPCDS"]):
    #         new_df.iloc[q-1, 1] = str(round(t, 2))
    #         new_df.iloc[q-1, j] = str(round(val, 2))
    #     j += 1
    # print(new_df.set_index('Query').to_latex())


if __name__ == "__main__":
    main()