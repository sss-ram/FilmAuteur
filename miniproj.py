from flask import Flask, jsonify
import requests
import smtplib
import time
import pandas as pd
from bs4 import BeautifulSoup
pd.options.mode.chained_assignment = None

app = Flask(__name__)

product_links = []

def extract_content(url):
    r = requests.get(url)
    page_content = r.text
    product_soup = BeautifulSoup(page_content, 'html.parser')
    return product_soup

def extract_product_name(soup):
    product_name = soup.find("span", {"id":"productTitle"}).get_text().strip()
    return product_name

def extract_price(soup):
    price = soup.find("span", {"id":"priceblock_ourprice"}).get_text().strip()
    price = float(price[1:].replace(",", ""))
    return price

def monitor_price():
    while True:
        for link in product_links:
            soup = extract_content(link)
            product_name = extract_product_name(soup)
            product_price = extract_price(soup)
            print(f"The current price of {product_name} is {product_price}")
        time.sleep(60)

@app.route("/")
def index():
    return "Welcome to the price monitoring app!"

if __name__ == "__main__":
    app.run(debug=True)
