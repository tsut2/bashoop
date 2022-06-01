#!/usr/bin/env bash
declare -i count max=100
source oo.sh

Test_0(){ class "${1}" Object;}

for (( i=0; i<max; i++ )){ eval "Test_$((i+1))(){ class \"\${1}\" Test_${i};}";}

Test_50(){ class "${1}" Test_49 foo;}
Test_50:foo(){ echo "${FUNCNAME[1]} aaa";}

Test_49 testObject49
Test_50 testObject50
Test_51 testObject51

#time for (( i=0; i<max; i++ )){ Test_100 "testObject_${i}";}

testObject49:foo
testObject50:foo
testObject51:foo