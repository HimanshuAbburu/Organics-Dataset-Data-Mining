if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'GENDER'
'LOG_AFFL'
'LOG_AGE'
'REGION'
) then ROLE='INPUT';
else do;
ROLE='REJECTED';
COMMENT = "Reg10: Rejected using stepwise selection";
end;
end;
