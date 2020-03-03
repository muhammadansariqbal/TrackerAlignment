#include "PlotAlignmentValidation.C"
#include "FWCore/FWLite/interface/FWLiteEnabler.h"

void TkAlExtendedOfflineValidation()
{
  TkAlStyle::legendheader = "";
  TkAlStyle::legendoptions = "Mean RMS";
  TkAlStyle::set(INTERNAL, NONE, "", "");
  bool bigtext = false;
  gStyle->SetTitleH        ( 0.07 );
  gStyle->SetTitleW        ( 1.00 );
  gStyle->SetTitleFont     (  132 );
  // load framework lite just to find the CMSSW libs...
  gSystem->Load("libFWCoreFWLite");
  FWLiteEnabler::enable();

  PlotAlignmentValidation p(bigtext);
  p.loadFileList("root://eoscms//eos/cms/store/group/alca_trackeralign/AlignmentValidation/AlignmentValidation/Run2/DMR_RunA-C_CorrectDatasets_NewNames4Nov/offline_minbias_299062/AlignmentValidation_minbias_PromptReco.root","Alignment during data taking", 600, 2101 );
  p.loadFileList("root://eoscms//eos/cms/store/group/alca_trackeralign/AlignmentValidation/AlignmentValidation/Run2/DMR_RunA-C_CorrectDatasets_NewNames4Nov/offline_minbias_299062/AlignmentValidation_minbias_ReReco.root", "End-of-year re-reconstruction", 632, 2101);
  p.loadFileList("root://eoscms//eos/cms/store/group/alca_trackeralign/AlignmentValidation/AlignmentValidation/Run2/DMR_RunA-C_CorrectDatasets_NewNames4Nov/offline_minbias_299062/AlignmentValidation_minbias_ULRun2.root", "Legacy reprocessing", 418, 2101);
  p.setOutputDir("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/results/maiqbal/ULPrivate/DMR/offline_minbias_299062/ExtendedOfflineValidation_Images");
  p.useFitForDMRplots(true);
  p.setTreeBaseDir("TrackHitFilter");
  p.plotDMR("median,rmsNorm",15,"plain", "15 July 2017 (pp collisions)");
  
  vector<int> moduleids = {};
  for (auto moduleid : moduleids) {
  	p.residual_by_moduleID(moduleid);
  }
}
