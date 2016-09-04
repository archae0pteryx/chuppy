#!/bin/bash
score=0
# while true; do
# clear
# echo "$score"
# character=$(</dev/urandom tr -dc '1234567890{}[]`~\/><!@#$%^&*()_+=-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' | head -c1)
# echo "$character"
# read -rsn1 input
# if [ "$character" = "$input" ]; then
#   echo "[+]"
#   ((score++))
#   sleep 1
# else
#   echo "wrong!"
#   score=0
#   sleep 1
# fi
# done
explode () {
    str=$(</dev/urandom tr -dc '1234567890{}[]`~\/><!@#$%^&*()_+=-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' | head -c20) ## Random string
    len=${#str}             ## string length
    k=$((${1:-70}))         ## exploded size requested

    ((k < len)) && {    ## validate requested size > length
      printf "error: width 'k' less than length '%d'\n" "$len"
      exit 1
    }

    sep=$((k/len))  ## max separation between chars (integer division)

    ((sep < 2)) && {    ## if 1, cannot explode
      printf "%s (no expansion)\n" "$str"
      exit 0
    }

    sepst=""    ## set separator string
    printf -v sepst "%*s" $((sep - 1)) " "

    ## insert sepst betwen each char
    for ((i = 0; i < $((len - 1)); i++)); do
      printf "%s%s" ${str:$((i)):1} "$sepst"  ## str intentionally unquoted
    done                                        ## (quote for preserve space)

    ## print final char
    printf "%s\n" "${str: -1}"
}
explode
