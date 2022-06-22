length IMP_REGION $10;
format IMP_REGION $10.;
label IMP_REGION = 'Imputed REGION';
IMP_REGION = REGION;
if REGION = '' then IMP_REGION = 'South East';
