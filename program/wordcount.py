# Developed by Dr. Mohan
# 06/06/2024
# This program is an usecase that takes an input text file 
# and ouput each word and their occurence (count) in JSON format.

from os import path
import sys
import json
def compute(var_input, var_output):
	inputFile = open(var_input, "r") 
	wordcount = dict() 
	for line in inputFile: 
		line = line.strip() 
		line = line.lower() 
		words = line.split(" ") 
		for word in words: 
			if word in wordcount: 
				wordcount[word] = wordcount[word] + 1
			else: 
				wordcount[word] = 1
	with open(var_output, 'w') as outputFile: 
		outputFile.write(json.dumps(wordcount))

def main():
	basepath = path.dirname(__file__)
	basepath = basepath[0:basepath.rindex("/")]
	var_input = basepath + "/" + sys.argv[1] #input
	var_output = basepath + "/" + sys.argv[2] #output
	compute(var_input, var_output)
	print("Program executed successfully!")

if __name__=="__main__": 
    main() 