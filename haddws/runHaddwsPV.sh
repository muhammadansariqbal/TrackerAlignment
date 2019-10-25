#!/bin/bash
# This is a script to create lumi-weighted combined PV root file for Run 2 representative plot.

# Set the ouput directory here
cd ./
#cd /tmp/maiqbal/

# Set the path to initial root files here
#inputDir=aligncand/
inputDir=/eos/cms/store/group/alca_trackeralign/musich/test_out/2018UltraLegacy2018ABCD_UL/
geometry=PromptGT_

# Lumi lists
lumiList2017="/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/lumiperrun2017.txt"
lumiList2018="/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/lumiperrun2018.txt"

# Strings to input to the adding script
files=""
weights=""

# Calculate the integrated luminosity
numRuns=0
maxRuns=-1
intLumi="0.0"
for filename in $(ls $inputDir | grep $geometry)
do
	runNum=$(echo $filename | cut -d "_" -f3)
	runNum=$(echo $runNum | cut -d "." -f1)
	lumi=$(grep $runNum $lumiList2017 $lumiList2018 | cut -d " " -f2)
	intLumi=$(echo "$intLumi""+""$lumi" | bc -l)

	numRuns=$(($numRuns+1))
	if ([ $numRuns -eq $maxRuns ] && [ $maxRuns -gt 0 ])
	then
		break
	fi
done

echo "===================================="
echo "Number of runs included: ""$numRuns"
echo "Integrated luminosity: ""$intLumi"
echo "===================================="
echo ""

# Loop over the files
numRuns=0
for filename in $(ls $inputDir | grep $geometry)
do
	files="$files""$inputDir""$filename"" "

	runNum=$(echo $filename | cut -d "_" -f3)
        runNum=$(echo $runNum | cut -d "." -f1)
	lumi=$(grep $runNum $lumiList2017 $lumiList2018 | cut -d " " -f2)
	weight=$(echo "$lumi""/""$intLumi" | bc -l)
	weights="$weights""$weight"" "

	numRuns=$(($numRuns+1))
	if ([ $numRuns -eq $maxRuns ] && [ $maxRuns -gt 0 ])
	then
		break
	fi
done

runCmd="/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/haddws ""$files""$weights"
eval "$runCmd"
#echo $runCmd

cd -

