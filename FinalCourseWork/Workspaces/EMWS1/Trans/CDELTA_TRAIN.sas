*------------------------------------------------------------*;
* Computed Code;
*------------------------------------------------------------*;

if NAME="LOG_AFFL" then do;
   COMMENT = "log(AFFL  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="AFFL" then delete;

if NAME="LOG_AGE" then do;
   COMMENT = "log(AGE  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="AGE" then delete;

if NAME="LOG_BILL" then do;
   COMMENT = "log(BILL  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="BILL" then delete;

if NAME="LOG_LTIME" then do;
   COMMENT = "log(LTIME  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="LTIME" then delete;

if NAME="LOG_S_CONV" then do;
   COMMENT = "log(S_CONV  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="S_CONV" then delete;

if NAME="LOG_S_FVEG" then do;
   COMMENT = "log(S_FVEG  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="S_FVEG" then delete;

if NAME="LOG_S_MT" then do;
   COMMENT = "log(S_MT  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="S_MT" then delete;

if NAME="LOG_S_TOIL" then do;
   COMMENT = "log(S_TOIL  + 1) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="S_TOIL" then delete;
*------------------------------------------------------------*;
* Formula Code;
*------------------------------------------------------------*;

if NAME="INBILL" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="INTERVAL";
end;
if NAME="BILL" then delete;

if NAME="LOGLTIME" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="INTERVAL";
end;
if NAME="LTIME" then delete;
