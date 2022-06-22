length IMP_TV_REG $12;
format IMP_TV_REG $12.;
label IMP_TV_REG = 'Imputed TV_REG';
IMP_TV_REG = TV_REG;
if TV_REG = '' then IMP_TV_REG = 'London';
