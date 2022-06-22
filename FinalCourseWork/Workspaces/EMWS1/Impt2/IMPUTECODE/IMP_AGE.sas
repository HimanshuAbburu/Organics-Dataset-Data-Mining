format IMP_AGE BEST12.0;
label IMP_AGE = 'Imputed AGE';
length IMP_AGE 8;
IMP_AGE = AGE;
if missing(AGE) then IMP_AGE = 53.771883289;
