#!/bin/bash
#len=$(lvl)
pos=0
score=0

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
menu () {
  echo "(i)nstructions"
  echo "(l)evel"
  echo "(q)uit"
}
opts () {
  read -r -p "Select one: " choice
  case $choice in
    "i") instruct ;;
    "l") level_select ;;
    "q") exit 0 ;;
    *) echo -e "${RED}Please select option.${STD}" && sleep 2
  esac
}
level_select () {
  read -r -p "Select a level: " lvl
  case ${lvl#[-+]} in
  *[!0-9]* ) echo "Please select a number from 10-1000" ;;
  * ) len="$lvl" && play ;;
esac
}
instruct () {
  return
}
show_caret() {
    tput el1
    head -c $((2*pos)) /dev/zero | tr '\0' ' '
    echo '^'
}
play () {
  str="$(tr -Cd 'A-Za-z0-9' < /dev/urandom | head -c "$len" | sed -e 's/./& /g')"
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
  echo "You win! Your score is: $1", $score 
}
menu
opts
