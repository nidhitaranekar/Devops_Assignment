#!/bin/bash

# Define the array of words
words=("$@")
#words=("ab" "cd" "ef")

# Function to generate all possible permutations of the words
function get_permutations() {
    local items=("$@")
    local num=${#items[@]}

    if ((num == 1)); then
        echo "${items[@]}"
    else
        for ((i=0; i<num; i++)); do
            # Swap the current element with the first element
            local temp=${items[0]}
            items[0]=${items[$i]}
            items[$i]=$temp

            # Generate permutations with the swapped array
            for permutation in $(get_permutations "${items[@]:1}"); do
                echo "${items[0]}${permutation}"
            done

            # Swap back the current element with the first element
            items[$i]=${items[0]}
            items[0]=$temp
        done
    fi
}

# Concatenate the strings of each permutation
permutations=$(get_permutations "${words[@]}")
concatenated_permutations=$(echo "$permutations" | tr '\n' ' ' | sed 's/ $/\n/')

# Print the concatenated substring containing all the permutations
echo "$concatenated_permutations"
