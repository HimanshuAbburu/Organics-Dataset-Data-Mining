if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'AFFL'
'AGE'
'GENDER'
'REGION'
) then ROLE='INPUT';
else do;
ROLE='REJECTED';
COMMENT = "Reg3: Rejected using backward selection";
end;
end;
