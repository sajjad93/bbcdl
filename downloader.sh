#!/bin/bash

COUNTER=0
sentinalnum=0
dlcontrol=0;
while [ "$sentinalnum" == 0 ]; do
	COUNTER=$[$COUNTER +1]
	if [ -d unit-$COUNTER ]; then
		echo "this is downloaded"
	else
		proxychains wget -O $COUNTER-source http://www.bbc.co.uk/learningenglish/english/course/lower-intermediate/unit-$COUNTER/downloads
grep -Po '(?<=href=")[^"]*' $COUNTER-source | grep -E '(.mp3|.pdf)' > dl-$COUNTER.txt

	if [ "$dlcontrol" == 1 ]; then
		if [ -s dl-$COUNTER.txt ]; then
		unitnum=$[$COUNTER -1]
		mkdir unit-$unitnum
		proxychains wget -c -i dl-$unitnum.txt -P unit-$unitnum
		dlcontrol=0
		fi
	fi

	if [ -s dl-$COUNTER.txt ]; then
		dlcontrol=1
	else
		sentinalnum=1
		exit
	fi



	fi
done
