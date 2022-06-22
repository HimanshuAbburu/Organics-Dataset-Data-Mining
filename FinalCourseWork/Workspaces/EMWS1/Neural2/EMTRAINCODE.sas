*------------------------------------------------------------*;
* Neural2: Create decision matrix;
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
data EM_Neural2;
set EMWS1.Part_TRAIN(keep=
AFFL AGE BILL CLASS GENDER LTIME NGROUP OAC ORGYN REGION S_CONV S_FVEG S_MT
S_TOIL TV_REG );
run;
*------------------------------------------------------------* ;
* Neural2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CLASS(ASC) GENDER(ASC) NGROUP(ASC) OAC(ASC) ORGYN(DESC) REGION(ASC)
   TV_REG(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AFFL AGE BILL LTIME S_CONV S_FVEG S_MT S_TOIL
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural2
dmdbcat=WORK.Neural2_DMDB
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
* Neural2: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    AFFL AGE BILL LTIME S_CONV S_FVEG S_MT S_TOIL
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural2: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural2: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    CLASS GENDER NGROUP OAC REGION TV_REG
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural2: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural2 dmdbcat=WORK.Neural2_DMDB
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
Hidden=3
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS1.Neural2_PRELIM_OUTEST
;
save network=EMWS1.Neural2_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS1.Neural2_outest estiter=1
Outfit=EMWS1.Neural2_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural2_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural2;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural2(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural2_INITIAL;
set EMWS1.Neural2_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural2 dmdbcat=WORK.Neural2_DMDB
validdata = EMWS1.Part_VALIDATE
network = EMWS1.Neural2_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural2_INITIAL;
train tech=NONE;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural2\SCORECODE.sas"
group=Neural2
;
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural2\RESIDUALSCORECODE.sas"
group=Neural2
residual
;
;
score data=EMWS1.Part_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural2_OUTKEY;
score data=EMWS1.Part_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural2_OUTKEY;
score data=EMWS1.Part_TEST out=_NULL_
outfit=WORK.FIT3
role=TEST
outkey=EMWS1.Neural2_OUTKEY;
run;
quit;
data EMWS1.Neural2_OUTFIT;
merge WORK.FIT1 WORK.FIT2 WORK.FIT3;
run;
data EMWS1.Neural2_EMESTIMATE;
set EMWS1.Neural2_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural2;
run;
quit;
