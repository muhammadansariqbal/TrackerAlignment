#!/bin/bash
# This is a script to create lumi-weighted combined DMR root file for Run 2 representative plot.

# Set the ouput directory here
# cd ./
cd /eos/cms/store/group/alca_trackeralign/AlignmentValidation/AlignmentValidation/UL17_UpdatedAPEs/DMRs/

# Set the path to initial root files here
# inputDir=test/
inputDir=/eos/cms/store/group/alca_trackeralign/AlignmentValidation/AlignmentValidation/UL17_UpdatedAPEs/DMRs/

# Lumi lists
lumiList2016="/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/lumiperrun2016.txt"
lumiList2017="/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/lumiperrun2017.txt"
lumiList2018="/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/lumiperrun2018.txt"

# Strings to input to the adding script
files=""
weights=""

# Calculate the integrated luminosity
numRuns=0
maxRuns=-1
intLumi="0.0"
for runDir in $(ls $inputDir | grep offline_minbias)
do
	runNum=${runDir#offline_minbias_}
	lumi=$(grep "$runNum"" " $lumiList2016 $lumiList2017 $lumiList2018 | cut -d " " -f2)
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
for runDir in $(ls $inputDir | grep offline_minbias)
do
	files="$files""$inputDir""$runDir""/AlignmentValidation_minbias_Prompt.root "

	runNum=${runDir#offline_minbias_}
	lumi=$(grep "$runNum"" " $lumiList2016 $lumiList2017 $lumiList2018 | cut -d " " -f2)
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

cd -

