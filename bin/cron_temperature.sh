#!/bin/bash

sensors_output=$(sensors)

tdie=$(echo "$sensors_output" | grep "Tdie:" \
    | sed -E 's/^Tdie:[[:space:]]+\+([0-9.]+).+$/\1/')
tctl=$(echo "$sensors_output" | grep "Tctl:" \
    | sed -E 's/^Tctl:[[:space:]]+\+([0-9.]+).+$/\1/')
tccd1=$(echo "$sensors_output" | grep "Tccd1:" \
    | sed -E 's/^Tccd1:[[:space:]]+\+([0-9.]+).+$/\1/')
tccd2=$(echo "$sensors_output" | grep "Tccd2:" \
    | sed -E 's/^Tccd2:[[:space:]]+\+([0-9.]+).+$/\1/')

echo "$tdie" | tr -d '+' > /tmp/temp0_input
echo "$tctl" | tr -d '+' > /tmp/temp1_input
echo "$tccd1" | tr -d '+' > /tmp/temp2_input
echo "$tccd2" | tr -d '+' > /tmp/temp3_input

exit 0
