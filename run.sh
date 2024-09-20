#!/bin/sh
# Developed by Dr. Mohan, modified by Tobi
# 07/09/2024

# This script file is used to parse the config.yml file
# and execute the code files either py or java code by 
# passing the input and output arguments.

var_input=""
var_output=""
var_code=""
while IFS= read -r line || [[ -n "$line" ]]; do
    tmp=(${line//:/ })
    if [[ ${tmp[0]} == "input" ]]; then
        var_input=${tmp[1]} 
    elif [[ ${tmp[0]} == "output" ]]; then
        var_output=${tmp[1]} 
    else
        var_code=${tmp[1]} 
    fi
done < config.yml

var_filename=${var_code##*/}
var_path=(${var_code///$var_filename/ })
arr_code=(${var_filename//./ })
filename=${arr_code[0]} 
language=${arr_code[1]} 

# Ensure the output directory exists
mkdir -p $(dirname "$var_output")

# Get the current timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")

# Modify the output file to include the timestamp
var_output="${var_output%.*}_$timestamp.${var_output##*.}"

if [[ $language == "py" ]]; then
    python3 $var_code "$var_input" "$var_output"
elif [[ $language == "java" ]]; then
    javac $var_code 
    java -cp ".:$var_path" $filename "$var_input" "$var_output"
fi
