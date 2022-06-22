

length _FILTERFMT1  $200;
drop _FILTERFMT1 ;
_FILTERFMT1= put(GENDER,$1.);
length _FILTERNORM1  $32;
drop _FILTERNORM1 ;
%dmnormcp(_FILTERFMT1,_FILTERNORM1);


length _FILTERFMT2  $200;
drop _FILTERFMT2 ;
_FILTERFMT2= put(NGROUP,$1.);
length _FILTERNORM2  $32;
drop _FILTERNORM2 ;
%dmnormcp(_FILTERFMT2,_FILTERNORM2);


length _FILTERFMT3  $200;
drop _FILTERFMT3 ;
_FILTERFMT3= put(OAC,BEST12.0);
length _FILTERNORM3  $32;
drop _FILTERNORM3 ;
%dmnormcp(_FILTERFMT3,_FILTERNORM3);


length _FILTERFMT4  $200;
drop _FILTERFMT4 ;
_FILTERFMT4= put(REGION,$10.);
length _FILTERNORM4  $32;
drop _FILTERNORM4 ;
%dmnormcp(_FILTERFMT4,_FILTERNORM4);


length _FILTERFMT5  $200;
drop _FILTERFMT5 ;
_FILTERFMT5= put(TV_REG,$12.);
length _FILTERNORM5  $32;
drop _FILTERNORM5 ;
%dmnormcp(_FILTERFMT5,_FILTERNORM5);
if
_FILTERNORM1 not in ( ' ')
 and
_FILTERNORM2 not in ( ' ' , 'U')
 and
_FILTERNORM3 not in ( '.')
 and
_FILTERNORM4 not in ( ' ')
 and
_FILTERNORM5 not in ( ' ' , 'BORDER')
and
( AFFL ne . and (-1.588810246<=AFFL) and (AFFL<=19.042636103))
and ( AGE eq . or (14.228085294<=AGE) and (AGE<=93.315681284))
and ( BILL eq . or (-16055.13349<=BILL) and (BILL<=24791.881486))
and ( CUSTID eq . or (-8450124.657<=CUSTID) and (CUSTID<=31215812.911))
and ( LCDATE eq . or (4825.3093136<=LCDATE) and (LCDATE<=18471.27583))
and ( LTIME eq . or (-7.458359558<=LTIME) and (LTIME<=20.617530857))
and ( S_CONV eq . or (0.46557876<=S_CONV) and (S_CONV<=21.08482124))
and ( S_FVEG eq . or (-0.565993347<=S_FVEG) and (S_FVEG<=59.898833347))
and ( S_MT eq . or (0.0801706553<=S_MT) and (S_MT<=49.893314345))
and ( S_TOIL eq . or (-5.923589234<=S_TOIL) and (S_TOIL<=44.677649234))
then do;
if M_FILTER eq . then M_FILTER = 0;
else M_FILTER = M_FILTER + 0;
end;
else M_FILTER = 1;
label M_FILTER = 'Filtered Indicator';
length M_FILTER 8;
