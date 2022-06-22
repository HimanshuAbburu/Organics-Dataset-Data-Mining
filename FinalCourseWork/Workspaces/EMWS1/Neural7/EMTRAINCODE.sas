*------------------------------------------------------------*;
* Neural7: Create decision matrix;
*------------------------------------------------------------*;
data WORK.ORGYN;
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
  format   COUNT 10.
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
data EM_Neural7;
set EMWS1.Part_TRAIN(keep=
AFFL AGE BILL CLASS GENDER LTIME NGROUP OAC ORGYN REGION S_CONV S_FVEG S_MT
S_TOIL TV_REG );
run;
*------------------------------------------------------------* ;
* Neural7: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CLASS(ASC) GENDER(ASC) NGROUP(ASC) OAC(ASC) ORGYN(DESC) REGION(ASC)
   TV_REG(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural7: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AFFL AGE BILL LTIME S_CONV S_FVEG S_MT S_TOIL
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural7: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural7
dmdbcat=WORK.Neural7_DMDB
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
* Neural7: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    AFFL AGE BILL LTIME S_CONV S_FVEG S_MT S_TOIL
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural7: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural7: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    CLASS GENDER NGROUP OAC REGION TV_REG
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural7: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural7 dmdbcat=WORK.Neural7_DMDB
validdata = EMWS1.Part_VALIDATE
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
Hidden=5
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS1.Neural7_PRELIM_OUTEST
;
save network=EMWS1.Neural7_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS1.Neural7_outest estiter=1
Outfit=EMWS1.Neural7_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural7_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural7;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural7(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural7_INITIAL;
set EMWS1.Neural7_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural7 dmdbcat=WORK.Neural7_DMDB
validdata = EMWS1.Part_VALIDATE
network = EMWS1.Neural7_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural7_INITIAL;
train tech=NONE;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural7\SCORECODE.sas"
group=Neural7
;
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural7\RESIDUALSCORECODE.sas"
group=Neural7
residual
;
;
score data=EMWS1.Part_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural7_OUTKEY;
score data=EMWS1.Part_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural7_OUTKEY;
score data=EMWS1.Part_TEST out=_NULL_
outfit=WORK.FIT3
role=TEST
outkey=EMWS1.Neural7_OUTKEY;
run;
quit;
data EMWS1.Neural7_OUTFIT;
merge WORK.FIT1 WORK.FIT2 WORK.FIT3;
run;
data EMWS1.Neural7_EMESTIMATE;
set EMWS1.Neural7_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural7;
run;
quit;
