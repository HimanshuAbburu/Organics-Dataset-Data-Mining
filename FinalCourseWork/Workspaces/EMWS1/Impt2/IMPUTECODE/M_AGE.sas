label M_AGE = "Imputation Indicator for AGE";
if missing(AGE) then M_AGE = 1;
else M_AGE= 0;
