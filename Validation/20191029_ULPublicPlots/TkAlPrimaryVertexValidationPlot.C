
/****************************************
This can be run directly in root, or you
 can run ./TkAlMerge.sh in this directory
****************************************/

//#include "Alignment/OfflineValidation/macros/FitPVResiduals.C"
#include "/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/20191029_ULPublicPlots/PV/FitPVResiduals_v2.C"

void TkAlPrimaryVertexValidationPlot()
{

  // initialize the plot y-axis ranges
  thePlotLimits->init(20,         // mean of dxy vs Phi
                      20,          // mean of dz  vs Phi
                      20,         // mean of dxy vs Eta
                      40,          // mean of dz  vs Eta
                      0.5,     // mean of dxy vs Phi (norm)
                      0.5,      // mean of dz  vs Phi (norm)
                      0.5,     // mean of dxy vs Eta (norm)
                      0.5,      // mean of dz  vs Eta (norm)
                      200,         // width of dxy vs Phi
                      200,          // width of dz  vs Phi
                      200,         // width of dxy vs Eta
                      1200,          // width of dz  vs Eta
                      1.8,     // width of dxy vs Phi (norm)
                      1.8,      // width of dz  vs Phi (norm)
                      1.8,     // width of dxy vs Eta (norm)
                      1.8       // width of dz  vs Eta (norm)
		      );

  loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/PromptRun2.root","PVValidation", "Alignment during data taking", 600, 2101);
  loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/EOYRun2.root","PVValidation", "End-of-year re-reconstruction", 632, 2001);
  loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/ULRun2.root","PVValidation", "Legacy reprocessing", 418, 2301);
  FitPVResiduals("",true,true,"",false);
}
