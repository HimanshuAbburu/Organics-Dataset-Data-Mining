
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
