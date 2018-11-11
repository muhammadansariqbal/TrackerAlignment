Steps to Update PCL Thresholds
=============================

# Set up the latest CMSSW version
cmsrel CMSSW_10_4_X_2018-11-07-1100
cd CMSSW_10_4_X_2018-11-07-1100/src/
cmsenv

# Add PCL package
git cms-addpkg CondFormats/PCLConfig

# Build
cd ../..
scramv1 b -j 20

# Update the python config file for the thresholds
cd CondFormats/PCLConfig/python
vi Thresholds_cff.py

# Run CMSSW to generate conditions file, it produces myThresholds.db
cd ../test/
cmsenv
cmsRun AlignPCLThresholdsWriter_cfg.py

# Upload to conddb, upload to tag e.g. PCLThresholds_enhanced_thetaZ_300murad
uploadConditions.py mythresholds.db

# Documentation on how to generate mis-alignment scenarios can be found here.
https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideMisalignmentTools

