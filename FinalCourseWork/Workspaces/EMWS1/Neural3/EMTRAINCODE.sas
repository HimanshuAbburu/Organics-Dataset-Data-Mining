*------------------------------------------------------------*;
* Neural3: Create decision matrix;
*------------------------------------------------------------*;
data WORK.ORGYN(label="ORGYN");
  length   ORGYN                            $  32
           COUNT                                8
           DATAPRIOR                            8
           TRAINPRIOR                           8
           DECPRIOR                             8
           DECISION1                            8
           DECISION2                            8
           ;

  label    COUNT="Level Counts"
           DATAPRIOR="Data Proportions"
           TRAINPRIOR="Training Proportions"
           DECPRIOR="Decision Priors"
           DECISION1="1"
           DECISION2="0"
           ;
ORGYN="1"; COUNT=974; DATAPRIOR=0.2435; TRAINPRIOR=0.2435; DECPRIOR=.; DECISION1=1; DECISION2=0;
output;
ORGYN="0"; COUNT=3026; DATAPRIOR=0.7565; TRAINPRIOR=0.7565; DECPRIOR=.; DECISION1=0; DECISION2=1;
output;
;
run;
proc datasets lib=work nolist;
modify ORGYN(type=PROFIT label=ORGYN);
label DECISION1= '1';
label DECISION2= '0';
run;
quit;
data EM_Neural3;
set EMWS1.Impt2_TRAIN(keep=
BILL CLASS IMP_AFFL IMP_AGE IMP_GENDER IMP_LTIME IMP_NGROUP IMP_OAC IMP_REGION
IMP_TV_REG ORGYN S_CONV S_FVEG S_MT S_TOIL );
run;
*------------------------------------------------------------* ;
* Neural3: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CLASS(ASC) IMP_GENDER(ASC) IMP_NGROUP(ASC) IMP_OAC(ASC) IMP_REGION(ASC)
   IMP_TV_REG(ASC) ORGYN(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural3: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    BILL IMP_AFFL IMP_AGE IMP_LTIME S_CONV S_FVEG S_MT S_TOIL
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural3: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural3
dmdbcat=WORK.Neural3_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
ORGYN
;
run;
quit;
*------------------------------------------------------------* ;
* Neural3: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    BILL IMP_AFFL IMP_AGE IMP_LTIME S_CONV S_FVEG S_MT S_TOIL
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural3: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural3: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    CLASS IMP_GENDER IMP_NGROUP IMP_OAC IMP_REGION IMP_TV_REG
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural3: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural3 dmdbcat=WORK.Neural3_DMDB
validdata = EMWS1.Impt2_VALIDATE
random=12345
;
nloptions
;
performance alldetails noutilfile;
netopts
decay=0;
input %INTINPUTS / level=interval id=intvl
;
input %NOMINPUTS / level=nominal id=nom
;
target ORGYN / level=NOMINAL id=ORGYN
bias
;
arch MLP
Hidden=3
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS1.Neural3_PRELIM_OUTEST
;
save network=EMWS1.Neural3_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS1.Neural3_outest estiter=1
Outfit=EMWS1.Neural3_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural3_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural3;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural3(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural3_INITIAL;
set EMWS1.Neural3_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural3 dmdbcat=WORK.Neural3_DMDB
validdata = EMWS1.Impt2_VALIDATE
network = EMWS1.Neural3_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural3_INITIAL;
train tech=NONE;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural3\SCORECODE.sas"
group=Neural3
;
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural3\RESIDUALSCORECODE.sas"
group=Neural3
residual
;
;
score data=EMWS1.Impt2_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural3_OUTKEY;
score data=EMWS1.Impt2_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural3_OUTKEY;
score data=EMWS1.Impt2_TEST out=_NULL_
outfit=WORK.FIT3
role=TEST
outkey=EMWS1.Neural3_OUTKEY;
run;
quit;
data EMWS1.Neural3_OUTFIT;
merge WORK.FIT1 WORK.FIT2 WORK.FIT3;
run;
data EMWS1.Neural3_EMESTIMATE;
set EMWS1.Neural3_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural3;
run;
quit;
