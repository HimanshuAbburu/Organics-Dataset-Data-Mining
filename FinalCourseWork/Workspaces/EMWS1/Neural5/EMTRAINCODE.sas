*------------------------------------------------------------*;
* Neural5: Create decision matrix;
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
data EM_Neural5;
set EMWS1.Trans_TRAIN(keep=
CLASS GENDER INBILL LOGLTIME LOG_AFFL LOG_AGE LOG_BILL LOG_LTIME LOG_S_CONV
LOG_S_FVEG LOG_S_MT LOG_S_TOIL NGROUP OAC ORGYN REGION TV_REG );
run;
*------------------------------------------------------------* ;
* Neural5: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CLASS(ASC) GENDER(ASC) NGROUP(ASC) OAC(ASC) ORGYN(DESC) REGION(ASC)
   TV_REG(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural5: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    INBILL LOGLTIME LOG_AFFL LOG_AGE LOG_BILL LOG_LTIME LOG_S_CONV LOG_S_FVEG
   LOG_S_MT LOG_S_TOIL
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural5: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural5
dmdbcat=WORK.Neural5_DMDB
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
* Neural5: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    INBILL LOGLTIME LOG_AFFL LOG_AGE LOG_BILL LOG_LTIME LOG_S_CONV LOG_S_FVEG
   LOG_S_MT LOG_S_TOIL
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural5: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural5: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    CLASS GENDER NGROUP OAC REGION TV_REG
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural5: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural5 dmdbcat=WORK.Neural5_DMDB
validdata = EMWS1.Trans_VALIDATE
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
Outest=EMWS1.Neural5_PRELIM_OUTEST
;
save network=EMWS1.Neural5_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS1.Neural5_outest estiter=1
Outfit=EMWS1.Neural5_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural5_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural5;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural5(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural5_INITIAL;
set EMWS1.Neural5_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural5 dmdbcat=WORK.Neural5_DMDB
validdata = EMWS1.Trans_VALIDATE
network = EMWS1.Neural5_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural5_INITIAL;
train tech=NONE;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural5\SCORECODE.sas"
group=Neural5
;
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural5\RESIDUALSCORECODE.sas"
group=Neural5
residual
;
;
score data=EMWS1.Trans_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural5_OUTKEY;
score data=EMWS1.Trans_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural5_OUTKEY;
score data=EMWS1.Trans_TEST out=_NULL_
outfit=WORK.FIT3
role=TEST
outkey=EMWS1.Neural5_OUTKEY;
run;
quit;
data EMWS1.Neural5_OUTFIT;
merge WORK.FIT1 WORK.FIT2 WORK.FIT3;
run;
data EMWS1.Neural5_EMESTIMATE;
set EMWS1.Neural5_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural5;
run;
quit;
