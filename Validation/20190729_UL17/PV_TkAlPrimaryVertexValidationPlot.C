
/****************************************
This can be run directly in root, or you
 can run ./TkAlMerge.sh in this directory
****************************************/

//#include "Alignment/OfflineValidation/macros/FitPVResiduals.C"
#include "/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/20190729_UL17/PV/FitPVResiduals_v2.C"

void TkAlPrimaryVertexValidationPlot()
{

  // initialize the plot y-axis ranges
  thePlotLimits->init(40,         // mean of dxy vs Phi
                      40,          // mean of dz  vs Phi
                      40,         // mean of dxy vs Eta
                      40,          // mean of dz  vs Eta
                      0.5,     // mean of dxy vs Phi (norm)
                      0.5,      // mean of dz  vs Phi (norm)
                      0.5,     // mean of dxy vs Eta (norm)
                      0.5,      // mean of dz  vs Eta (norm)
                      150,         // width of dxy vs Phi
                      150,          // width of dz  vs Phi
                      150,         // width of dxy vs Eta
                      1000,          // width of dz  vs Eta
                      1.8,     // width of dxy vs Phi (norm)
                      1.8,      // width of dz  vs Phi (norm)
                      1.8,     // width of dxy vs Eta (norm)
                      1.8       // width of dz  vs Eta (norm)
		      );

  loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/Prompt2018.root","PVValidation", "Alignment during data taking", 600, 2101);
  loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/ReReco2018.root","PVValidation", "End-of-year re-reconstruction", 632, 2001);
  loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/UL2018.root","PVValidation", "Legacy reprocessing", 418, 2301);
  FitPVResiduals("",true,true,"",false);
}
