#!/bin/bash
#
# benchmarks scripts in this directory
# this assumes you have perl 5.10+ and perl6 on your classpath

for name in grammar roles junctions; do
   echo
   echo $name
   echo
   echo 6
   time perl6 $name.p6 > /dev/null
   echo
   echo 5
   time perl $name.pl > /dev/null
done
