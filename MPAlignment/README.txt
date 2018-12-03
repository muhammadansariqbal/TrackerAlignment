Useful Links for Tracker Alignment
==================================

# Tracker Alignment Presentation
https://indico.cern.ch/event/652229/contributions/2654900/attachments/1489162/2337898/kit-align_2017-07-07.pdf

# Twiki Links for MPS
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMillepedeIIProductionEnvironment (Almost always the only one required for the initial setups)
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMillepedeIIAlgorithm
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMillepedeProductionSystem

# Some info on TkAl datasets and their global tags/ CMSSW versions might be found here
https://twiki.cern.ch/twiki/bin/viewauth/CMS/TkAl2018Datasets

# Figuring out global tags (Go to condb links and find relevant records)
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideFrontierConditions#Global_Tags_for_2018_data_taking
# Remember to add the "Rcd" after a record in config files if it is not there on conddb

# Alignment constants and specialized single IOV tags can be found here
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideAlignmentConstants
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideAlignmentConstantsRun2018


# Checking All Permissions
==========================

pts m -nameorid $USER
# Should be member of _CALCA_:ATA


# Steps to do the MPS Alignment
===============================

# CAF Area for MPS Alignment
/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/MP/MPproduction

# Setup suitable CMSSW environment e.g. in CMSSW_10_1_2_patch2/src/
cmsenv

# Prepare dataset file list
# In MPproduction/datasetfiles/Collisions2018/StartUp/ for example
mps_create_file_lists.py -i /StreamExpress/Run2018B-TkAlMinBias-Express-v1/ALCARECO -f 1 -n 99999999999999999999999999 -r --iov 317661

# In MPproduction/
mps_setup_new_align.py -d "Description for the alignment." -t data (-h can be used with all mps commands for help)
# This will create mpXXXX directory and add a line to MP_ali_list.txt

# Copy alignment_config.ini and universalConfigTemplate.py from another alignment if needed and modify them
# See conddb and twiki links above for knowing global tags/ tags to replace in global tags as starting conditions

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
# If we do not want to include some mille jobs or some failed, we can remove binaries and trees from jobData/jobm/alignment_merge.py. In case of failure, we also need to change FAIL to OK in mps.db
mps_fire.py -m (-f to force even if some milli jobs not in OK)

# Fetch pede job
mps_fetch.py

# In case we need more pede jobs, this creates jobm1 etc. based on previous jobm
mps_setupm.pl

