*------------------------------------------------------------*;
* Smpl: Retrieving stratification variable(s) levels;
*------------------------------------------------------------*;
proc freq data=EMWS1.Filter_TRAIN noprint;
format
ORGYN BEST12.0
;
table
ORGYN
/out=EMWS1.Smpl_STRATASUMMARY (rename=(count=_npop_ percent=_pctpop_)) missing;
run;
quit;
proc sort data=EMWS1.Smpl_STRATASUMMARY out=EMWS1.Smpl_STRATASUMMARY;
by descending _npop_;
run;
*------------------------------------------------------------*;
* Smpl: Create stratified sample;
*------------------------------------------------------------*;
data EMWS1.Smpl_DATA(label="Sample of EMWS1.Filter_TRAIN.");
set EMWS1.Filter_TRAIN;
retain _seed_ 12345;
label _dataobs_ = "%sysfunc(sasmsg(sashelp.dmine, sample_dataobs_vlabel, NOQUOTE))";
drop _seed_ _genvalue_;
call ranuni(_seed_, _genvalue_);
drop
_n000001 _s000001
_n000002 _s000002
;
length _Sformat1 $200;
drop _Sformat1;
_Sformat1 = strip(put(ORGYN, BEST12.0));
if
_Sformat1 = '0'
then do;
_n000001 + 1;
if _s000001 < 2198 then do;
if _genvalue_*(2198 - _n000001) <=(2198 - _s000001) then do;
_s000001 + 1;
_dataobs_=_N_;
output;
end;
end;
end;
else if
_Sformat1 = '1'
then do;
_n000002 + 1;
if _s000002 < 766 then do;
if _genvalue_*(766 - _n000002) <=(766 - _s000002) then do;
_s000002 + 1;
_dataobs_=_N_;
output;
end;
end;
end;
run;
