*------------------------------------------------------------*;
* Reg10: Create decision matrix;
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
data EM_DMREG / view=EM_DMREG;
set EMWS1.Trans_TRAIN(keep=
CLASS GENDER INBILL LOGLTIME LOG_AFFL LOG_AGE LOG_BILL LOG_LTIME LOG_S_CONV
LOG_S_FVEG LOG_S_MT LOG_S_TOIL NGROUP OAC ORGYN REGION TV_REG );
run;
*------------------------------------------------------------* ;
* Reg10: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CLASS(ASC) GENDER(ASC) NGROUP(ASC) OAC(ASC) ORGYN(DESC) REGION(ASC)
   TV_REG(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg10: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    INBILL LOGLTIME LOG_AFFL LOG_AGE LOG_BILL LOG_LTIME LOG_S_CONV LOG_S_FVEG
   LOG_S_MT LOG_S_TOIL
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg10: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg10_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
ORGYN
;
run;
quit;
*------------------------------------------------------------*;
* Reg10: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg10_DMDB
validata = EMWS1.Trans_VALIDATE
outest = EMWS1.Reg10_EMESTIMATE
outterms = EMWS1.Reg10_OUTTERMS
outmap= EMWS1.Reg10_MAPDS namelen=200
;
class
ORGYN
CLASS
GENDER
NGROUP
OAC
REGION
TV_REG
;
model ORGYN =
CLASS
GENDER
INBILL
LOGLTIME
LOG_AFFL
LOG_AGE
LOG_BILL
LOG_LTIME
LOG_S_CONV
LOG_S_FVEG
LOG_S_MT
LOG_S_TOIL
NGROUP
OAC
REGION
TV_REG
/error=binomial link=LOGIT
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=NONE
Hierarchy=CLASS
Rule=NONE
;
;
score data=EMWS1.Trans_TEST
out=_null_
outfit=EMWS1.Reg10_FITTEST
role = TEST
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Reg10\EMPUBLISHSCORE.sas"
group=Reg10
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Reg10\EMFLOWSCORE.sas"
group=Reg10
residual
;
run;
quit;
