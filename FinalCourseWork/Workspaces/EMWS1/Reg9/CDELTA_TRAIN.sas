if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'IMP_AFFL'
'IMP_AGE'
'IMP_GENDER'
'IMP_NGROUP'
'S_MT'
'S_TOIL'
) then ROLE='INPUT';
else do;
ROLE='REJECTED';
COMMENT = "Reg9: Rejected using stepwise selection";
end;
end;
