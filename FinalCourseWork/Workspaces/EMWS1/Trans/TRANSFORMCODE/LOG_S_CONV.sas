label LOG_S_CONV = 'Transformed S_CONV';
length LOG_S_CONV 8;
if S_CONV eq . then LOG_S_CONV = .;
else do;
if S_CONV + 1 > 0 then LOG_S_CONV = log(S_CONV + 1);
else LOG_S_CONV = .;
end;
