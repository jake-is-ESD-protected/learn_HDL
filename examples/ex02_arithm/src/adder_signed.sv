/*#
e.g. signed 4 bit system (min = -8, max = 7):

1011    ->  -5
1100    ->  -4
----
0111    ->   7 WRONG

add additional MSBs set to 1:

1 1011
1 1100
------
1 0111
|-|------------> "1 0" indicates an UNDEFLOW UF

*****************************************************************

0101    ->   5
0011    ->   3
----
1000    ->  -8 WRONG

0 0101
0 0011
------
0 1000
|-|-------------> "0 1" indicates an OVERFLOW OF


*/