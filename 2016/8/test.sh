#!/bin/sh

input=$(cat << EOF
rect 3x2
rotate column x=1 by 1
rotate row y=0 by 4
rotate column x=1 by 1
EOF
)

IFS=$'\n'

./code.swift $input

unset IFS