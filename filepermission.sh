#!/bin/bash

# Check if the user provided an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 /home/ubuntu"
    exit 1
fi

# Store the file or directory path
FILE=$1

# Check if the file or directory exists
if [ ! -e "$FILE" ]; then
    echo "Error: $FILE does not exist."
    exit 1
fi

# Display the file permissions
ls -l "$FILE" | awk '{print "Permissions: "$1"\nOwner: "$3"\nGroup: "$4"\nSize: "$5"\nLast Modified: "$6" "$7" "$8"\nName: "$9}'

