label LOG_S_MT = 'Transformed S_MT';
length LOG_S_MT 8;
if S_MT eq . then LOG_S_MT = .;
else do;
if S_MT + 1 > 0 then LOG_S_MT = log(S_MT + 1);
else LOG_S_MT = .;
end;
