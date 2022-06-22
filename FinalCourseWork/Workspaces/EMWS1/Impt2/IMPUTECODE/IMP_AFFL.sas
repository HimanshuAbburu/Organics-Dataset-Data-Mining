format IMP_AFFL BEST12.0;
label IMP_AFFL = 'Imputed AFFL';
length IMP_AFFL 8;
IMP_AFFL = AFFL;
if missing(AFFL) then IMP_AFFL = 8.7269129288;
