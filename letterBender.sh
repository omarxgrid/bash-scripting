#!/bin/bash
usage() {
    echo "Usage: $0 [-v|-s <A_WORD> <B_WORD>|-r|-l|-u] -i <input file> -o <output file>"
    exit 1
}

if [ $# -lt 4 ]; then
    usage
fi

operation=""
a_word=""
b_word=""
input_file=""
output_file=""

while getopts ":vs:rli:o:" opt; do
    case $opt in
        v) operation="invert_case" ;;
        s) operation="substitute"; a_word=$OPTARG ;;
        r) operation="reverse_lines" ;;
        l) operation="lower_case" ;;
        u) operation="upper_case" ;;
        i) input_file=$OPTARG ;;
        o) output_file=$OPTARG ;;
        \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
        :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
    esac
done

if [ "$operation" == "substitute" ]; then
    shift $((OPTIND - 1))
    b_word=$1
    if [ -z "$b_word" ]; then
        echo "Substitution requires two words."
        usage
    fi
fi

if [ -z "$input_file" ] || [ -z "$output_file" ]; then
    echo "Input and output files are required."
    usage
fi

case $operation in
    "invert_case") 
        tr 'a-zA-Z' 'A-Za-z' < "$input_file" > "$output_file"
        ;;
    "substitute") 
        sed "s/$a_word/$b_word/g" "$input_file" > "$output_file"
        ;;
    "reverse_lines") 
        tac "$input_file" > "$output_file"
        ;;
    "lower_case") 
        tr '[:upper:]' '[:lower:]' < "$input_file" > "$output_file"
        ;;
    "upper_case") 
        tr '[:lower:]' '[:upper:]' < "$input_file" > "$output_file"
        ;;
    *)
        echo "Invalid operation"
        usage
        ;;
esac
