import requests
import urllib.request
import time
from bs4 import BeautifulSoup

# Set the URL you want to webscrape from
url = "https://kmeneses.es"

# Connect to the URL
response = requests.get(url)
print(response)
print("Hola")
soup = str(BeautifulSoup(response.text, "html.parser"))
print(soup)
f = open("myfile.txt", "w")
f.write(soup)
