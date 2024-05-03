import re
import sys
import os

def extract_queries(filename):
    with open(filename, 'r') as file:
        content = file.read()

        # Define regular expressions to match specific formats
        regex_format1 = re.compile(r'### Optimized Query.*?```sql\n(.*?)\n```', re.DOTALL)
        regex_format2 = re.compile(r"Here's the optimized query.*?```sql\n(.*?)\n```", re.DOTALL)

        # Find the first match for format 1
        match_format1 = re.search(regex_format1, content)

        # If format 1 match is found, return it
        if match_format1:
            return match_format1.group(1)
        
        # If format 1 match is not found, find and return the first match for format 2
        match_format2 = re.search(regex_format2, content)
        if match_format2:
            return match_format2.group(1)

        # If no matches are found, return an empty list
        return None

if __name__ == "__main__":
    input_dir = sys.argv[1]
    output_dir = sys.argv[2]

    for filename in os.listdir(input_dir):
        input_file = os.path.join(input_dir, filename)
        if os.path.isfile(input_file):
            # Read the input file and extract the SQL query
            sql_query = extract_queries(input_file)
            # if sql_query:
            #     print(sql_query)
            if not sql_query:
                print(f"{input_file} did not have a match")
                continue

            output_path = os.path.join(output_dir, filename[1:].split('_')[0]+".sql")
            # print("running input file, output file: ", input_file, output_path)
            with open(output_path, "w") as f:
                f.write(sql_query)