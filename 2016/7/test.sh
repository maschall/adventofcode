#!/bin/sh

input=$(cat << EOF
abba[mnop]qrst
abcd[bddb]xyyx
aaaa[qwer]tyui
ioxxoj[asdfgh]zxcvbn

aba[bab]xyz
xyx[xyx]xyx
aaa[kek]eke
zazbz[bzb]cdb
EOF
)

IFS=$'\n'

./code.swift $input

unset IFS