length IMP_NGROUP $1;
format IMP_NGROUP $1.;
label IMP_NGROUP = 'Imputed NGROUP';
IMP_NGROUP = NGROUP;
if NGROUP = '' then IMP_NGROUP = 'C';
