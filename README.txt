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

# Create voms proxy
voms-proxy-init --voms cms

# Run the jobs e.g.
validateAlignments.py -c geometric_comparison.ini -N geometricComparison -m

# Check status
bjobs

# The results are in /afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/results/maiqbal once jobs are finished

