
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
                      50,          // mean of dz  vs Eta
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

  int plotSet=4;

  if(plotSet==1) // Full Run 2 representative plots
  {
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/PromptRun2.root","PVValidation", "Alignment during data-taking", 600, 2101);
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/EOYRun2.root","PVValidation", "End-of-year re-reconstruction", 632, 2001);
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/ULRun2.root","PVValidation", "Legacy reprocessing", 418, 2301);
  }

  else if(plotSet==2) // Years comparison prompt
  {
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/Prompt2016.root","PVValidation", "Alignment during data-taking 2016", 616, 2101);
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/Prompt2017.root","PVValidation", "Alignment during data-taking 2017", 802, 2001);
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/Prompt2018.root","PVValidation", "Alignment during data-taking 2018", 436, 2301);
  }

  else if(plotSet==3) // Years comparison EOY
  {
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/EOY2016.root","PVValidation", "End-of-year re-reconstruction 2016", 616, 2101);
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/EOY2017.root","PVValidation", "End-of-year re-reconstruction 2017", 802, 2001);
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/EOY2018.root","PVValidation", "Re-reconstruction 2018", 436, 2301);
  }

  else if(plotSet==4) // Years comparison UL
  {
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/UL2016.root","PVValidation", "Legacy reprocessing 2016", 616, 2101);
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/UL2017.root","PVValidation", "Legacy reprocessing 2017", 802, 2001);
    loadFileList("/afs/cern.ch/cms/CAF/CMSALCA/ALCA_TRACKERALIGN/data/commonValidation/alignmentObjects/maiqbal/haddws/MergedOutputs/UL2018.root","PVValidation", "Legacy reprocessing 2018", 436, 2301);
  }

  FitPVResiduals("",true,true,"",false);

}
