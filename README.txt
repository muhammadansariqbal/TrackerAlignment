Useful Links for Tracker Alignment
==================================

# Tracker Alignment Presentation
https://indico.cern.ch/event/652229/contributions/2654900/attachments/1489162/2337898/kit-align_2017-07-07.pdf

# Twiki Links for MPS
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMillepedeIIProductionEnvironment (Almost always the only one required for the initial setups)
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMillepedeIIAlgorithm
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMillepedeProductionSystem

# CAF Area for MPS Alignment
/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/MP/MPproduction


# Steps to do the MPS Alignment
===============================

# Setup suitable CMSSW environment i.e. in CMSSW_9_2_6/src/
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

