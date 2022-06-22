label LOG_AGE = 'Transformed AGE';
length LOG_AGE 8;
if AGE eq . then LOG_AGE = .;
else do;
if AGE + 1 > 0 then LOG_AGE = log(AGE + 1);
else LOG_AGE = .;
end;
