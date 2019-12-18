import requests
import json

url = "http://quotes.rest/qod.json?category=inspire"

response = requests.request("GET", url)

parser = response.json()
quote = parser["contents"]["quotes"][0]["quote"]
author = parser["contents"]["quotes"][0]["author"]
print(quote, '-', author)
