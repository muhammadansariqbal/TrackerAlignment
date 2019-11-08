#!/bin/tcsh

set myDirs=(ReReco)
#set myDirs=(PromptReco)
#set myDirs=(Run2)

#2016
set remote=(/eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2016_RunB_v1 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2016_RunB_v2 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2016_RunC /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2016_RunD /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2016_RunE /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2016_RunF /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2016_RunG /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2016_RunH)

#2017
#set remote=(/eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunA_v1 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunA_v2 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunA_v3 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunB_v1 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunB_v2 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunC_v1 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunC_v2 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunC_v3 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunD /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunE /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunF /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytest2Run2_ReReco_Prompt_2017_RunG /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2017_RunH)

#2018
#set remote=(/eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytest3Run2_ReReco_Prompt_2018_RunA_v1 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2018_RunA_v2 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2018_RunA_v3 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2018_RunB_v1 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2018_RunB_v2 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2018_RunC_v1 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2018_RunC_v2 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_Prompt_2018_RunC_v3 /eos/cms/store/group/alca_trackeralign/tkello/test_out/2016UltraLegacytestRun2_ReReco_v3_Prompt_2018_RunD_v2)

foreach i (`seq $#myDirs`)
    if (! -d ./$myDirs[$i] ) then
        mkdir ./$myDirs[$i]
    else
        echo "$myDirs[$i] already exists!"
    endif
end

foreach j (`seq $#remote`)
    foreach file (`eos ls $remote[$j]`)
        foreach i (`seq $#myDirs`)
            if($file =~ *"$myDirs[$i]"*) then
                if(-f ./$myDirs[$i]/$file) then
                    echo "$file already exists in $myDirs[$i] ---> exiting"
                else
                    echo "copying file $file to $myDirs[$i]"
                    xrdcp root://eoscms.cern.ch/$remote[$j]/$file ./$myDirs[$i]
                endif
            endif
        end
    end
end
