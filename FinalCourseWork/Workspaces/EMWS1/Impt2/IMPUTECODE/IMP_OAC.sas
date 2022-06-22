length IMP_OAC 8;
format IMP_OAC BEST12.0;
label IMP_OAC = 'Imputed OAC';
IMP_OAC = OAC;
if missing(OAC) then IMP_OAC = 2;
