#!/bin/bash

# Parse the input arguments
password="$1"
named_argument="$2"

# If password is empty, create a random string
if [[ -z $password ]]; then
    password=$(openssl rand -hex 12)
    echo "Encrypted password: $password"
fi

# Default to all algorithms if none was specified
if [[ $named_argument == "--algo" ]]; then
    algorithms=("md5" "sha1" "sha256" "sha512" "openssl")
fi

# Encrypt password with each algorithm
for algorithm in "${algorithms[@]}"; do
    if [[ $algorithm == "md5" || $algorithm == "--algo" ]]; then
        md5_hash=$(echo -n $password | md5sum | awk '{print $1}')
        echo "Encrypted password: $md5_hash"
        echo "Algo Name: " $algorithm
    fi

    if [[ $algorithm == "sha1" ]]; then
        sha1_hash=$(echo -n $password | sha1sum | awk '{print $1}')
        echo "Encrypted password: $sha1_hash"
        echo "Algo Name: " $algorithm
    fi

    if [[ $algorithm == "sha256" || $algorithm == "all" ]]; then
        sha256_hash=$(echo -n $password | sha256sum | awk '{print $1}')
        echo "Encrypted password: $sha256_hash"
        echo "Algo Name: " $algorithm
    fi

    if [[ $algorithm == "sha512" || $algorithm == "all" ]]; then
        sha512_hash=$(echo -n $password | sha512sum | awk '{print $1}')
        echo "Encrypted password: $sha512_hash"
        echo "Algo Name: " $algorithm
    fi

    if [[ $algorithm == "openssl" || $algorithm == "all" ]]; then
        salt=$(openssl rand -base64 16)
        encrypted_password=$(echo -n "$password$salt" | openssl passwd -salt "$salt" -1 -stdin)
        echo "Encrypted password: $encrypted_password"
        echo "Algo Name: " $algorithm
    fi
done

# Print the named arguments
if [[ $named_argument == "--text" ]]; then
    echo "Text passed: $password"
elif [[ $named_argument == "--length" ]]; then
    echo "Length of password: ${#password}"
fi
