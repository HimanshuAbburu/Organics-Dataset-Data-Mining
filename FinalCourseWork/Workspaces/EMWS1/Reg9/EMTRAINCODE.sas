*------------------------------------------------------------*;
* Reg9: Create decision matrix;
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
set EMWS1.Impt2_TRAIN(keep=
BILL CLASS IMP_AFFL IMP_AGE IMP_GENDER IMP_LTIME IMP_NGROUP IMP_OAC IMP_REGION
IMP_TV_REG ORGYN S_CONV S_FVEG S_MT S_TOIL );
run;
*------------------------------------------------------------* ;
* Reg9: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CLASS(ASC) IMP_GENDER(ASC) IMP_NGROUP(ASC) IMP_OAC(ASC) IMP_REGION(ASC)
   IMP_TV_REG(ASC) ORGYN(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg9: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    BILL IMP_AFFL IMP_AGE IMP_LTIME S_CONV S_FVEG S_MT S_TOIL
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg9: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg9_DMDB
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
* Reg9: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg9_DMDB
validata = EMWS1.Impt2_VALIDATE
outest = EMWS1.Reg9_EMESTIMATE
outterms = EMWS1.Reg9_OUTTERMS
outmap= EMWS1.Reg9_MAPDS namelen=200
;
class
ORGYN
CLASS
IMP_GENDER
IMP_NGROUP
IMP_OAC
IMP_REGION
IMP_TV_REG
;
model ORGYN =
BILL
CLASS
IMP_AFFL
IMP_AGE
IMP_GENDER
IMP_LTIME
IMP_NGROUP
IMP_OAC
IMP_REGION
IMP_TV_REG
S_CONV
S_FVEG
S_MT
S_TOIL
/error=binomial link=LOGIT
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=NONE
Hierarchy=CLASS
Rule=NONE
;
;
score data=EMWS1.Impt2_TEST
out=_null_
outfit=EMWS1.Reg9_FITTEST
role = TEST
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Reg9\EMPUBLISHSCORE.sas"
group=Reg9
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Reg9\EMFLOWSCORE.sas"
group=Reg9
residual
;
run;
quit;
