clear
set more off

cd"/Volumes/Tingsi Wang/Third chap/Data from SUFE/Process data"

******************************************
*						     *
* STAGE 1: Match Two Consecutive Years *
*						     *
****************************************** 
local i = 1998
  while `i' < 2007{
  
  
  local j=`i'+1


**step 10: match by firm ID**

*deal with duplicates of IDs (there are a few firms that have same IDs)*
use m`i'.10.dta, clear
bysort id_`i': keep if _N>1
save duplicates_ID`i'.dta, replace

use m`i'.10.dta, clear
bysort id_`i': drop if _N>1
rename id_`i' id

keep id name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'

sort id
save match`i'.1.dta, replace

use m`j'.10.dta, clear
bysort id_`j': keep if _N>1
save duplicates_ID`j'.dta, replace

use m`j'.10.dta, clear
bysort id_`j': drop if _N>1
rename id_`j' id
keep id name_`j' legalperson_`j' telephone_`j' zip_`j' cic_`j' type_`j' employment_`j' output_`j' salesoutput_`j' export_`j' valueadded_`j' ownership_`j' startyear_`j' inventory_`j' total_liabilities_`j' ownerequity_`j' paidupcap_`j' state_`j' collective_`j' legal_person_`j' individual_`j' HMT_`j' foreign_`j' newoutput_`j' salesrev_`j' wage_`j' mainwage_`j' welfare_`j' mainwelfare_`j' operprofit_`j' valueaddedtax_`j' inputtax_`j' outputtax_`j' inputs_`j' subsidy_`j' cic_adj_`j' OutputDefl_`j' routput_`j' deflator_input_`j' rinput_`j' realcap_`j' province_`j' industry_`j' code_`j' cic2_`j' expdummy_`j' wagebill_`j' wagebillr_`j' q_`j' k_`j' l_`j' m_`j' rva_`j' qva_`j' io_`j'  lols_`j' iols_`j' cols_`j' constant_`j' tfp_`j' markup_`j' markup2_`j' markup3_`j' vaiols_`j' valols_`j' vacols_`j' vatfp_`j' vamarkup_`j' vamarkup2_`j' vamarkup3_`j'
sort id
save match`j'.1.dta, replace

use match`i'.1.dta, clear
merge id using match`j'.1.dta
keep if _merge==3
gen id_`i'=id
rename id id_`j'
drop _merge
gen match_method_`i'_`j'="ID"
gen match_status_`i'_`j'="3"
save matched_by_ID`i'_`j'.dta, replace



**step 20: match by firm names**

*match those unmatched firms in previous step by firm names*

use match`i'.1.dta, clear
merge id using match`j'.1.dta
keep if _merge==1
rename id id_`i'
append using duplicates_ID`i'.dta
bysort name_`i': keep if _N>1
keep id_`i' name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
save duplicates_name`i'.dta, replace

use match`i'.1.dta, clear
merge id using match`j'.1.dta
keep if _merge==1
rename id id_`i'
append using duplicates_ID`i'.dta
bysort name_`i': drop if _N>1
rename name_`i' name
sort name
keep id_`i' name legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
save unmatched_by_ID`i'.dta, replace

use match`i'.1.dta, clear
merge id using match`j'.1.dta
keep if _merge==2
rename id id_`j'
append using duplicates_ID`j'.dta
bysort name_`j': keep if _N>1
keep id_`j' name_`j' legalperson_`j' telephone_`j' zip_`j' cic_`j' type_`j' employment_`j' output_`j' salesoutput_`j' export_`j' valueadded_`j' ownership_`j' startyear_`j' inventory_`j' total_liabilities_`j' ownerequity_`j' paidupcap_`j' state_`j' collective_`j' legal_person_`j' individual_`j' HMT_`j' foreign_`j' newoutput_`j' salesrev_`j' wage_`j' mainwage_`j' welfare_`j' mainwelfare_`j' operprofit_`j' valueaddedtax_`j' inputtax_`j' outputtax_`j' inputs_`j' subsidy_`j' cic_adj_`j' OutputDefl_`j' routput_`j' deflator_input_`j' rinput_`j' realcap_`j' province_`j' industry_`j' code_`j' cic2_`j' expdummy_`j' wagebill_`j' wagebillr_`j' q_`j' k_`j' l_`j' m_`j' rva_`j' qva_`j' io_`j'  lols_`j' iols_`j' cols_`j' constant_`j' tfp_`j' markup_`j' markup2_`j' markup3_`j' vaiols_`j' valols_`j' vacols_`j' vatfp_`j' vamarkup_`j' vamarkup2_`j' vamarkup3_`j'
save duplicates_name`j'.dta, replace

use match`i'.1.dta, clear
merge id using match`j'.1.dta
keep if _merge==2
rename id id_`j'
append using duplicates_ID`j'.dta
bysort name_`j': drop if _N>1
rename name_`j' name
sort name
keep id_`j' name legalperson_`j' telephone_`j' zip_`j' cic_`j' type_`j' employment_`j' output_`j' salesoutput_`j' export_`j' valueadded_`j' ownership_`j' startyear_`j' inventory_`j' total_liabilities_`j' ownerequity_`j' paidupcap_`j' state_`j' collective_`j' legal_person_`j' individual_`j' HMT_`j' foreign_`j' newoutput_`j' salesrev_`j' wage_`j' mainwage_`j' welfare_`j' mainwelfare_`j' operprofit_`j' valueaddedtax_`j' inputtax_`j' outputtax_`j' inputs_`j' subsidy_`j' cic_adj_`j' OutputDefl_`j' routput_`j' deflator_input_`j' rinput_`j' realcap_`j' province_`j' industry_`j' code_`j' cic2_`j' expdummy_`j' wagebill_`j' wagebillr_`j' q_`j' k_`j' l_`j' m_`j' rva_`j' qva_`j' io_`j'  lols_`j' iols_`j' cols_`j' constant_`j' tfp_`j' markup_`j' markup2_`j' markup3_`j' vaiols_`j' valols_`j' vacols_`j' vatfp_`j' vamarkup_`j' vamarkup2_`j' vamarkup3_`j'
save unmatched_by_ID`j'.dta, replace

use unmatched_by_ID`i'.dta, clear
merge name using unmatched_by_ID`j'.dta
keep if _merge==3
gen name_`i'=name
rename name name_`j'
drop _merge
gen match_method_`i'_`j'="firm name"
gen match_status_`i'_`j'="3"
save matched_by_name`i'_`j'.dta, replace



**step 30: match by the names of legal person representatives**

*match those unmatched firms in previous steps by firm legal person representatives*

use unmatched_by_ID`i'.dta, clear
merge name using unmatched_by_ID`j'.dta
keep if _merge==1
rename name name_`i'
append using duplicates_name`i'.dta
replace legalperson_`i'="." if legalperson_`i'==""
gen code1=legalperson_`i'+province_`i'
bysort code1: keep if _N>1
keep id_`i' name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
save duplicates_code1_`i'.dta, replace

use unmatched_by_ID`i'.dta, clear
merge name using unmatched_by_ID`j'.dta
keep if _merge==1
rename name name_`i'
append using duplicates_name`i'.dta
replace legalperson_`i'="." if legalperson_`i'==""
gen code1=legalperson_`i'+province_`i'
bysort code1: drop if _N>1
sort code1
keep code1 id_`i' name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
save unmatched_by_ID_and_name`i'.dta, replace

use unmatched_by_ID`i'.dta, clear
merge name using unmatched_by_ID`j'.dta
keep if _merge==2
rename name name_`j'
append using duplicates_name`j'.dta
gen code1=legalperson_`j'+province_`j'
bysort code1: keep if _N>1
keep id_`j' name_`j' legalperson_`j' telephone_`j' zip_`j' cic_`j' type_`j' employment_`j' output_`j' salesoutput_`j' export_`j' valueadded_`j' ownership_`j' startyear_`j' inventory_`j' total_liabilities_`j' ownerequity_`j' paidupcap_`j' state_`j' collective_`j' legal_person_`j' individual_`j' HMT_`j' foreign_`j' newoutput_`j' salesrev_`j' wage_`j' mainwage_`j' welfare_`j' mainwelfare_`j' operprofit_`j' valueaddedtax_`j' inputtax_`j' outputtax_`j' inputs_`j' subsidy_`j' cic_adj_`j' OutputDefl_`j' routput_`j' deflator_input_`j' rinput_`j' realcap_`j' province_`j' industry_`j' code_`j' cic2_`j' expdummy_`j' wagebill_`j' wagebillr_`j' q_`j' k_`j' l_`j' m_`j' rva_`j' qva_`j' io_`j'  lols_`j' iols_`j' cols_`j' constant_`j' tfp_`j' markup_`j' markup2_`j' markup3_`j' vaiols_`j' valols_`j' vacols_`j' vatfp_`j' vamarkup_`j' vamarkup2_`j' vamarkup3_`j'
save duplicates_code1_`j'.dta, replace

use unmatched_by_ID`i'.dta, clear
merge name using unmatched_by_ID`j'.dta
keep if _merge==2
rename name name_`j'
append using duplicates_name`j'.dta
gen code1=legalperson_`j'+province_`j'
bysort code1: drop if _N>1
sort code1
keep code1 id_`j' name_`j' legalperson_`j' telephone_`j' zip_`j' cic_`j' type_`j' employment_`j' output_`j' salesoutput_`j' export_`j' valueadded_`j' ownership_`j' startyear_`j' inventory_`j' total_liabilities_`j' ownerequity_`j' paidupcap_`j' state_`j' collective_`j' legal_person_`j' individual_`j' HMT_`j' foreign_`j' newoutput_`j' salesrev_`j' wage_`j' mainwage_`j' welfare_`j' mainwelfare_`j' operprofit_`j' valueaddedtax_`j' inputtax_`j' outputtax_`j' inputs_`j' subsidy_`j' cic_adj_`j' OutputDefl_`j' routput_`j' deflator_input_`j' rinput_`j' realcap_`j' province_`j' industry_`j' code_`j' cic2_`j' expdummy_`j' wagebill_`j' wagebillr_`j' q_`j' k_`j' l_`j' m_`j' rva_`j' qva_`j' io_`j'  lols_`j' iols_`j' cols_`j' constant_`j' tfp_`j' markup_`j' markup2_`j' markup3_`j' vaiols_`j' valols_`j' vacols_`j' vatfp_`j' vamarkup_`j' vamarkup2_`j' vamarkup3_`j'
save unmatched_by_ID_and_name`j'.dta, replace

use unmatched_by_ID_and_name`i'.dta, clear
display _N
merge code1 using unmatched_by_ID_and_name`j'.dta
keep if _merge==3
drop _merge code1
gen match_method_`i'_`j'="legal person"
gen match_status_`i'_`j'="3"
save matched_by_legalperson`i'_`j'.dta, replace



**step 40: match by phone number + city code**

*match those unmatched firms in previous steps by phone number + city code*

use unmatched_by_ID_and_name`i'.dta, clear
merge code1 using unmatched_by_ID_and_name`j'.dta
keep if _merge==1
drop code1
append using duplicates_code1_`i'
replace telephone_`i'="." if telephone_`i'==""
gen code2=code_`i'+telephone_`i'
bysort code2: keep if _N>1
keep id_`i' name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
save duplicates_code2_`i'.dta, replace

use unmatched_by_ID_and_name`i'.dta, clear
merge code1 using unmatched_by_ID_and_name`j'.dta
keep if _merge==1
drop code1
append using duplicates_code1_`i'
replace telephone_`i'="." if telephone_`i'==""
gen code2=code_`i'+telephone_`i'
bysort code2: drop if _N>1
sort code2
keep code2 id_`i' name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
save unmatched_by_ID_and_name_and_legalperson`i'.dta, replace


use unmatched_by_ID_and_name`i'.dta, clear
merge code1 using unmatched_by_ID_and_name`j'.dta
keep if _merge==2
drop code1
append using duplicates_code1_`j'
gen code2=code_`j'+telephone_`j'
bysort code2: keep if _N>1
keep id_`j' name_`j' legalperson_`j' telephone_`j' zip_`j' cic_`j' type_`j' employment_`j' output_`j' salesoutput_`j' export_`j' valueadded_`j' ownership_`j' startyear_`j' inventory_`j' total_liabilities_`j' ownerequity_`j' paidupcap_`j' state_`j' collective_`j' legal_person_`j' individual_`j' HMT_`j' foreign_`j' newoutput_`j' salesrev_`j' wage_`j' mainwage_`j' welfare_`j' mainwelfare_`j' operprofit_`j' valueaddedtax_`j' inputtax_`j' outputtax_`j' inputs_`j' subsidy_`j' cic_adj_`j' OutputDefl_`j' routput_`j' deflator_input_`j' rinput_`j' realcap_`j' province_`j' industry_`j' code_`j' cic2_`j' expdummy_`j' wagebill_`j' wagebillr_`j' q_`j' k_`j' l_`j' m_`j' rva_`j' qva_`j' io_`j'  lols_`j' iols_`j' cols_`j' constant_`j' tfp_`j' markup_`j' markup2_`j' markup3_`j' vaiols_`j' valols_`j' vacols_`j' vatfp_`j' vamarkup_`j' vamarkup2_`j' vamarkup3_`j'
save duplicates_code2_`j'.dta, replace

use unmatched_by_ID_and_name`i'.dta, clear
merge code1 using unmatched_by_ID_and_name`j'.dta
keep if _merge==2
drop code1
append using duplicates_code1_`j'
gen code2=code_`j'+telephone_`j'
bysort code2: drop if _N>1
sort code2
keep code2 id_`j' name_`j' legalperson_`j' telephone_`j' zip_`j' cic_`j' type_`j' employment_`j' output_`j' salesoutput_`j' export_`j' valueadded_`j' ownership_`j' startyear_`j' inventory_`j' total_liabilities_`j' ownerequity_`j' paidupcap_`j' state_`j' collective_`j' legal_person_`j' individual_`j' HMT_`j' foreign_`j' newoutput_`j' salesrev_`j' wage_`j' mainwage_`j' welfare_`j' mainwelfare_`j' operprofit_`j' valueaddedtax_`j' inputtax_`j' outputtax_`j' inputs_`j' subsidy_`j' cic_adj_`j' OutputDefl_`j' routput_`j' deflator_input_`j' rinput_`j' realcap_`j' province_`j' industry_`j' code_`j' cic2_`j' expdummy_`j' wagebill_`j' wagebillr_`j' q_`j' k_`j' l_`j' m_`j' rva_`j' qva_`j' io_`j'  lols_`j' iols_`j' cols_`j' constant_`j' tfp_`j' markup_`j' markup2_`j' markup3_`j' vaiols_`j' valols_`j' vacols_`j' vatfp_`j' vamarkup_`j' vamarkup2_`j' vamarkup3_`j'
save unmatched_by_ID_and_name_and_legalperson`j'.dta, replace

use unmatched_by_ID_and_name_and_legalperson`i'.dta,clear
merge code2 using unmatched_by_ID_and_name_and_legalperson`j'.dta
keep if _merge==3
drop _merge code2
gen match_method_`i'_`j'="phone number"
gen match_status_`i'_`j'="3"
save matched_by_phone`i'_`j'.dta, replace



**step 50: merge the matched and unmatched files to create files of two consecutive years**

use matched_by_ID`i'_`j'.dta, clear
append using matched_by_name`i'_`j'.dta
append using matched_by_legalperson`i'_`j'.dta
append using matched_by_phone`i'_`j'.dta
save m`i'-m`j'.dta, replace


local i = `i' + 1
  }

  
  
  
  
  
  
  
  
******************************************
*						     *
* STAGE 2: Match Three Consecutive Years *
*						     *
******************************************



local i = 1998
  while `i' < 2006{

  local j=`i'+1
  local k=`i'+2


**step 70: create a three-year balanced sample**

use m`i'-m`j'.dta, clear
keep if match_status_`i'_`j'=="1"
keep id_`i' name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
save unmatched`i'.10.dta, replace

use m`i'-m`j'.dta, clear
drop if match_status_`i'_`j'=="1"
gen ccode=id_`j'+string(salesrev_`j')+string(employment_`j')+string(operprofit_`j')
sort ccode
save m`i'-m`j'.10.dta, replace

use m`j'-m`k'.dta, clear
keep if match_status_`j'_`k'=="2"
keep id_`k' name_`k' legalperson_`k' telephone_`k' zip_`k' cic_`k' type_`k' employment_`k' output_`k' salesoutput_`k' export_`k' valueadded_`k' ownership_`k' startyear_`k' inventory_`k' total_liabilities_`k' ownerequity_`k' paidupcap_`k' state_`k' collective_`k' legal_person_`k' individual_`k' HMT_`k' foreign_`k' newoutput_`k' salesrev_`k' wage_`k' mainwage_`k' welfare_`k' mainwelfare_`k' operprofit_`k' valueaddedtax_`k' inputtax_`k' outputtax_`k' inputs_`k' subsidy_`k' cic_adj_`k' OutputDefl_`k' routput_`k' deflator_input_`k' rinput_`k' realcap_`k' province_`k' industry_`k' code_`k' cic2_`k' expdummy_`k' wagebill_`k' wagebillr_`k' q_`k' k_`k' l_`k' m_`k' rva_`k' qva_`k' io_`k'  lols_`k' iols_`k' cols_`k' constant_`k' tfp_`k' markup_`k' markup2_`k' markup3_`k' vaiols_`k' valols_`k' vacols_`k' vatfp_`k' vamarkup_`k' vamarkup2_`k' vamarkup3_`k'
save unmatched`k'.10.dta, replace

use m`j'-m`k'.dta, clear
drop if match_status_`j'_`k'=="2"
gen ccode=id_`j'+string(salesrev_`j')+string(employment_`j')+string(operprofit_`j')
sort ccode
save m`j'-m`k'.10.dta, replace

use m`i'-m`j'.10.dta, clear
merge ccode using m`j'-m`k'.10.dta
drop _merge ccode
keep if  match_status_`i'_`j'=="3"& match_status_`j'_`k'=="3"
gen match_status_`i'_`k'="3"
gen match_method_`i'_`k'="`j'"
save balanced.m`i'-m`j'-m`k'.dta, replace



**step 80: create files for unmatched `i' firms and `k' firms**


use m`i'-m`j'.10.dta, clear
merge ccode using m`j'-m`k'.10.dta
drop _merge ccode
drop if  match_status_`i'_`j'=="3"& match_status_`j'_`k'=="3"
drop if id_`i'==""
gen ccode=id_`i'+string(salesrev_`i')+string(employment_`i')+string(operprofit_`i')
sort ccode
save unmatched`i'.15.dta, replace

use unmatched`i'.15.dta, clear
keep id_`i' name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
append using unmatched`i'.10.dta
save unmatched`i'.20.dta, replace


use m`i'-m`j'.10.dta, clear
merge ccode using m`j'-m`k'.10.dta
drop _merge ccode
drop if  match_status_`i'_`j'=="3"& match_status_`j'_`k'=="3"
drop if id_`k'==""
gen ccode=id_`k'+string(salesrev_`k')+string(employment_`k')+string(operprofit_`k')
sort ccode
save unmatched`k'.15.dta, replace

use unmatched`k'.15.dta, clear
keep id_`k' name_`k' legalperson_`k' telephone_`k' zip_`k' cic_`k' type_`k' employment_`k' output_`k' salesoutput_`k' export_`k' valueadded_`k' ownership_`k' startyear_`k' inventory_`k' total_liabilities_`k' ownerequity_`k' paidupcap_`k' state_`k' collective_`k' legal_person_`k' individual_`k' HMT_`k' foreign_`k' newoutput_`k' salesrev_`k' wage_`k' mainwage_`k' welfare_`k' mainwelfare_`k' operprofit_`k' valueaddedtax_`k' inputtax_`k' outputtax_`k' inputs_`k' subsidy_`k' cic_adj_`k' OutputDefl_`k' routput_`k' deflator_input_`k' rinput_`k' realcap_`k' province_`k' industry_`k' code_`k' cic2_`k' expdummy_`k' wagebill_`k' wagebillr_`k' q_`k' k_`k' l_`k' m_`k' rva_`k' qva_`k' io_`k'  lols_`k' iols_`k' cols_`k' constant_`k' tfp_`k' markup_`k' markup2_`k' markup3_`k' vaiols_`k' valols_`k' vacols_`k' vatfp_`k' vamarkup_`k' vamarkup2_`k' vamarkup3_`k'
append using unmatched`k'.10.dta
save unmatched`k'.20.dta, replace

use m`i'-m`j'.10.dta, clear
merge ccode using m`j'-m`k'.10.dta
drop _merge ccode
drop if  match_status_`i'_`j'=="3"| match_status_`j'_`k'=="3"
gen ccode=id_`j'+string(salesrev_`j')+string(employment_`j')+string(operprofit_`j')
sort ccode
save unmatched`j'.15.dta, replace



**step 90: match `i' firms and `k' firms by firm ID and name**


*ID*

use unmatched`i'.20.dta, clear
bysort id_`i': keep if _N>1
save duplicates_ID`i'.dta, replace

use unmatched`i'.20.dta, clear
bysort id_`i': drop if _N>1
rename id_`i' id
keep id name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
sort id
save match`i'.1.dta, replace

use unmatched`k'.20.dta, clear
bysort id_`k': keep if _N>1
save duplicates_ID`k'.dta, replace

use unmatched`k'.20.dta, clear
bysort id_`k': drop if _N>1
rename id_`k' id
keep id name_`k' legalperson_`k' telephone_`k' zip_`k' cic_`k' type_`k' employment_`k' output_`k' salesoutput_`k' export_`k' valueadded_`k' ownership_`k' startyear_`k' inventory_`k' total_liabilities_`k' ownerequity_`k' paidupcap_`k' state_`k' collective_`k' legal_person_`k' individual_`k' HMT_`k' foreign_`k' newoutput_`k' salesrev_`k' wage_`k' mainwage_`k' welfare_`k' mainwelfare_`k' operprofit_`k' valueaddedtax_`k' inputtax_`k' outputtax_`k' inputs_`k' subsidy_`k' cic_adj_`k' OutputDefl_`k' routput_`k' deflator_input_`k' rinput_`k' realcap_`k' province_`k' industry_`k' code_`k' cic2_`k' expdummy_`k' wagebill_`k' wagebillr_`k' q_`k' k_`k' l_`k' m_`k' rva_`k' qva_`k' io_`k'  lols_`k' iols_`k' cols_`k' constant_`k' tfp_`k' markup_`k' markup2_`k' markup3_`k' vaiols_`k' valols_`k' vacols_`k' vatfp_`k' vamarkup_`k' vamarkup2_`k' vamarkup3_`k'
sort id
save match`k'.1.dta, replace

use match`i'.1.dta, clear
merge id using match`k'.1.dta
keep if _merge==3
gen id_`i'=id
rename id id_`k'
drop _merge
gen match_method_`i'_`k'="ID"
gen match_status_`i'_`k'="3"
save matched_by_ID`i'_`k'.dta, replace

*name*

use match`i'.1.dta, clear
merge id using match`k'.1.dta
keep if _merge==1
rename id id_`i'
append using duplicates_ID`i'.dta
bysort name_`i': keep if _N>1
keep id_`i' name_`i' legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
save duplicates_name`i'.dta, replace

use match`i'.1.dta, clear
merge id using match`k'.1.dta
keep if _merge==1
rename id id_`i'
append using duplicates_ID`i'.dta
bysort name_`i': drop if _N>1
rename name_`i' name
sort name
keep id_`i' name legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
save unmatched_by_ID`i'.dta, replace

use match`i'.1.dta, clear
merge id using match`k'.1.dta
keep if _merge==2
rename id id_`k'
append using duplicates_ID`k'.dta
bysort name_`k': keep if _N>1
keep id_`k' name_`k' legalperson_`k' telephone_`k' zip_`k' cic_`k' type_`k' employment_`k' output_`k' salesoutput_`k' export_`k' valueadded_`k' ownership_`k' startyear_`k' inventory_`k' total_liabilities_`k' ownerequity_`k' paidupcap_`k' state_`k' collective_`k' legal_person_`k' individual_`k' HMT_`k' foreign_`k' newoutput_`k' salesrev_`k' wage_`k' mainwage_`k' welfare_`k' mainwelfare_`k' operprofit_`k' valueaddedtax_`k' inputtax_`k' outputtax_`k' inputs_`k' subsidy_`k' cic_adj_`k' OutputDefl_`k' routput_`k' deflator_input_`k' rinput_`k' realcap_`k' province_`k' industry_`k' code_`k' cic2_`k' expdummy_`k' wagebill_`k' wagebillr_`k' q_`k' k_`k' l_`k' m_`k' rva_`k' qva_`k' io_`k'  lols_`k' iols_`k' cols_`k' constant_`k' tfp_`k' markup_`k' markup2_`k' markup3_`k' vaiols_`k' valols_`k' vacols_`k' vatfp_`k' vamarkup_`k' vamarkup2_`k' vamarkup3_`k'
save duplicates_name`k'.dta, replace

use match`i'.1.dta, clear
merge id using match`k'.1.dta
keep if _merge==2
rename id id_`k'
append using duplicates_ID`k'.dta
bysort name_`k': drop if _N>1
rename name_`k' name
sort name
keep id_`k' name legalperson_`k' telephone_`k' zip_`k' cic_`k' type_`k' employment_`k' output_`k' salesoutput_`k' export_`k' valueadded_`k' ownership_`k' startyear_`k' inventory_`k' total_liabilities_`k' ownerequity_`k' paidupcap_`k' state_`k' collective_`k' legal_person_`k' individual_`k' HMT_`k' foreign_`k' newoutput_`k' salesrev_`k' wage_`k' mainwage_`k' welfare_`k' mainwelfare_`k' operprofit_`k' valueaddedtax_`k' inputtax_`k' outputtax_`k' inputs_`k' subsidy_`k' cic_adj_`k' OutputDefl_`k' routput_`k' deflator_input_`k' rinput_`k' realcap_`k' province_`k' industry_`k' code_`k' cic2_`k' expdummy_`k' wagebill_`k' wagebillr_`k' q_`k' k_`k' l_`k' m_`k' rva_`k' qva_`k' io_`k'  lols_`k' iols_`k' cols_`k' constant_`k' tfp_`k' markup_`k' markup2_`k' markup3_`k' vaiols_`k' valols_`k' vacols_`k' vatfp_`k' vamarkup_`k' vamarkup2_`k' vamarkup3_`k'

compress
save unmatched_by_ID`k'.dta, replace

use unmatched_by_ID`i'.dta, clear
merge name using unmatched_by_ID`k'.dta
keep if _merge==3
gen name_`i'=name
rename name name`k'
drop _merge
gen match_method_`i'_`k'="firm name"
gen match_status_`i'_`k'="3"
compress
save matched_by_name`i'_`k'.dta, replace


use unmatched_by_ID`i'.dta, clear
merge name using unmatched_by_ID`k'.dta
keep if _merge==1
rename name name`i'
keep id_`i' name legalperson_`i' telephone_`i' zip_`i' cic_`i' type_`i' employment_`i' output_`i' salesoutput_`i' export_`i' valueadded_`i' ownership_`i' startyear_`i' inventory_`i' total_liabilities_`i' ownerequity_`i' paidupcap_`i' state_`i' collective_`i' legal_person_`i' individual_`i' HMT_`i' foreign_`i' newoutput_`i' salesrev_`i' wage_`i' mainwage_`i' welfare_`i' mainwelfare_`i' operprofit_`i' valueaddedtax_`i' inputtax_`i' outputtax_`i' inputs_`i' subsidy_`i' cic_adj_`i' OutputDefl_`i' routput_`i' deflator_input_`i' rinput_`i' realcap_`i' province_`i' industry_`i' code_`i' cic2_`i' expdummy_`i' wagebill_`i' wagebillr_`i' q_`i' k_`i' l_`i' m_`i' rva_`i' qva_`i' io_`i'  lols_`i' iols_`i' cols_`i' constant_`i' tfp_`i' markup_`i' markup2_`i' markup3_`i' vaiols_`i' valols_`i' vacols_`i' vatfp_`i' vamarkup_`i' vamarkup2_`i' vamarkup3_`i'
append using duplicates_name`i'.dta
gen match_method_`i'_`k'=""
gen match_status_`i'_`k'="1"
compress
save unmatched_by_ID_and_name_`i'.dta, replace

use unmatched_by_ID`i'.dta, clear
merge name using unmatched_by_ID`k'.dta
keep if _merge==2
rename name name_`k'
keep id_`k' name_`k' legalperson_`k' telephone_`k' zip_`k' cic_`k' type_`k' employment_`k' output_`k' salesoutput_`k' export_`k' valueadded_`k' ownership_`k' startyear_`k' inventory_`k' total_liabilities_`k' ownerequity_`k' paidupcap_`k' state_`k' collective_`k' legal_person_`k' individual_`k' HMT_`k' foreign_`k' newoutput_`k' salesrev_`k' wage_`k' mainwage_`k' welfare_`k' mainwelfare_`k' operprofit_`k' valueaddedtax_`k' inputtax_`k' outputtax_`k' inputs_`k' subsidy_`k' cic_adj_`k' OutputDefl_`k' routput_`k' deflator_input_`k' rinput_`k' realcap_`k' province_`k' industry_`k' code_`k' cic2_`k' expdummy_`k' wagebill_`k' wagebillr_`k' q_`k' k_`k' l_`k' m_`k' rva_`k' qva_`k' io_`k'  lols_`k' iols_`k' cols_`k' constant_`k' tfp_`k' markup_`k' markup2_`k' markup3_`k' vaiols_`k' valols_`k' vacols_`k' vatfp_`k' vamarkup_`k' vamarkup2_`k' vamarkup3_`k'
append using duplicates_name`k'.dta
gen match_method_`i'_`k'=""
gen match_status_`i'_`k'="2"
compress
save unmatched_by_ID_and_name_`k'.dta, replace



**step 100: merge the files**

use matched_by_ID`i'_`k'.dta, clear
append using matched_by_name`i'_`k'.dta
append using unmatched_by_ID_and_name_`i'.dta
append using unmatched_by_ID_and_name_`k'.dta
save m`i'-m`k'.dta, replace

use m`i'-m`k'.dta, clear
gen ccode=id_`i'+string(salesrev_`i')+string(employment_`i')+string(operprofit_`i')
sort ccode
merge ccode using unmatched`i'.15.dta
drop ccode _merge
sort id_`i'
compress
save m`i'-m`k'.05.dta, replace

*deal with disagreement (_merge==5 if "update" is used)*

use m`i'-m`k'.05.dta, clear
gen ccode=id_`k'+string(salesrev_`k')+string(employment_`k')+string(operprofit_`k')
sort ccode
merge ccode using unmatched`k'.15.dta, update
keep if _merge==5
drop id_`k' name_`k' legalperson_`k' telephone_`k' zip_`k' cic_`k' type_`k' employment_`k' output_`k' salesoutput_`k' export_`k' valueadded_`k' ownership_`k' startyear_`k' inventory_`k' total_liabilities_`k' ownerequity_`k' paidupcap_`k' state_`k' collective_`k' legal_person_`k' individual_`k' HMT_`k' foreign_`k' newoutput_`k' salesrev_`k' wage_`k' mainwage_`k' welfare_`k' mainwelfare_`k' operprofit_`k' valueaddedtax_`k' inputtax_`k' outputtax_`k' inputs_`k' subsidy_`k' cic_adj_`k' OutputDefl_`k' routput_`k' deflator_input_`k' rinput_`k' realcap_`k' province_`k' industry_`k' code_`k' cic2_`k' expdummy_`k' wagebill_`k' wagebillr_`k' q_`k' k_`k' l_`k' m_`k' rva_`k' qva_`k' io_`k'  lols_`k' iols_`k' cols_`k' constant_`k' tfp_`k' markup_`k' markup2_`k' markup3_`k' vaiols_`k' valols_`k' vacols_`k' vatfp_`k' vamarkup_`k' vamarkup2_`k' vamarkup3_`k'
drop ccode _merge 
sort id_`i'
compress
save m`i'-m`k'.disagree.dta, replace

use m`i'-m`k'.05.dta, clear
merge id_`i' using m`i'-m`k'.disagree.dta
drop if _merge==3
drop _merge
append using m`i'-m`k'.disagree.dta

gen ccode=id_`k'+string(salesrev_`k')+string(employment_`k')+string(operprofit_`k')
sort ccode
merge ccode using unmatched`k'.15.dta, update
drop ccode _merge 
gen ccode=id_`j'+string(salesrev_`j')+string(employment_`j')+string(operprofit_`j')
sort ccode
merge ccode using unmatched`j'.15.dta, update
drop ccode _merge

compress
save m`i'-m`k'.dta.10.dta, replace

use m`i'-m`k'.dta.10.dta, clear
append using balanced.m`i'-m`j'-m`k'.dta
drop match_status_`i'_`j'
drop match_status_`j'_`k'
drop match_status_`i'_`k'
drop match_method_`i'_`j'
drop match_method_`j'_`k'
drop match_method_`i'_`k'
gen match_status_`i'_`j'_`k'="`i'-`j'-`k'" if id_`i'!=""&id_`j'!=""&id_`k'!=""
replace match_status_`i'_`j'_`k'="`i'-`j' only" if id_`i'!=""&id_`j'!=""&id_`k'==""
replace match_status_`i'_`j'_`k'="`j'-`k' only" if id_`i'==""&id_`j'!=""&id_`k'!=""
replace match_status_`i'_`j'_`k'="`i'-`k' only" if id_`i'!=""&id_`j'==""&id_`k'!=""
replace match_status_`i'_`j'_`k'="`i' no match" if id_`i'!=""&id_`j'==""&id_`k'==""
replace match_status_`i'_`j'_`k'="`j' no match" if id_`i'==""&id_`j'!=""&id_`k'==""
replace match_status_`i'_`j'_`k'="`k' no match" if id_`i'==""&id_`j'==""&id_`k'!=""

compress
save unbalanced.`i'-`j'-`k'.dta, replace


local i = `i' + 1
  }

  
  
  
*************************************
*					      *
* STAGE 3: Create a ten-Year Panel *
* 					      *
*************************************


use unbalanced.1998-1999-2000.dta, clear
tab match_status_1998_1999_2000
gen ccode=id_2000+string(salesrev_2000)+string(employment_2000)+string(operprofit_2000)
sort ccode
save test1.dta, replace 
  
  
**step 110: add 2001 from 1999-2000-2001**

use unbalanced.1999-2000-2001.dta, clear
tab match_status_1999_2000_2001
keep if match_status_1999_2000_2001=="1999-2000-2001"|match_status_1999_2000_2001=="2000-2001 only"
gen ccode=id_2000+string(salesrev_2000)+string(employment_2000)+string(operprofit_2000)
sort ccode
save test2.dta, replace  
  
  
use test1.dta, clear
merge ccode using test2.dta
tab _merge
drop _merge ccode
gen ccode=id_1999+string(salesrev_1999)+string(employment_1999)+string(operprofit_1999)
sort ccode
save test3.dta, replace
  
use unbalanced.1999-2000-2001.dta, clear
tab match_status_1999_2000_2001
keep if match_status_1999_2000_2001=="1999-2001 only"
gen ccode=id_1999+string(salesrev_1999)+string(employment_1999)+string(operprofit_1999)
sort ccode
save test4.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update
tab _merge
drop ccode _merge
save test5.dta, replace


use test3.dta, clear
merge ccode using test4.dta, update replace
keep if _merge==5
keep id_2001 name_2001 legalperson_2001 telephone_2001 zip_2001 cic_2001 type_2001 employment_2001 output_2001 salesoutput_2001 export_2001 valueadded_2001 ownership_2001 startyear_2001 inventory_2001 total_liabilities_2001 ownerequity_2001 paidupcap_2001 state_2001 collective_2001 legal_person_2001 individual_2001 HMT_2001 foreign_2001 newoutput_2001 salesrev_2001 wage_2001 mainwage_2001 welfare_2001 mainwelfare_2001 operprofit_2001 valueaddedtax_2001 inputtax_2001 outputtax_2001 inputs_2001 subsidy_2001 cic_adj_2001 OutputDefl_2001 routput_2001 deflator_input_2001 rinput_2001 realcap_2001 province_2001 industry_2001 code_2001 cic2_2001 expdummy_2001 wagebill_2001 wagebillr_2001 q_2001 k_2001 l_2001 m_2001 rva_2001 qva_2001 io_2001 lols_2001 iols_2001 cols_2001 constant_2001 tfp_2001 markup_2001 markup2_2001 markup3_2001 vaiols_2001 valols_2001 vacols_2001 vatfp_2001 vamarkup_2001 vamarkup2_2001 vamarkup3_2001
save test6.dta, replace
  

use unbalanced.1999-2000-2001.dta, clear
keep if match_status_1999_2000_2001=="2001 no match"
display _N
save test7.dta, replace
  
use test5.dta, clear
append using test6.dta
dis _N
append using test7.dta
dis _N
gen ccode=id_2001+string(salesrev_2001)+string(employment_2001)+string(operprofit_2001)
sort ccode
save test1.dta, replace 
  
**step 120: add 2002 from 2000-2001-2002**

use unbalanced.2000-2001-2002.dta, clear
tab match_status_2000_2001_2002
keep if match_status_2000_2001_2002=="2000-2001-2002"|match_status_2000_2001_2002=="2001-2002 only"
gen ccode=id_2001+string(salesrev_2001)+string(employment_2001)+string(operprofit_2001)
sort ccode
save test2.dta, replace

use test1.dta, clear
merge ccode using test2.dta
tab _merge
drop _merge ccode
gen ccode=id_2000+string(salesrev_2000)+string(employment_2000)+string(operprofit_2000)
sort ccode
save test3.dta, replace 
  
use unbalanced.2000-2001-2002.dta, clear
tab match_status_2000_2001_2002
keep if match_status_2000_2001_2002=="2000-2002 only"
gen ccode=id_2000+string(salesrev_2000)+string(employment_2000)+string(operprofit_2000)
sort ccode
save test4.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update
tab _merge
drop ccode _merge
save test5.dta, replace
 
use test3.dta, clear
merge ccode using test4.dta, update replace
keep if _merge==5
keep id_2002 name_2002 legalperson_2002 telephone_2002 zip_2002 cic_2002 type_2002 employment_2002 output_2002 salesoutput_2002 export_2002 valueadded_2002 ownership_2002 startyear_2002 inventory_2002 total_liabilities_2002 ownerequity_2002 paidupcap_2002 state_2002 collective_2002 legal_person_2002 individual_2002 HMT_2002 foreign_2002 newoutput_2002 salesrev_2002 wage_2002 mainwage_2002 welfare_2002 mainwelfare_2002 operprofit_2002 valueaddedtax_2002 inputtax_2002 outputtax_2002 inputs_2002 subsidy_2002 cic_adj_2002 OutputDefl_2002 routput_2002 deflator_input_2002 rinput_2002 realcap_2002 province_2002 industry_2002 code_2002 cic2_2002 expdummy_2002 wagebill_2002 wagebillr_2002 q_2002 k_2002 l_2002 m_2002 rva_2002 qva_2002 io_2002 lols_2002 iols_2002 cols_2002 constant_2002 tfp_2002 markup_2002 markup2_2002 markup3_2002 vaiols_2002 valols_2002 vacols_2002 vatfp_2002 vamarkup_2002 vamarkup2_2002 vamarkup3_2002
save test6.dta, replace
 
use unbalanced.2000-2001-2002.dta, clear
keep if match_status_2000_2001_2002=="2002 no match"
display _N
save test7.dta, replace

use test5.dta, clear
append using test6.dta
dis _N
append using test7.dta
dis _N
gen ccode=id_2002+string(salesrev_2002)+string(employment_2002)+string(operprofit_2002)
sort ccode
save test1.dta, replace

**step 130: add 2003 from 2001-2002-2003**

use unbalanced.2001-2002-2003.dta, clear
tab match_status_2001_2002_2003
keep if match_status_2001_2002_2003=="2001-2002-2003"|match_status_2001_2002_2003=="2002-2003 only"
gen ccode=id_2002+string(salesrev_2002)+string(employment_2002)+string(operprofit_2002)
sort ccode
save test2.dta, replace

use test1.dta, clear
merge ccode using test2.dta
tab _merge
drop _merge ccode
gen ccode=id_2001+string(salesrev_2001)+string(employment_2001)+string(operprofit_2001)
sort ccode
save test3.dta, replace

use unbalanced.2001-2002-2003.dta, clear
tab match_status_2001_2002_2003
keep if match_status_2001_2002_2003=="2001-2003 only"
gen ccode=id_2001+string(salesrev_2001)+string(employment_2001)+string(operprofit_2001)
sort ccode
save test4.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update
tab _merge
drop ccode _merge
save test5.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update replace
keep if _merge==5
keep id_2003 name_2003 legalperson_2003 telephone_2003 zip_2003 cic_2003 type_2003 employment_2003 output_2003 salesoutput_2003 export_2003 valueadded_2003 ownership_2003 startyear_2003 inventory_2003 total_liabilities_2003 ownerequity_2003 paidupcap_2003 state_2003 collective_2003 legal_person_2003 individual_2003 HMT_2003 foreign_2003 newoutput_2003 salesrev_2003 wage_2003 mainwage_2003 welfare_2003 mainwelfare_2003 operprofit_2003 valueaddedtax_2003 inputtax_2003 outputtax_2003 inputs_2003 subsidy_2003 cic_adj_2003 OutputDefl_2003 routput_2003 deflator_input_2003 rinput_2003 realcap_2003 province_2003 industry_2003 code_2003 cic2_2003 expdummy_2003 wagebill_2003 wagebillr_2003 q_2003 k_2003 l_2003 m_2003 rva_2003 qva_2003 io_2003 lols_2003 iols_2003 cols_2003 constant_2003 tfp_2003 markup_2003 markup2_2003 markup3_2003 vaiols_2003 valols_2003 vacols_2003 vatfp_2003 vamarkup_2003 vamarkup2_2003 vamarkup3_2003
save test6.dta, replace

use unbalanced.2001-2002-2003.dta, clear
keep if match_status_2001_2002_2003=="2003 no match"
display _N
save test7.dta, replace

use test5.dta, clear
append using test6.dta
dis _N
append using test7.dta
dis _N
gen ccode=id_2003+string(salesrev_2003)+string(employment_2003)+string(operprofit_2003)
sort ccode
save test1.dta, replace


**step 140: add 2004 from 2002-2003-2004 **

use unbalanced.2002-2003-2004.dta, clear
tab match_status_2002_2003_2004
keep if match_status_2002_2003_2004=="2002-2003-2004"|match_status_2002_2003_2004=="2003-2004 only"
gen ccode=id_2003+string(salesrev_2003)+string(employment_2003)+string(operprofit_2003)
sort ccode
save test2.dta, replace

use test1.dta, clear
merge ccode using test2.dta
tab _merge
drop _merge ccode
gen ccode=id_2002+string(salesrev_2002)+string(employment_2002)+string(operprofit_2002)
sort ccode
save test3.dta, replace

use unbalanced.2002-2003-2004.dta, clear
tab match_status_2002_2003_2004
keep if match_status_2002_2003_2004=="2002-2004 only"
gen ccode=id_2002+string(salesrev_2002)+string(employment_2002)+string(operprofit_2002)
sort ccode
save test4.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update
tab _merge
drop ccode _merge
save test5.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update replace
keep if _merge==5
keep id_2004 name_2004 legalperson_2004 telephone_2004 zip_2004 cic_2004 type_2004 employment_2004 output_2004 salesoutput_2004 export_2004 valueadded_2004 ownership_2004 startyear_2004 inventory_2004 total_liabilities_2004 ownerequity_2004 paidupcap_2004 state_2004 collective_2004 legal_person_2004 individual_2004 HMT_2004 foreign_2004 newoutput_2004 salesrev_2004 wage_2004 mainwage_2004 welfare_2004 mainwelfare_2004 operprofit_2004 valueaddedtax_2004 inputtax_2004 outputtax_2004 inputs_2004 subsidy_2004 cic_adj_2004 OutputDefl_2004 routput_2004 deflator_input_2004 rinput_2004 realcap_2004 province_2004 industry_2004 code_2004 cic2_2004 expdummy_2004 wagebill_2004 wagebillr_2004 q_2004 k_2004 l_2004 m_2004 rva_2004 qva_2004 io_2004 lols_2004 iols_2004 cols_2004 constant_2004 tfp_2004 markup_2004 markup2_2004 markup3_2004 vaiols_2004 valols_2004 vacols_2004 vatfp_2004 vamarkup_2004 vamarkup2_2004 vamarkup3_2004
save test6.dta, replace

use unbalanced.2002-2003-2004.dta, clear
keep if match_status_2002_2003_2004=="2004 no match"
display _N
save test7.dta, replace

use test5.dta, clear
append using test6.dta
dis _N
append using test7.dta
dis _N
gen ccode=id_2004+string(salesrev_2004)+string(employment_2004)+string(operprofit_2004)
sort ccode
save test1.dta, replace


**step 150: add 2005 from 2003-2004-2005 **

use unbalanced.2003-2004-2005.dta, clear
tab match_status_2003_2004_2005
keep if match_status_2003_2004_2005=="2003-2004-2005"|match_status_2003_2004_2005=="2004-2005 only"
gen ccode=id_2004+string(salesrev_2004)+string(employment_2004)+string(operprofit_2004)
sort ccode
save test2.dta, replace

use test1.dta, clear
merge ccode using test2.dta
tab _merge
drop _merge ccode
gen ccode=id_2003+string(salesrev_2003)+string(employment_2003)+string(operprofit_2003)
sort ccode
save test3.dta, replace

use unbalanced.2003-2004-2005.dta, clear
tab match_status_2003_2004_2005
keep if match_status_2003_2004_2005=="2003-2005 only"
gen ccode=id_2003+string(salesrev_2003)+string(employment_2003)+string(operprofit_2003)
sort ccode
save test4.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update
tab _merge
drop ccode _merge
save test5.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update replace
keep if _merge==5
keep id_2005 name_2005 legalperson_2005 telephone_2005 zip_2005 cic_2005 type_2005 employment_2005 output_2005 salesoutput_2005 export_2005 valueadded_2005 ownership_2005 startyear_2005 inventory_2005 total_liabilities_2005 ownerequity_2005 paidupcap_2005 state_2005 collective_2005 legal_person_2005 individual_2005 HMT_2005 foreign_2005 newoutput_2005 salesrev_2005 wage_2005 mainwage_2005 welfare_2005 mainwelfare_2005 operprofit_2005 valueaddedtax_2005 inputtax_2005 outputtax_2005 inputs_2005 subsidy_2005 cic_adj_2005 OutputDefl_2005 routput_2005 deflator_input_2005 rinput_2005 realcap_2005 province_2005 industry_2005 code_2005 cic2_2005 expdummy_2005 wagebill_2005 wagebillr_2005 q_2005 k_2005 l_2005 m_2005 rva_2005 qva_2005 io_2005 lols_2005 iols_2005 cols_2005 constant_2005 tfp_2005 markup_2005 markup2_2005 markup3_2005 vaiols_2005 valols_2005 vacols_2005 vatfp_2005 vamarkup_2005 vamarkup2_2005 vamarkup3_2005
save test6.dta, replace

use unbalanced.2003-2004-2005.dta, clear
keep if match_status_2003_2004_2005=="2005 no match"
display _N
save test7.dta, replace

use test5.dta, clear
append using test6.dta
dis _N
append using test7.dta
dis _N
gen ccode=id_2005+string(salesrev_2005)+string(employment_2005)+string(operprofit_2005)
sort ccode
save test1.dta, replace

**step 160: add 2006 from 2004-2005-2006 **


use unbalanced.2004-2005-2006.dta, clear
tab match_status_2004_2005_2006
keep if match_status_2004_2005_2006=="2004-2005-2006"|match_status_2004_2005_2006=="2005-2006 only"
gen ccode=id_2005+string(salesrev_2005)+string(employment_2005)+string(operprofit_2005)
sort ccode
save test2.dta, replace


use test1.dta, clear
merge ccode using test2.dta
tab _merge
drop _merge ccode
gen ccode=id_2004+string(salesrev_2004)+string(employment_2004)+string(operprofit_2004)
sort ccode
save test3.dta, replace

use unbalanced.2004-2005-2006.dta, clear
tab match_status_2004_2005_2006
keep if match_status_2004_2005_2006=="2004-2006 only"
gen ccode=id_2004+string(salesrev_2004)+string(employment_2004)+string(operprofit_2004)
sort ccode
save test4.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update
tab _merge
drop ccode _merge
save test5.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update replace
keep if _merge==5
keep id_2006 name_2006 legalperson_2006 telephone_2006 zip_2006 cic_2006 type_2006 employment_2006 output_2006 salesoutput_2006 export_2006 valueadded_2006 ownership_2006 startyear_2006 inventory_2006 total_liabilities_2006 ownerequity_2006 paidupcap_2006 state_2006 collective_2006 legal_person_2006 individual_2006 HMT_2006 foreign_2006 newoutput_2006 salesrev_2006 wage_2006 mainwage_2006 welfare_2006 mainwelfare_2006 operprofit_2006 valueaddedtax_2006 inputtax_2006 outputtax_2006 inputs_2006 subsidy_2006 cic_adj_2006 OutputDefl_2006 routput_2006 deflator_input_2006 rinput_2006 realcap_2006 province_2006 industry_2006 code_2006 cic2_2006 expdummy_2006 wagebill_2006 wagebillr_2006 q_2006 k_2006 l_2006 m_2006 rva_2006 qva_2006 io_2006 lols_2006 iols_2006 cols_2006 constant_2006 tfp_2006 markup_2006 markup2_2006 markup3_2006 vaiols_2006 valols_2006 vacols_2006 vatfp_2006 vamarkup_2006 vamarkup2_2006 vamarkup3_2006
save test6.dta, replace

use unbalanced.2004-2005-2006.dta, clear
keep if match_status_2004_2005_2006=="2006 no match"
display _N
save test7.dta, replace


use test5.dta, clear
append using test6.dta
dis _N
append using test7.dta
dis _N
gen ccode=id_2006+string(salesrev_2006)+string(employment_2006)+string(operprofit_2006)
sort ccode
save test1.dta, replace


**step 170: add 2007 from 2005-2006-2007 **


use unbalanced.2005-2006-2007.dta, clear
tab match_status_2005_2006_2007
keep if match_status_2005_2006_2007=="2005-2006-2007"|match_status_2005_2006_2007=="2006-2007 only"
gen ccode=id_2006+string(salesrev_2006)+string(employment_2006)+string(operprofit_2006)
sort ccode
save test2.dta, replace


use test1.dta, clear
merge ccode using test2.dta
tab _merge
drop _merge ccode
gen ccode=id_2005+string(salesrev_2005)+string(employment_2005)+string(operprofit_2005)
sort ccode
save test3.dta, replace

use unbalanced.2005-2006-2007.dta, clear
tab match_status_2005_2006_2007
keep if match_status_2005_2006_2007=="2005-2007 only"
gen ccode=id_2005+string(salesrev_2005)+string(employment_2005)+string(operprofit_2005)
sort ccode
save test4.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update
tab _merge
drop ccode _merge
save test5.dta, replace

use test3.dta, clear
merge ccode using test4.dta, update replace
keep if _merge==5
keep id_2007 name_2007 legalperson_2007 telephone_2007 zip_2007 cic_2007 type_2007 employment_2007 output_2007 salesoutput_2007 export_2007 valueadded_2007 ownership_2007 startyear_2007 inventory_2007 total_liabilities_2007 ownerequity_2007 paidupcap_2007 state_2007 collective_2007 legal_person_2007 individual_2007 HMT_2007 foreign_2007 newoutput_2007 salesrev_2007 wage_2007 mainwage_2007 welfare_2007 mainwelfare_2007 operprofit_2007 valueaddedtax_2007 inputtax_2007 outputtax_2007 inputs_2007 subsidy_2007 cic_adj_2007 OutputDefl_2007 routput_2007 deflator_input_2007 rinput_2007 realcap_2007 province_2007 industry_2007 code_2007 cic2_2007 expdummy_2007 wagebill_2007 wagebillr_2007 q_2007 k_2007 l_2007 m_2007 rva_2007 qva_2007 io_2007 lols_2007 iols_2007 cols_2007 constant_2007 tfp_2007 markup_2007 markup2_2007 markup3_2007 vaiols_2007 valols_2007 vacols_2007 vatfp_2007 vamarkup_2007 vamarkup2_2007 vamarkup3_2007
save test6.dta, replace

use unbalanced.2004-2005-2006.dta, clear
keep if match_status_2004_2005_2006=="2006 no match"
display _N
save test7.dta, replace

use test5.dta, clear
append using test6.dta
append using test7.dta
aorder
drop  match_status_1998_1999_2000- match_status_2005_2006_2007
compress
save unbalanced.1998--2007.dta, replace


gen id_in_panel=_n

reshape long id_ name_ legalperson_ telephone_ zip_ cic_ type_ employment_ output_ salesoutput_ export_ valueadded_ ownership_ startyear_ inventory_ total_liabilities_ ownerequity_ paidupcap_ state_ collective_ legal_person_ individual_ HMT_ foreign_ newoutput_ salesrev_ wage_ mainwage_ welfare_ mainwelfare_ operprofit_ valueaddedtax_ inputtax_ outputtax_ inputs_ subsidy_ cic_adj_ OutputDefl_ routput_ deflator_input_ rinput_ realcap_ province_ industry_ code_ cic2_ expdummy_ wagebill_ wagebillr_ q_ k_ l_ m_ rva_ qva_ io_ lols_ iols_ cols_ constant_ tfp_ markup_ markup2_ markup3_ vaiols_ valols_ vacols_ vatfp_ vamarkup_ vamarkup2_ vamarkup3_, i(id_in_panel) j(year)
save "/Volumes/Tingsi Wang/Third chap/Industrial data/match/data.dta"
drop if mi(id_)


gen expsahre=export/salesrev
gen age=year-startyear
drop if startyear<1900

save "/Volumes/Tingsi Wang/Third chap/Data from SUFE/Process data/unbalanced1998-2007.dta"


sort province
merge m:1 province using target
drop _merge

sort province
merge m:1 province using provincename
drop _merge

sort io
merge m:m io using so2bysector
sort _merge
keep if _merge==3
drop _merge

order id_in_panel id year name legalperson telephone zip startyear age cic cic2 cic_adj province provincename locationname location industry code io generalio sectorname ownership type state legal_person collective individual foreign HMT operprofit inventory inputtax outputtax valueaddedtax ownerequity paidupcap subsidy total_liabilities wage mainwage welfare mainwelfare wagebill wagebillr expshare export expdummy newoutput salesoutput salesrev output valueadded inputs OutputDefl deflator_input routput rva rinput realcap q qva k m l lols iols cols constant tfp markup markup2 markup3 vaiols valols vacols vatfp vamarkup vamarkup2 vamarkup3 target ltarget Mavgso2 Mremoveavgso2 Mfacilities Mtotal Mburn lMavgso2 lMremoveavgso2 lMfacilities lMtotal lMburn
save "/Volumes/Tingsi Wang/Third chap/Data from SUFE/Process data/unbalanced1998-2007.dta", replace


**************************************************************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************
********************************************Prepare for regression******************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************


gen Post6 = (year>2005)
gen Post5=(year>2004) 
gen Post4 = (year>2003)
gen Post3=(year>2002) 
gen Post2=(year>2001) 
gen Post1=(year>2000) 


gen post_target_so_06=ltarget*Post6*lMavgso2 
gen post_target_so_05=ltarget*Post5*lMavgso2 
gen post_target_so_04=ltarget*Post4*lMavgso2 
gen post_target_so_03=ltarget*Post3*lMavgso2 
gen post_target_so_02=ltarget*Post2*lMavgso2 
gen post_target_so_01=ltarget*Post1*lMavgso2 



tabulate year, gen(YY)
egen ccyy  =group(cic_adj year)
egen ioyy  =group(io year)
egen yypp  =group(year province)
egen ccyypp  =group(cic_adj year province)
egen ioyypp  =group(io year province)
egen cc2yy  =group(cic2 year)
egen idyy  =group(id_in_panel year)
egen iopp  =group(io province)
egen cc2pp  =group(cic2 province)



egen sdcic4=sd(cic_adj), by(id_in_panel)
keep if sdcic4==0

for var export employment routput rva: egen TX=sum(X), by(cic_adj year)
for var export employment routput rva \ any x l y yva: gen logY=log(TX)
egen T1output=sum(routput*(ownership==1)), by(cic_adj year) //STATE
egen T3output=sum(routput*(ownership==3)), by(cic_adj year) //PRIVATE
egen T4output=sum(routput*(ownership==4)), by(cic_adj year) //HMT
egen T5output=sum(routput*(ownership==5)), by(cic_adj year) //Foreign

*gen Toutput=sum(output)
egen Toutput=sum(output), by(cic_adj year)
gen SOEshare=T1output/Toutput
gen PRIshare=T3output/Toutput
gen HMTshare=T4output/Toutput
gen FORshare=T5output/Toutput
gen  share   =routput/Troutput

for var markup markup2 markup3 markup4 markup5 markup6 vamarkup vamarkup2 vamarkup3 vamarkup4 vamarkup5 vamarkup6: gen lX=log(X)
for var cols iols lols constant IOcols IOiols IOlols IOconstant vacols vaiols valols vaconstant vaIOcols vaIOiols vaIOlols vaIOconstant :   egen MX        =mean(X)       , by(cic2)

gen MtfpvaIO = qva  - MvaIOconstant  - MvaIOiols*m   - MvaIOlols*l  - MvaIOcols*k

**rename markups with mum*
***tfp Mtfp vatfp MtfpA mum1-6 vamum1-6
for var tfp vatfp IOtfp vaIOtfp Mtfp*  mum*: egen P1X =pctile(X), by(cic2 year) p(1)
for var tfp vatfp IOtfp vaIOtfp Mtfp* mum*: egen P99X=pctile(X), by(cic2 year) p(99)

save "/Volumes/Tingsi Wang/Third chap/Data from SUFE/Process data/firm_level_data_full.dta"
for var tfp vatfp IOtfp vaIOtfp Mtfp* mum*: replace X=. if X<P1X | X>P99X


drop if mi($OP6)
save "/Volumes/Tingsi Wang/Third chap/Data from SUFE/Process data/firm_level_data_full_clean.dta"

**************************************************************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************
********************************************Regression******************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************************************************************************************************************


use firm_level_data_full_clean.dta
gen post_so6=lMavgso2*Post6

reghdfe mumIOva4 post_target6 postso llogl lage if ownership==1  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if ownership==2 , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if ownership==3 , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if ownership==4 , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if ownership==5 , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if expdummy==1&ownership==1  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if expdummy==1&ownership==3  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if expdummy==1&ownership==5  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if expdummy==1&ownership==4  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if expdummy==0&ownership==1  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if expdummy==0&ownership==3  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if expdummy==0&ownership==5  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if expdummy==0&ownership==4  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if expdummy==1&ownership==5  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso if expdummy==1&ownership==5  , absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 if expdummy==1&ownership==5  , absorb(year id_in_panel) vce(cluster id_in_panel)

***location
reghdfe mumIOva4 post_target6 postso llogl lage if coastal==1, absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if coastal==0, absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if coastal==1&expdummy==1, absorb(year id_in_panel) vce(cluster id_in_panel)
reghdfe mumIOva4 post_target6 postso llogl lage if coastal==1&expdummy==0, absorb(year id_in_panel) vce(cluster id_in_panel)



***********triple diff 

global OP6 post_target_so_06
global OP5 post_target_so_05
global OP4 post_target_so_04
global OP3 post_target_so_03
global OP2 post_target_so_02
global OP1 post_target_so_01

reghdfe mumIOva4 $OP6 llogl lage expdummy, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage if expdummy==1, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage if expdummy==0, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)

drop if province=="11" |province=="12"|province=="13"|province=="14"|province=="15"|province=="21"


reghdfe mumIOva4 $OP6 llogl lage expdummy, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage expdummy if ownership==1, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage expdummy if ownership==2|ownership==3, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage expdummy if ownership==5, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage expdummy if ownership==4, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)

***ownership
reghdfe mumIOva4 $OP6 llogl lage if expdummy==1&ownership==1, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage if expdummy==1&ownership==2|ownership==3, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage if expdummy==1&ownership==5, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage if expdummy==1&ownership==4, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)

reghdfe mumIOva4 $OP6 llogl lage if expdummy==0&ownership==1, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage if expdummy==0&ownership==2|ownership==3, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage if expdummy==0&ownership==5, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 llogl lage if expdummy==0&ownership==4, absorb(cc2yy yypp cc2pp) vce(cluster id_in_panel)

***********expectation
reghdfe mumIOva4 $OP6 $OP5 $OP4 $OP3, absorb(ioyy yypp iopp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 $OP5 $OP4 $OP3 if expdummy==1, absorb(ioyy yypp iopp) vce(cluster id_in_panel)
reghdfe mumIOva4 $OP6 $OP5 $OP4 $OP3 if expdummy==0, absorb(ioyy yypp iopp) vce(cluster id_in_panel)





