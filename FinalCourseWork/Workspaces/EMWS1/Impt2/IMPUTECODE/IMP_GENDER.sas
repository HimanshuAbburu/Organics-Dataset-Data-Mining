length IMP_GENDER $1;
format IMP_GENDER $1.;
label IMP_GENDER = 'Imputed GENDER';
IMP_GENDER = GENDER;
if GENDER = '' then IMP_GENDER = 'F';
