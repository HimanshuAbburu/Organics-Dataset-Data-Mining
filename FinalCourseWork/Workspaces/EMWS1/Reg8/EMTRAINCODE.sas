*------------------------------------------------------------*;
* Reg8: Create decision matrix;
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
data EM_DMREG / view=EM_DMREG;
set EMWS1.Filter_TRAIN(keep=
AFFL AGE BILL CLASS GENDER LTIME NGROUP OAC ORGYN REGION S_CONV S_FVEG S_MT
S_TOIL TV_REG );
run;
*------------------------------------------------------------* ;
* Reg8: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CLASS(ASC) GENDER(ASC) NGROUP(ASC) OAC(ASC) ORGYN(DESC) REGION(ASC)
   TV_REG(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg8: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AFFL AGE BILL LTIME S_CONV S_FVEG S_MT S_TOIL
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg8: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg8_DMDB
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
* Reg8: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg8_DMDB
validata = EMWS1.Filter_VALIDATE
outest = EMWS1.Reg8_EMESTIMATE
outterms = EMWS1.Reg8_OUTTERMS
outmap= EMWS1.Reg8_MAPDS namelen=200
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
AFFL
AGE
BILL
CLASS
GENDER
LTIME
NGROUP
OAC
REGION
S_CONV
S_FVEG
S_MT
S_TOIL
TV_REG
/error=binomial link=LOGIT
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=NONE
Hierarchy=CLASS
Rule=NONE
;
;
score data=EMWS1.Filter_TEST
out=_null_
outfit=EMWS1.Reg8_FITTEST
role = TEST
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Reg8\EMPUBLISHSCORE.sas"
group=Reg8
;
code file="H:\DMU_Final Year\Data Mining\FinalCW\FinalCourseWork\Workspaces\EMWS1\Reg8\EMFLOWSCORE.sas"
group=Reg8
residual
;
run;
quit;
