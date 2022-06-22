label LOG_LTIME = 'Transformed LTIME';
length LOG_LTIME 8;
if LTIME eq . then LOG_LTIME = .;
else do;
if LTIME + 1 > 0 then LOG_LTIME = log(LTIME + 1);
else LOG_LTIME = .;
end;
