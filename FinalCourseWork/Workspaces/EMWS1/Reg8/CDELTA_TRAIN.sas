if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'AFFL'
'AGE'
'GENDER'
'REGION'
) then ROLE='INPUT';
else do;
ROLE='REJECTED';
COMMENT = "Reg8: Rejected using stepwise selection";
end;
end;
