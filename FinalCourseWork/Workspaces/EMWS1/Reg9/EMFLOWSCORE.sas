*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_ORGYN $ 12;
label I_ORGYN = 'Into: ORGYN' ;
*** Target Values;
array REG9DRF [2] $12 _temporary_ ('1' '0' );
label U_ORGYN = 'Unnormalized Into: ORGYN' ;
format U_ORGYN BEST12.;
*** Unnormalized target values;
ARRAY REG9DRU[2]  _TEMPORARY_ (1 0);

*** Generate dummy variables for ORGYN ;
drop _Y ;
label F_ORGYN = 'From: ORGYN' ;
length F_ORGYN $ 12;
F_ORGYN = put( ORGYN , BEST12. );
%DMNORMIP( F_ORGYN )
if missing( ORGYN ) then do;
   _Y = .;
end;
else do;
   if F_ORGYN = '0'  then do;
      _Y = 1;
   end;
   else if F_ORGYN = '1'  then do;
      _Y = 0;
   end;
   else do;
      _Y = .;
   end;
end;

drop _DM_BAD;
_DM_BAD=0;

*** Check IMP_AFFL for missing values ;
if missing( IMP_AFFL ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check IMP_AGE for missing values ;
if missing( IMP_AGE ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check S_MT for missing values ;
if missing( S_MT ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check S_TOIL for missing values ;
if missing( S_TOIL ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for IMP_GENDER ;
drop _2_0 _2_1 ;
if missing( IMP_GENDER ) then do;
   _2_0 = .;
   _2_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( IMP_GENDER , $1. );
   %DMNORMIP( _dm1 )
   if _dm1 = 'F'  then do;
      _2_0 = 1;
      _2_1 = 0;
   end;
   else if _dm1 = 'M'  then do;
      _2_0 = 0;
      _2_1 = 1;
   end;
   else if _dm1 = 'U'  then do;
      _2_0 = -1;
      _2_1 = -1;
   end;
   else do;
      _2_0 = .;
      _2_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_NGROUP ;
drop _3_0 _3_1 _3_2 _3_3 _3_4 _3_5 ;
*** encoding is sparse, initialize to zero;
_3_0 = 0;
_3_1 = 0;
_3_2 = 0;
_3_3 = 0;
_3_4 = 0;
_3_5 = 0;
if missing( IMP_NGROUP ) then do;
   _3_0 = .;
   _3_1 = .;
   _3_2 = .;
   _3_3 = .;
   _3_4 = .;
   _3_5 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( IMP_NGROUP , $1. );
   %DMNORMIP( _dm1 )
   _dm_find = 0; drop _dm_find;
   if _dm1 <= 'D'  then do;
      if _dm1 <= 'B'  then do;
         if _dm1 = 'A'  then do;
            _3_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'B'  then do;
               _3_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'C'  then do;
            _3_2 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'D'  then do;
               _3_3 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm1 <= 'F'  then do;
         if _dm1 = 'E'  then do;
            _3_4 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'F'  then do;
               _3_5 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'U'  then do;
            _3_0 = -1;
            _3_1 = -1;
            _3_2 = -1;
            _3_3 = -1;
            _3_4 = -1;
            _3_5 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _3_0 = .;
      _3_1 = .;
      _3_2 = .;
      _3_3 = .;
      _3_4 = .;
      _3_5 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.2435;
   _P1 = 0.7565;
   goto REG9DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: IMP_AFFL ;
_TEMP = IMP_AFFL ;
_LP0 = _LP0 + (    0.26039364275841 * _TEMP);

***  Effect: IMP_AGE ;
_TEMP = IMP_AGE ;
_LP0 = _LP0 + (   -0.05004810840841 * _TEMP);

***  Effect: IMP_GENDER ;
_TEMP = 1;
_LP0 = _LP0 + (    0.85991042693086) * _TEMP * _2_0;
_LP0 = _LP0 + (   -0.03659252198303) * _TEMP * _2_1;

***  Effect: IMP_NGROUP ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.01396369274057) * _TEMP * _3_0;
_LP0 = _LP0 + (   -0.07206209940244) * _TEMP * _3_1;
_LP0 = _LP0 + (    0.07371325918615) * _TEMP * _3_2;
_LP0 = _LP0 + (    0.09450813964029) * _TEMP * _3_3;
_LP0 = _LP0 + (   -0.06211772064091) * _TEMP * _3_4;
_LP0 = _LP0 + (    0.39032074826004) * _TEMP * _3_5;

***  Effect: S_MT ;
_TEMP = S_MT ;
_LP0 = _LP0 + (     0.0145054360511 * _TEMP);

***  Effect: S_TOIL ;
_TEMP = S_TOIL ;
_LP0 = _LP0 + (    0.01098853269129 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -2.20779149117381 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REG9DR1:

*** Residuals;
if (_Y = .) then do;
   R_ORGYN1 = .;
   R_ORGYN0 = .;
end;
else do;
    label R_ORGYN1 = 'Residual: ORGYN=1' ;
    label R_ORGYN0 = 'Residual: ORGYN=0' ;
   R_ORGYN1 = - _P0;
   R_ORGYN0 = - _P1;
   select( _Y );
      when (0)  R_ORGYN1 = R_ORGYN1 + 1;
      when (1)  R_ORGYN0 = R_ORGYN0 + 1;
   end;
end;

*** Posterior Probabilities and Predicted Level;
label P_ORGYN1 = 'Predicted: ORGYN=1' ;
label P_ORGYN0 = 'Predicted: ORGYN=0' ;
P_ORGYN1 = _P0;
_MAXP = _P0;
_IY = 1;
P_ORGYN0 = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_ORGYN = REG9DRF[_IY];
U_ORGYN = REG9DRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
