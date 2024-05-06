import pandas as pd
import argparse
import os
import subprocess

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i1", "--inp1_dir", required=True)
    parser.add_argument("-i2", "--inp2_dir", required=True)
    parser.add_argument("-n", "--numq", required=True)
    return parser.parse_args()

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

def check_error(file):
    e = subprocess.run(['wc', '-l', file], stdout=subprocess.PIPE)
    if e.stdout.decode('utf-8').split(' ')[0] != '0':
        return True
    return False

def main():
    args = parse_args()
    invalid = []
    for i in range(1, int(args.numq) + 1):
        if int(args.numq) > 22:
            if i in [1, 4, 11, 74, 52]:
                continue
        # print("Running on query {}".format(i), end="... ")
        r1 = os.path.join(args.inp1_dir, "results", "{}".format(i))
        r2 = os.path.join(args.inp2_dir, "results", "{}".format(i))

        if check_error(os.path.join(args.inp1_dir, "errors", "{}".format(i))):
            # print("it has an error!".format(i))
            invalid.append(str(i))
            continue

        df1 = make_dataframe(r1)
        df2 = make_dataframe(r2)

        if df1 is None or df2 is None:
            # print("outputs do not match!".format(i))
            invalid.append(str(i))
        elif (len(df2) != len(df1)) or (len(df1.columns) != len(df2.columns)):
            # print("outputs do not match!".format(i))
            invalid.append(str(i))
        elif not df1.eq(df2.values).all().all():
            # print("outputs do not match!".format(i))
            invalid.append(str(i))
        # else:
            # print("all good!")
    print(" ".join(invalid))



if __name__ == "__main__":
    main()