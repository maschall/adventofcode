#!/bin/sh

input=$(cat << EOF
(3x3)XYZ
EOF
)

IFS=$'\n'

./code.swift $input

unset IFS