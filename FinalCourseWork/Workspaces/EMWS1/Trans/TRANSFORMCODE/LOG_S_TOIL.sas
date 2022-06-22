label LOG_S_TOIL = 'Transformed S_TOIL';
length LOG_S_TOIL 8;
if S_TOIL eq . then LOG_S_TOIL = .;
else do;
if S_TOIL + 1 > 0 then LOG_S_TOIL = log(S_TOIL + 1);
else LOG_S_TOIL = .;
end;
