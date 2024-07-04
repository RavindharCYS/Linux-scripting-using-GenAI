#!/bin/bash

# Check if userlist.txt exists
if [ ! -f userlist.txt ]; then
    echo "File userlist.txt not found!"
    exit 1
fi

# Loop through each line in userlist.txt
while IFS= read -r username; do
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
    else
        # Create the user
        sudo useradd -m "$username"
        
        # Check if the user was created successfully
        if [ $? -eq 0 ]; then
            echo "User $username has been added to the system."
            
            # Set a default password for the user (optional)
            # Replace 'password' with a real password or generate one
            echo "$username:password" | sudo chpasswd
            
            # Expire the password immediately to force a password change on first login (optional)
            sudo passwd --expire "$username"
        else
            echo "Failed to add user $username."
        fi
    fi
done < userlist.txt

echo "All users have been processed."

