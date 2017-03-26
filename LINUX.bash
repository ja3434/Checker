#! /bin/bash

var=0
bledne=0
srednia=0
ilosc=100
iltak=0

while [ $var -lt $ilosc ];do
	
	touch test.in
	touch test.out
	touch brut.out
	./gen  > test.in
	./brut < test.in >brut.out
	start=$(date +%s%N)
	./wzor < test.in >test.out
	end=$(date +%s%N)

	let mierzset=end-start
	mierzset=$(($mierzset/10000000))
	let srednia=srednia+mierzset
	mierzsek=$(($mierzset/100))
	mierzset=$(($mierzset % 100))
	mierzdzies=$(($mierzset /10))
	mierzset=$(($mierzset % 10))
	touch smiec.txt
	if  cmp test.out brut.out > ruzn.txt;then
		
		echo Test $var.	Wynik OK   czas $mierzsek.$mierzdzies$mierzset	blendy $bledne
			
	else
		echo Test $var.	Wynik blad czas $mierzsek.$mierzdzies$mierzset
		let bledne=bledne+1
		touch blad$bledne.txt
		cp test.in blad$bledne.txt
		touch wyj$bledne.txt
		touch bru$bledne.txt
		cp test.out wyj$bledne.txt
		cp brut.out bru$bledne.txt
		break
	
		
	fi
	rm smiec.txt
	rm test.in
	rm test.out
	rm brut.out
	let var=var+1
done

let srednia=srednia/$ilosc
srsek=$((srednia/100))
srdzies=$(( (srednia%100)/10 ))
srednia=$((srednia%10))


if [ $bledne -gt 0 ]; then
	echo Wykryto $bledne bledow  srednia czasu $srsek.$srdzies$srednia
else 
	echo Wszystko ok srednia czasu $srsek.$srdzies$srednia 
fi
