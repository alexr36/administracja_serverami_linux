#!/bin/bash


# Checking if the number of arguments is correct
if [[ "$#" != 1 ]]; then
    echo "ERROR: Passed too many arguments: $#"
    exit 1
fi


file="$1"


# Checking if provided file exists
if ! test -f "$file"; then
    echo "ERROR: File '$file' doesn't exist."
    exit 1
fi


# Deleting users with their home directories
tail -n +2 "$file" | while IFS=',' read -r EmployeeID Department DistinguishedName Enabled GivenName mail Manager Name ObjectClass ObjectGUID OfficePhone SamAccountName SID sn Surname Title UserPrincipalName; do
    username="$SamAccountName"
    
    # Checking if username is not null
    if [[ -z "$username" ]]; then
        continue
    fi

    # Checking if user with given username exists
    if ! id "$username" &>/dev/null; then
        continue
    fi

    userdel -r "$username"
done < "$file"
