#!/bin/bash
len=23
pos=0
score=0
str="$(tr -Cd 'A-Za-z0-9' < /dev/urandom | head -c "$len" | sed -e 's/./& /g')"
clear
cat << "EOF"
         __________
         (..       \_    ,  |\  /|
          \       O  \  /|  \ \/ /
           \______    \/ |   \  /
             vvvvv\    \ |   /  |
              \^^^^  ==   \_/   |
               `\_   ===    \.  |
               / /\_   \ /      |
               |/   \_  \|      /
                      \________/

____________________________________________________

                  * Chuppy *
____________________________________________________
EOF


show_caret() {
    tput el1
    head -c $((2*pos)) /dev/zero | tr '\0' ' '
    echo '^'
}

echo "${str}"
show_caret

while (( $pos < $len )); do
    read -rsN1 ch
    if [[ $ch ==  "${str:$((2*pos)):1}" ]]; then
        ((score++))
        ((pos++))
        tput cuu1
        show_caret
      else
        echo "eerrrnnnnt!"
        echo "Your score is $1", $score
        exit 0
    fi
done
