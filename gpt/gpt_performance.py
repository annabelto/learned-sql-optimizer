import os
import pandas as pd
import numpy as np

def do_performance_check(q_number):
    
    tpch_result = []
    gpt_result = []
    
    for i in range(5):
        os.system("/usr/bin/time -o temp_time -f '%e' psql -h localhost \
                -U excalibur tpch < ../experimentation/tpch_queries/{}.sql \
                >/dev/null 2>/dev/null".format(q_number))
        with open("temp_time", "r") as t:
            tpch_result.append(float(t.read().strip()))

        os.system("/usr/bin/time -o temp_time -f '%e' psql -h localhost \
                -U excalibur tpch < ../experimentation/gpt_queries/exp5/{}.sql \
                >/dev/null 2>/dev/null".format(q_number))
        with open("temp_time", "r") as t:
            gpt_result.append(float(t.read().strip()))

    return np.mean(gpt_result), np.mean(tpch_result)

def main():
    
    # Appropriately build out the timings list
    result = []
    for i in range(1, 23):
        gpt, tpch = do_performance_check(i)
        result.append(
            {
                "Query" : i,
                "TPCH" : tpch,
                "GPT" : gpt,
                "Improvement" : (tpch - gpt)/tpch
            }
        )

    result_df = pd.DataFrame(result, columns=["Query", "TPCH", "GPT", "Improvement"])
    print(result_df)
    print("Average improvment via GPT : ", result_df["Improvement"].mean())
    
if __name__ == "__main__":
    main()

"""
    Query   TPCH    GPT  Improvement
0       1  1.392  1.412    -0.014368
1       2  0.190  0.186     0.021053
2       3  0.278  0.264     0.050360
3       4  0.130  0.134    -0.030769
4       5  0.276  0.288    -0.043478
5       6  0.208  0.204     0.019231
6       7  0.388  0.332     0.144330
7       8  0.166  0.142     0.144578
8       9  0.904  0.938    -0.037611
9      10  0.248  0.274    -0.104839
10     11  0.080  0.064     0.200000
11     12  0.334  0.338    -0.011976
12     13  0.308  0.314    -0.019481
13     14  0.124  0.122     0.016129
14     15  0.474  0.252     0.468354
15     16  0.186  0.170     0.086022
16     17  1.246  1.232     0.011236
17     18  1.754  1.764    -0.005701
18     19  0.046  0.040     0.130435
19     20  0.948  0.972    -0.025316
20     21  0.346  0.346     0.000000
21     22  0.060  0.058     0.033333
Average improvment via GPT :  0.046887338544476125

    Query   TPCH    GPT   Improvement
0       1  1.408  1.330  5.539773e-02
1       2  0.382  0.180  5.287958e-01
2       3  0.312  0.256  1.794872e-01
3       4  0.128  0.130 -1.562500e-02
4       5  0.278  0.280 -7.194245e-03
5       6  0.202  0.200  9.900990e-03
6       7  0.314  0.314  0.000000e+00
7       8  0.170  0.142  1.647059e-01
8       9  0.794  0.790  5.037783e-03
9      10  0.234  0.234  0.000000e+00
10     11  0.080  0.060  2.500000e-01
11     12  0.324  0.316  2.469136e-02
12     13  0.280  0.282 -7.142857e-03
13     14  0.118  0.124 -5.084746e-02
14     15  0.404  0.216  4.653465e-01
15     16  0.180  0.180 -1.541976e-16
16     17  1.212  1.218 -4.950495e-03
17     18  1.860  1.840  1.075269e-02
18     19  0.034  0.034  0.000000e+00
19     20  0.932  0.918  1.502146e-02
20     21  0.328  0.324  1.219512e-02
21     22  0.054  0.054  0.000000e+00
Average improvment via GPT :  0.07434420371411761

"""