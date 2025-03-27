#!/bin/bash

# This script needs to be run using sudo command.


# Checking if the number of arguments is correct
if [[ "$#" != 1 ]]; then
    echo "Passed too many arguments: $#"
    exit 1
fi    


file="$1"


# Checking if provided file exists
if ! test -f "$file"; then
    echo "File '$file' doesn't exist."
    exit 1
fi


# Creating users with home directories and default passwords
tail -n +2 "$file" | while IFS=',' read -r EmployeeID Department DistinguishedName Enabled GivenName mail Manager Name ObjectClass ObjectGUID OfficePhone SamAccountName SID sn Surname Title UserPrincipalName; do
    username="$SamAccountName"
    full_name="$Name"
    password="default_password"
    
    # Checking if username and fullname is not null
    if [[ -z "$username" || -z "$full_name" ]]; then
        continue
    fi

    # Checking if user with given username exists 
    if id "$username" &>/dev/null; then
        continue
    fi

    useradd -m -c "$full_name" -s /bin/bash "$username"
    "$username:$password" | chpasswd
    chage -d 0 "$username"
done < "$file"
