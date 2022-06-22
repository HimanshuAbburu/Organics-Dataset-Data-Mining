format IMP_LTIME BEST12.0;
label IMP_LTIME = 'Imputed LTIME';
length IMP_LTIME 8;
IMP_LTIME = LTIME;
if missing(LTIME) then IMP_LTIME = 6.5795856493;
