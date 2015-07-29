#!/usr/local/bin/python

import shutil

print("-------------------------------\n")
print("Welcome to LazyDev!\n")
print("-------------------------------\n")

api_key = raw_input("What is your API key?\n")
bucket_id = raw_input("What is your space ID?\n")

shutil.copytree("./LazyDev", "./YourRusicApp")

with open("./YourRusicApp/LazyDev/Credentials.swift", "w") as f:
    f.write("import UIKit\n")
    f.write("class Credentials: NSObject {\nlet apiKey = \"" + api_key + "\"\n")
    f.write("let bucketID = \"" + bucket_id + "\"\n }")

print("-------------------------------\n")
print("Your Rusic LazyDev application has been generated at YourRusicApp\n")
print("-------------------------------\n")
