label LOG_S_FVEG = 'Transformed S_FVEG';
length LOG_S_FVEG 8;
if S_FVEG eq . then LOG_S_FVEG = .;
else do;
if S_FVEG + 1 > 0 then LOG_S_FVEG = log(S_FVEG + 1);
else LOG_S_FVEG = .;
end;
