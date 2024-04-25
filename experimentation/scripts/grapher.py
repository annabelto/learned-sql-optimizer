import argparse
import matplotlib.pyplot as plt
import pandas as pd


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input_csv", required=True)
    parser.add_argument("-o", "--output_file", required=True)
    return parser.parse_args()


def plot(in_csv, out):
    results = pd.read_csv(in_csv)    
    results = results.sort_values(by=["Improvement"], ignore_index=True)

    print(results[["Improvement", "Query"]])

    # Set colors for positive and negative bars
    colors = ['blue' if x >= 0 else 'red' for x in results["Improvement"]]
    
    # Create the bar plot
    plt.bar(range(len(results["Improvement"])), results["Improvement"], color=colors)
    
    for i, (q, val) in enumerate(zip(results["Query"], results["Improvement"])):
        if val > 0:
            plt.text(i, val, str(" query {} ".format(q)), ha='center', va='bottom', rotation=-90, fontsize=10)
        else:
            plt.text(i, val, str("query {}".format(q)), ha='center', va='top', rotation=-90, fontsize=10)

    # Add labels and title
    plt.xlabel('Queries')
    plt.ylabel('% Improvement')
    plt.title('TPCH vs GPT')
    
    plt.gca().axes.get_xaxis().set_ticks([])
    # plt.gca().axes.set_ylim(bottom=-0.5, top=1.2) # TPCDS E1
    # plt.gca().axes.set_ylim(bottom=-0.13, top=0.55) # TPCH E5
    # plt.gca().axes.set_ylim(bottom=-0.5, top=0.5) # TPCH E4
    # plt.gca().axes.set_ylim(bottom=-0.25, top=0.25) # TPCH E2
    plt.gca().axes.set_ylim(bottom=-4, top=0.5) # TPCH E1
    plt.tight_layout()
    
    plt.savefig(out)
    plt.show()


def main():
    args = parse_args()
    plot(args.input_csv, args.output_file)


if __name__ == "__main__":
    main()