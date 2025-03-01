#!/bin/bash

if [ ! -d output ]; then
   mkdir output
fi

for f in theo*; do
   b=$(basename $f)
   echo "$b"
   ./run.sh $f > output/$b.txt
done
