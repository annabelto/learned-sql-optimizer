import os
import requests
from openai import OpenAI
import json

api_key = os.environ.get("OPENAI_API_KEY")
if api_key is None:
    raise ValueError("API key not found. Please set the OPENAI_API_KEY environment variable.")

client = OpenAI()
# openai.api_key = api_key

def send_request(prompt, model="gpt-4-turbo", temperature=0):
    response = client.chat.completions.create(
        model=model,
        messages=[{"role": "user", "content": prompt}],
        temperature=temperature
    )

    #           json_payload = json.dumps({
    #     "model": "gpt-4-turbo",
    #     "messages": [{"role": "user", "content": prompt}],
    #     "temperature": 0
    # })
    # return res.choices[0].text
    print("full response: ", str(response))
    return response.choices[0].message.content.strip()

def parse_sql_query(file_path):
    lines = []
    with open(file_path, 'r') as file:
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
    print("query: ", sql_query)
    return sql_query

if __name__ == "__main__":
    print("running?")
    # Example JSON payload
    file_path = input("Enter the file path containing the SQL query: ")
    output_path = input("Enter the file path at which to output the result: ")
    prompt = "Using any combination or ordering of data-independent rewrite rules, correctly optimize the following query. Tell me which rules you applied and in what order, and make sure the output follows Postgres SQL syntax: " + parse_sql_query(file_path)
    # json_payload = json.dumps({
    #     "model": "gpt-4-turbo",
    #     "messages": [{"role": "user", "content": prompt}],
    #     "temperature": 0
    # })

    # Generate and print the corrected curl command
    # curl_command = f"curl https://api.openai.com/v1/chat/completions -H 'Content-Type: application/json' -H 'Authorization: Bearer "+str(api_key)+"' -d '{json_payload}'"
    # print(curl_command + "\n\n")
    print("prompt: ", prompt)
    with open(output_path, "w") as f:
        f.write(send_request(prompt))

    