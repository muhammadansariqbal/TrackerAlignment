Useful Links for Tracker Alignment
==================================

# Tracker Alignment Presentation
https://indico.cern.ch/event/652229/contributions/2654900/attachments/1489162/2337898/kit-align_2017-07-07.pdf

# Twiki Links for MPS
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMillepedeIIProductionEnvironment (Almost always the only one required for the initial setups)
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMillepedeIIAlgorithm
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMillepedeProductionSystem

# Validation Tool Twiki
https://twiki.cern.ch/twiki/bin/viewauth/CMS/TkAlAllInOneValidation

# Validation Tutorial
https://twiki.cern.ch/twiki/pub/CMS/TkAlAllInOneValidation/validation_tutorial_vbotta.pdf

# Checking if we have all permissions
pts m -nameorid $USER
# Should be member of _CALCA_:ATA


# Steps to do the MPS Alignment
===============================

# CAF Area for MPS Alignment
/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/MP/MPproduction

# Setup suitable CMSSW environment e.g. in CMSSW_9_2_6/src/
cmsenv

# In MPproduction/
mps_setup_new_align.py -d "Description for the alignment." -t data (-h can be used with all mps commands for help)
# This will create mpXXXX directory and add a line to MP_ali_list.txt
# Copy alignment_config.ini and universalConfigTemplate.py from another alignment if needed and modify them

# Setup jobs for submission
mps_alisetup.py alignment_config.ini

# Check status of jobs at anytime
mps_stat.py

# Stop the job finished email notifications
export LSB_JOB_REPORT_MAIL=N

# Submit and start the milli jobs
mps_fire.py -a

# Fetch milli jobs
mps_fetch.py

# Submit and start the pede job
mps_fire.py -m (-f to force even if some milli jobs not in OK)

# Fetch pede job
mps_fetch.py

# Steps to do Alignment Validation
==================================

# Shared Space for Alignment Validation
/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation
# Subfolder alignmentObjects/ contains projects and their folders. Create user directory in it the first time
# Subfolder results/ stores outputs

# Setup suitable CMSSW environment e.g. in CMSSW_9_2_6/src/
cmsenv
cd ../../alignmentObjects/maiqbal

# Copy and setup the configs to your directory and prepare the data set

# Add unset module once in ~/.bashrc to avoid some bash syntax errors

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

# Preparing Data in the All-In-One Syntax
=========================================

# Lookup the data set on DAS e.g. with "dataset=/SingleMu/Run2012D-TkAlMuonIsolated-v1/ALCARECO", and click the "py" option of the dataset. Copy/paste the readFiles.extend to the template file https://twiki.cern.ch/twiki/pub/CMS/TkAlAllInOneValidation/Dataset_template_cff.py.txt and save it in src/Alignment/OfflineValidation/python/ of the CMSSW folder with another name. Compile
scram b -j 8
# Specify the parameter dataset in the .ini file by using the file name without _cff.py. In the case of Dataset_template_cff.py this would be dataset=Dataset_template. Note that events from the beginning of the dataset file are used. If we want to pick the events randomly, we can shuffle the lines of the cff.py file manually. We can use for instance this command: cat myfile | perl -MList::Util=shuffle -e 'print shuffle(<STDIN>);' .

# Instructions for START-UP 2017 Framework
==========================================

# See last page of validation tutorial or /afs/cern.ch/user/m/mschrode/CommonValidation/alignmentObjects/STARTUP_2017/STARTUP_2017/README

