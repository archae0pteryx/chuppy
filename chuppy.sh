#!/bin/bash

pos=0
score=0
clear
#len=10
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
  read -r -p "----->" choice
  case $choice in
    "i") instruct ;;
    "l") level_select ;;
    "q") exit 0 ;;
    *) echo -e "${RED}Please select option.${STD}" && sleep 2
  esac
}
level_select () {
  echo "(e)asy"
  echo "(n)ightmare"
  echo "(q)uit"
  read -r -p "---> " lvl
  case $lvl in
    "e") len=30 && lvl_sec=20 && play ;;
    "n") len=100 && lvl_sec=20 && play ;;
  * ) echo "E.N.or.Q!" ;;
esac
}
instruct () {
  echo "Select your level then try to match each character."
  echo "Fingers on the home keys."
  sleep 2
  menu
  opts
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
  #$pos -lt $len ||
  end=$(($SECONDS+$lvl_sec))
  while [[ $SECONDS -lt $end ]]; do
      read -rsN1 ch
      if [[ $ch ==  "${str:$((2*pos)):1}" ]]; then
          ((score++))
          ((pos++))
          tput cuu1
          show_caret
        elif [[ $pos == $len ]]; then
          echo "Good Job ol Sport!"
          exit 0
        else
          echo "eerrrnnnnt!"
          echo "Your score is:" $score
          exit 0
      fi
  done
  echo "Times UP:" $score
}
menu
opts
