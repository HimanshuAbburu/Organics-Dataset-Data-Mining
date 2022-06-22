drop _temp_;
if (P_ORGYN1 ge 0.72849462365591) then do;
b_ORGYN = 1;
end;
else
if (P_ORGYN1 ge 0.54601226993865) then do;
_temp_ = dmran(1234);
b_ORGYN = floor(2 + 2*_temp_);
end;
else
if (P_ORGYN1 ge 0.42322097378277) then do;
b_ORGYN = 4;
end;
else
if (P_ORGYN1 ge 0.26825127334465) then do;
_temp_ = dmran(1234);
b_ORGYN = floor(5 + 3*_temp_);
end;
else
if (P_ORGYN1 ge 0.265625) then do;
b_ORGYN = 8;
end;
else
if (P_ORGYN1 ge 0.21186440677966) then do;
b_ORGYN = 9;
end;
else
if (P_ORGYN1 ge 0.15384615384615) then do;
b_ORGYN = 10;
end;
else
if (P_ORGYN1 ge 0.13736263736263) then do;
b_ORGYN = 11;
end;
else
if (P_ORGYN1 ge 0.10831234256926) then do;
_temp_ = dmran(1234);
b_ORGYN = floor(12 + 4*_temp_);
end;
else
if (P_ORGYN1 ge 0.04545454545454) then do;
_temp_ = dmran(1234);
b_ORGYN = floor(16 + 2*_temp_);
end;
else
do;
_temp_ = dmran(1234);
b_ORGYN = floor(18 + 3*_temp_);
end;
