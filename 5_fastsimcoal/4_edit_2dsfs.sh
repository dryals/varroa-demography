#!/bin/bash
cd fastsimcoal

for region in CA MT OR WA
do
	cd $region
	
	#write first line
	echo '1 observations' > $region.obs
	
	#save pop sizes
	S=$(sed -n '$=' ../../pops_bystate/$region.s.txt)
	S=$(($S * 2))
	M=$(sed -n '$=' ../../pops_bystate/$region.m.txt)
	M=$(($M * 2))
	
	#write second line
	echo "2 $S $M " >> $region.obs
	
	#append 2dsfs file
	cat ../../2dsfs/$region.s.sfs >> $region.obs
	
	cd ..

done
