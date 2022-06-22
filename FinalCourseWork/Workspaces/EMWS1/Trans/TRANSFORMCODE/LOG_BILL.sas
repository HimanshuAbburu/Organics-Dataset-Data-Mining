label LOG_BILL = 'Transformed BILL';
length LOG_BILL 8;
if BILL eq . then LOG_BILL = .;
else do;
if BILL + 1 > 0 then LOG_BILL = log(BILL + 1);
else LOG_BILL = .;
end;
