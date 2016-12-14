#!/bin/sh

input=$(cat << EOF
eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar
EOF
)

IFS=$'\n'

./code.swift $input

unset IFS