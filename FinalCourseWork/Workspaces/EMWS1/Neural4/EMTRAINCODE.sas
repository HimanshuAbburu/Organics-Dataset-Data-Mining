*------------------------------------------------------------*;
* Neural4: Create decision matrix;
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
ORGYN="1"; COUNT=766; DATAPRIOR=0.25843454790823; TRAINPRIOR=0.25843454790823; DECPRIOR=.; DECISION1=1; DECISION2=0;
output;
ORGYN="0"; COUNT=2198; DATAPRIOR=0.74156545209176; TRAINPRIOR=0.74156545209176; DECPRIOR=.; DECISION1=0; DECISION2=1;
output;
;
run;
proc datasets lib=work nolist;
modify ORGYN(type=PROFIT label=ORGYN);
label DECISION1= '1';
label DECISION2= '0';
run;
quit;
data EM_Neural4;
set EMWS1.Filter_TRAIN(keep=
AFFL AGE BILL CLASS GENDER LTIME NGROUP OAC ORGYN REGION S_CONV S_FVEG S_MT
S_TOIL TV_REG );
run;
*------------------------------------------------------------* ;
* Neural4: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CLASS(ASC) GENDER(ASC) NGROUP(ASC) OAC(ASC) ORGYN(DESC) REGION(ASC)
   TV_REG(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural4: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AFFL AGE BILL LTIME S_CONV S_FVEG S_MT S_TOIL
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural4: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural4
dmdbcat=WORK.Neural4_DMDB
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
* Neural4: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    AFFL AGE BILL LTIME S_CONV S_FVEG S_MT S_TOIL
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural4: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural4: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    CLASS GENDER NGROUP OAC REGION TV_REG
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural4: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural4 dmdbcat=WORK.Neural4_DMDB
validdata = EMWS1.Filter_VALIDATE
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
Outest=EMWS1.Neural4_PRELIM_OUTEST
;
save network=EMWS1.Neural4_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS1.Neural4_outest estiter=1
Outfit=EMWS1.Neural4_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural4_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural4;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural4(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural4_INITIAL;
set EMWS1.Neural4_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural4 dmdbcat=WORK.Neural4_DMDB
validdata = EMWS1.Filter_VALIDATE
network = EMWS1.Neural4_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural4_INITIAL;
train tech=NONE;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural4\SCORECODE.sas"
group=Neural4
;
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Neural4\RESIDUALSCORECODE.sas"
group=Neural4
residual
;
;
score data=EMWS1.Filter_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural4_OUTKEY;
score data=EMWS1.Filter_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural4_OUTKEY;
score data=EMWS1.Filter_TEST out=_NULL_
outfit=WORK.FIT3
role=TEST
outkey=EMWS1.Neural4_OUTKEY;
run;
quit;
data EMWS1.Neural4_OUTFIT;
merge WORK.FIT1 WORK.FIT2 WORK.FIT3;
run;
data EMWS1.Neural4_EMESTIMATE;
set EMWS1.Neural4_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural4;
run;
quit;
