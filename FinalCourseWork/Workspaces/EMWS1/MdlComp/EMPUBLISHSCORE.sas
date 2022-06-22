drop _temp_;
if (P_ORGYN1 ge 0.69659975221762) then do;
b_ORGYN = 1;
end;
else
if (P_ORGYN1 ge 0.55583853190643) then do;
b_ORGYN = 2;
end;
else
if (P_ORGYN1 ge 0.45846437114752) then do;
b_ORGYN = 3;
end;
else
if (P_ORGYN1 ge 0.38051355210802) then do;
b_ORGYN = 4;
end;
else
if (P_ORGYN1 ge 0.32176240536462) then do;
b_ORGYN = 5;
end;
else
if (P_ORGYN1 ge 0.26263393498341) then do;
b_ORGYN = 6;
end;
else
if (P_ORGYN1 ge 0.2590142243) then do;
_temp_ = dmran(1234);
b_ORGYN = floor(7 + 4*_temp_);
end;
else
if (P_ORGYN1 ge 0.23210452330757) then do;
b_ORGYN = 11;
end;
else
if (P_ORGYN1 ge 0.19125841321922) then do;
b_ORGYN = 12;
end;
else
if (P_ORGYN1 ge 0.16016998143595) then do;
b_ORGYN = 13;
end;
else
if (P_ORGYN1 ge 0.12907496955237) then do;
b_ORGYN = 14;
end;
else
if (P_ORGYN1 ge 0.10319225716936) then do;
b_ORGYN = 15;
end;
else
if (P_ORGYN1 ge 0.08218028089727) then do;
b_ORGYN = 16;
end;
else
if (P_ORGYN1 ge 0.06403744150395) then do;
b_ORGYN = 17;
end;
else
if (P_ORGYN1 ge 0.04571903534723) then do;
b_ORGYN = 18;
end;
else
if (P_ORGYN1 ge 0.02622094157811) then do;
b_ORGYN = 19;
end;
else
do;
b_ORGYN = 20;
end;
