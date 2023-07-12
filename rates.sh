#!/bin/bash

# Get the target directory from the command-line argument
target_directory=$1

# Define the result directory as a subdirectory of the target directory
result_directory="${target_directory}1mer_results/"

# Create result_directory if it doesn't exist
mkdir $result_directory

if [ ! -d "$result_directory" ]; then
  echo "Failed to create directory $result_directory. Check permissions or path."
  exit 1
fi

# loop through all the files
for file in ${target_directory}segments/*.fa.chunk_*; do
    # extract the base name (i.e., protein_name.fa.chunk_0_1)
    base_name=$(basename "$file")

    # extract protein name and chunk details
    protein_name=${base_name%%.fa.chunk_*}
    chunks=${base_name#*.fa.chunk_}
    chunks=${chunks//_/_}

    # construct the csv file name
    csv_file="${result_directory}${protein_name}_${chunks}.csv"

    # execute the python script
    python3 ./get_rate_data_final.py 30my ${target_directory} $csv_file $base_name
done
