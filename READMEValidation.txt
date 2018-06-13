Useful Links for Alignment Validation
=====================================

# Validation Tool Twiki
https://twiki.cern.ch/twiki/bin/viewauth/CMS/TkAlAllInOneValidation

# Validation Tutorial
https://twiki.cern.ch/twiki/pub/CMS/TkAlAllInOneValidation/validation_tutorial_vbotta.pdf

# Instructions for START-UP 2017 Framework
# See last page of validation tutorial or /afs/cern.ch/user/m/mschrode/CommonValidation/alignmentObjects/STARTUP_2017/STARTUP_2017/README

# Steps to do Alignment Validation
==================================

# Shared Space for Alignment Validation
/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation
# Subfolder alignmentObjects/ contains projects and their folders. Create user directory in it the first time
# Subfolder results/ stores outputs

# Setup suitable CMSSW environment e.g. in CMSSW_10_1_2_patch1/src/
cmsenv
cd ../../alignmentObjects/maiqbal

# Copy and setup the configs to your directory and prepare the dataset
# Dataset can be prepared similar to alignment method (recommended) OR 
# Lookup the data set on DAS e.g. with "dataset=/SingleMu/Run2012D-TkAlMuonIsolated-v1/ALCARECO", and click the "py" option of the dataset. Copy/paste the readFiles.extend to the template file https://twiki.cern.ch/twiki/pub/CMS/TkAlAllInOneValidation/Dataset_template_cff.py.txt.
# Save it in src/Alignment/OfflineValidation/python/ of the CMSSW folder with another name. Compile
scram b -j 8
# Specify the parameter dataset in the .ini file by using the file name without _cff.py. In the case of Dataset_template_cff.py this would be dataset=Dataset_template. Note that events from the beginning of the dataset file are used. If we want to pick the events randomly, we can shuffle the lines of the cff.py file manually. We can use for instance this command: cat myfile | perl -MList::Util=shuffle -e 'print shuffle(<STDIN>);' .

# Add unset module once in ~/.bashrc to avoid some bash syntax errors (once only)

# Create voms proxy
voms-proxy-init --voms cms

# Run the jobs e.g.
validateAlignments.py -c geometry_comparison.ini -N geometryComparison -m

# Check status
bjobs

# The results are in /afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/results/maiqbal once jobs are finished

# Splitting Config Files
========================

# Config files can be split into alignments.ini, out.ini and validation.ini. Then run the jobs by
validateAlignments.py -c alignments.ini,out.ini,validation.ini -N whichValidation -m

# Also for many validations, we can do something like
for i in DMR.ini PV.ini split.ini GC.ini ;do validateAlignments.py -c alignments.ini,out.ini,${i} -N $(basename ${i} .ini) -m;done

