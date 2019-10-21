#!/bin/bash
# This is a script to create lumi-weighted combined DMR and PV root file for Run 2 representative plot.

# Set the ouput directory here
# cd ./
cd /eos/cms/store/group/alca_trackeralign/AlignmentValidation/AlignmentValidation/UL17_UpdatedAPEs/DMRs/

# Set the path to initial root files here
# inputDir=test/
inputDir=/eos/cms/store/group/alca_trackeralign/AlignmentValidation/AlignmentValidation/UL17_UpdatedAPEs/DMRs/

# Strings to input to the adding script
files=""
weights=""

# Calculate the integrated luminosity
numRuns="0"
intLumi="0.0"
for runDir in $(ls $inputDir | grep offline_minbias)
do
	numRuns=$(($numRuns+1))
	runNum=${runDir#offline_minbias_}
	lumi=$(grep $runNum lumiperrun2017.txt lumiperrun2018.txt | cut -d " " -f2)
	intLumi=$(echo "$intLumi""+""$lumi" | bc -l)
done

echo "===================================="
echo "Number of runs included: ""$numRuns"
echo "Integrated luminosity: ""$intLumi"
echo "===================================="
echo ""

# Loop over the files
for runDir in $(ls $inputDir | grep offline_minbias)
do
	files="$files""$inputDir""$runDir""/AlignmentValidation_minbias_Prompt.root "

	runNum=${runDir#offline_minbias_}
	lumi=$(grep $runNum lumiperrun2017.txt lumiperrun2018.txt | cut -d " " -f2)
	weight=$(echo "$lumi""/""$intLumi" | bc -l)
	weights="$weights""$weight"" "
done

runCmd="./haddws ""$files""$weights"
eval "$runCmd"

cd -

