label LOG_AFFL = 'Transformed AFFL';
length LOG_AFFL 8;
if AFFL eq . then LOG_AFFL = .;
else do;
if AFFL + 1 > 0 then LOG_AFFL = log(AFFL + 1);
else LOG_AFFL = .;
end;
