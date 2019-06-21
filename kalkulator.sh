#!/usr/bin/env bash

declare -a prvaMatrika
declare -a drugaMatrika
declare -a vel
declare -a rez
vmes=0
operacija="$1"
stevec=0
shift

#zanka, ki shrani velikosti matrik
for i in {0..3}
do
	vel["$i"]="$1"
	shift
done

#zanka, ki shrani vrednosti prve matrika
for (( c=0; c<$((vel[0] * vel[1])); c++ ))
do  
   	prvaMatrika["$c"]="$1"
	shift
done 

#zanka, ki shrani vrednosti drzge matrike
for (( c=0; c<$((vel[2] * vel[3])); c++ ))
do  
   	drugaMatrika["$c"]="$1"
	shift
done 

#if stavek, reverja ali lahko seštejemo matriki(sta enaki v obeh velikosti npr. 2x2 in 2x2)
if [ $operacija = "-plus" ] && [ ${vel[0]} -eq ${vel[2]} ] && [ ${vel[1]} -eq ${vel[3]} ]
then
	#zanka, ji sešteje matriki in vrednosti shrani v array rez
	for (( x=0; x<$((vel[0] * vel[1])); x++ ))
	do
		rez[$x]=$(bc <<< "scale=2;${prvaMatrika[$x]}+${drugaMatrika[$x]}")
	done
#if stavek ,ki preverja ali lahko matriki odštejemo(sta enaki v obeh velikosti npr. 2x2 in 2x2)
elif [ $operacija = "-minus" ] && [ ${vel[0]} -eq ${vel[2]} ] && [ ${vel[1]} -eq ${vel[3]} ]
then
	for (( x=0; x<$((vel[0] * vel[1])); x++ ))
	do
		rez[$x]=$(bc <<< "scale=2;${prvaMatrika[$x]}-${drugaMatrika[$x]}")
	done
#if stavek, ki preveri ali lahko matriki zmnožimo 
elif [ $operacija = "-mno" ] && [ ${vel[1]} -eq ${vel[2]} ]
then
	#zanka, ki skrbi, da se pravilno premikamo po prvi matriki(vrstice)
	for (( x=0; x<${vel[0]}; x++ ))
	do
		#zanka, ki skrbi, da se pravilno pomikamo po elementih prve matrike in po vrsticah druge matrike
		for (( i=0; i<${vel[2]}; i++ ))
		do
			#rez[$((x*vel[0]+i))]=$(bc <<< "scale=2;${prvaMatrika[$((x*vel[1]+pomoc))]}+${drugaMatrika[$((i*(vel[3])+x))]}")
			#zanka, ki skrbi, da se pravilno pomikamo po elementih druge matrike
			for(( j=0; j<${vel[2]}; j++ ))
			do
				#echo "row: ${prvaMatrika[$((x*vel[1]+j))]}"
				#echo "col: ${drugaMatrika[$((j*(vel[2])+i))]}"
				vmes=$(bc <<< "scale=2;$vmes+${prvaMatrika[$((x*vel[1]+j))]}*${drugaMatrika[$((j*(vel[2])+i))]}")
				#echo vmes
			done
			rez[$stevec]=$vmes
			vmes=0
			stevec=$stevec+1
		done
		#echo "v x<-"
	done
fi
	 
#echo ${vel[@]}
#echo ${prvaMatrika[@]}
#echo ${drugaMatrika[@]}
#izpis rezulata
echo "Rezultat ${rez[@]}"
