if upcase(NAME) = "BILL" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "CLASS" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "LTIME" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "NGROUP" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "OAC" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "Q_ORGYN0" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "Q_ORGYN1" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "REGION" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "S_FVEG" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "S_MT" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "TV_REG" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "_NODE_" then do;
ROLE = "SEGMENT";
LEVEL = "NOMINAL";
end;
