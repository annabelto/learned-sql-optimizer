To take care of Calcite's requirements, we recommend JDK11+.

SlabCity generation benchmarks are located in `/SlabCity`.

`/gpt` contains scripts for interating with the GPT API via `gpt.py`, measuring the performance of the generated rewrite via `gpt_performance.py`, as well as `parse_markdown.py` for parsing out the query from GPT's response.

`/experimentation` holds full query rewrites and results over TPC-H and TPC-DS. We also collect performance metrics to provide to GPT as feedback along with EXPLAIN query plan descriptions.

