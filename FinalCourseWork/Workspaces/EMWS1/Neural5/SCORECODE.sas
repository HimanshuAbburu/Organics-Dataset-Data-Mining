***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4 
;
      label S_INBILL = 'Standard: INBILL' ;

      label S_LOGLTIME = 'Standard: LOGLTIME' ;

      label S_LOG_AFFL = 'Standard: LOG_AFFL' ;

      label S_LOG_AGE = 'Standard: LOG_AGE' ;

      label S_LOG_BILL = 'Standard: LOG_BILL' ;

      label S_LOG_LTIME = 'Standard: LOG_LTIME' ;

      label S_LOG_S_CONV = 'Standard: LOG_S_CONV' ;

      label S_LOG_S_FVEG = 'Standard: LOG_S_FVEG' ;

      label S_LOG_S_MT = 'Standard: LOG_S_MT' ;

      label S_LOG_S_TOIL = 'Standard: LOG_S_TOIL' ;

      label CLASSGold = 'Dummy: CLASS=Gold' ;

      label CLASSPlatinum = 'Dummy: CLASS=Platinum' ;

      label CLASSSilver = 'Dummy: CLASS=Silver' ;

      label GENDERF = 'Dummy: GENDER=F' ;

      label GENDERM = 'Dummy: GENDER=M' ;

      label NGROUPA = 'Dummy: NGROUP=A' ;

      label NGROUPB = 'Dummy: NGROUP=B' ;

      label NGROUPC = 'Dummy: NGROUP=C' ;

      label NGROUPD = 'Dummy: NGROUP=D' ;

      label NGROUPE = 'Dummy: NGROUP=E' ;

      label NGROUPF = 'Dummy: NGROUP=F' ;

      label OAC1 = 'Dummy: OAC=1' ;

      label OAC2 = 'Dummy: OAC=2' ;

      label OAC3 = 'Dummy: OAC=3' ;

      label OAC4 = 'Dummy: OAC=4' ;

      label OAC5 = 'Dummy: OAC=5' ;

      label OAC6 = 'Dummy: OAC=6' ;

      label OAC7 = 'Dummy: OAC=7' ;

      label REGIONMidlands = 'Dummy: REGION=Midlands' ;

      label REGIONNorth = 'Dummy: REGION=North' ;

      label REGIONScottish = 'Dummy: REGION=Scottish' ;

      label REGIONSouth_East = 'Dummy: REGION=South East' ;

      label TV_REGBorder = 'Dummy: TV_REG=Border' ;

      label TV_REGC_Scotland = 'Dummy: TV_REG=C Scotland' ;

      label TV_REGEast = 'Dummy: TV_REG=East' ;

      label TV_REGLondon = 'Dummy: TV_REG=London' ;

      label TV_REGMidlands = 'Dummy: TV_REG=Midlands' ;

      label TV_REGN_East = 'Dummy: TV_REG=N East' ;

      label TV_REGN_Scot = 'Dummy: TV_REG=N Scot' ;

      label TV_REGN_West = 'Dummy: TV_REG=N West' ;

      label TV_REGS___S_East = 'Dummy: TV_REG=S & S East' ;

      label TV_REGS_West = 'Dummy: TV_REG=S West' ;

      label TV_REGUlster = 'Dummy: TV_REG=Ulster' ;

      label TV_REGWales___West = 'Dummy: TV_REG=Wales & West' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label I_ORGYN = 'Into: ORGYN' ;

      label U_ORGYN = 'Unnormalized Into: ORGYN' ;

      label P_ORGYN1 = 'Predicted: ORGYN=1' ;

      label P_ORGYN0 = 'Predicted: ORGYN=0' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for CLASS ;
drop CLASSGold CLASSPlatinum CLASSSilver ;
if missing( CLASS ) then do;
   CLASSGold = .;
   CLASSPlatinum = .;
   CLASSSilver = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   _dm8 = put( CLASS , $8. );
   %DMNORMIP( _dm8 )
   if _dm8 = 'SILVER'  then do;
      CLASSGold = 0;
      CLASSPlatinum = 0;
      CLASSSilver = 1;
   end;
   else if _dm8 = 'GOLD'  then do;
      CLASSGold = 1;
      CLASSPlatinum = 0;
      CLASSSilver = 0;
   end;
   else if _dm8 = 'TIN'  then do;
      CLASSGold = -1;
      CLASSPlatinum = -1;
      CLASSSilver = -1;
   end;
   else if _dm8 = 'PLATINUM'  then do;
      CLASSGold = 0;
      CLASSPlatinum = 1;
      CLASSSilver = 0;
   end;
   else do;
      CLASSGold = .;
      CLASSPlatinum = .;
      CLASSSilver = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GENDER ;
drop GENDERF GENDERM ;
if missing( GENDER ) then do;
   GENDERF = .;
   GENDERM = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( GENDER , $1. );
   %DMNORMIP( _dm1 )
   if _dm1 = 'F'  then do;
      GENDERF = 1;
      GENDERM = 0;
   end;
   else if _dm1 = 'M'  then do;
      GENDERF = 0;
      GENDERM = 1;
   end;
   else if _dm1 = 'U'  then do;
      GENDERF = -1;
      GENDERM = -1;
   end;
   else do;
      GENDERF = .;
      GENDERM = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for NGROUP ;
drop NGROUPA NGROUPB NGROUPC NGROUPD NGROUPE NGROUPF ;
*** encoding is sparse, initialize to zero;
NGROUPA = 0;
NGROUPB = 0;
NGROUPC = 0;
NGROUPD = 0;
NGROUPE = 0;
NGROUPF = 0;
if missing( NGROUP ) then do;
   NGROUPA = .;
   NGROUPB = .;
   NGROUPC = .;
   NGROUPD = .;
   NGROUPE = .;
   NGROUPF = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( NGROUP , $1. );
   %DMNORMIP( _dm1 )
   _dm_find = 0; drop _dm_find;
   if _dm1 <= 'D'  then do;
      if _dm1 <= 'B'  then do;
         if _dm1 = 'A'  then do;
            NGROUPA = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'B'  then do;
               NGROUPB = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'C'  then do;
            NGROUPC = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'D'  then do;
               NGROUPD = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm1 <= 'F'  then do;
         if _dm1 = 'E'  then do;
            NGROUPE = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'F'  then do;
               NGROUPF = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'U'  then do;
            NGROUPA = -1;
            NGROUPB = -1;
            NGROUPC = -1;
            NGROUPD = -1;
            NGROUPE = -1;
            NGROUPF = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      NGROUPA = .;
      NGROUPB = .;
      NGROUPC = .;
      NGROUPD = .;
      NGROUPE = .;
      NGROUPF = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for OAC ;
drop OAC1 OAC2 OAC3 OAC4 OAC5 OAC6 OAC7 ;
*** encoding is sparse, initialize to zero;
OAC1 = 0;
OAC2 = 0;
OAC3 = 0;
OAC4 = 0;
OAC5 = 0;
OAC6 = 0;
OAC7 = 0;
if missing( OAC ) then do;
   OAC1 = .;
   OAC2 = .;
   OAC3 = .;
   OAC4 = .;
   OAC5 = .;
   OAC6 = .;
   OAC7 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( OAC , BEST12. );
   %DMNORMIP( _dm12 )
   _dm_find = 0; drop _dm_find;
   if _dm12 <= '4'  then do;
      if _dm12 <= '2'  then do;
         if _dm12 = '1'  then do;
            OAC1 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '2'  then do;
               OAC2 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm12 = '3'  then do;
            OAC3 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '4'  then do;
               OAC4 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm12 <= '6'  then do;
         if _dm12 = '5'  then do;
            OAC5 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '6'  then do;
               OAC6 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm12 = '7'  then do;
            OAC7 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '8'  then do;
               OAC1 = -1;
               OAC2 = -1;
               OAC3 = -1;
               OAC4 = -1;
               OAC5 = -1;
               OAC6 = -1;
               OAC7 = -1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   if not _dm_find then do;
      OAC1 = .;
      OAC2 = .;
      OAC3 = .;
      OAC4 = .;
      OAC5 = .;
      OAC6 = .;
      OAC7 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REGION ;
drop REGIONMidlands REGIONNorth REGIONScottish REGIONSouth_East ;
*** encoding is sparse, initialize to zero;
REGIONMidlands = 0;
REGIONNorth = 0;
REGIONScottish = 0;
REGIONSouth_East = 0;
if missing( REGION ) then do;
   REGIONMidlands = .;
   REGIONNorth = .;
   REGIONScottish = .;
   REGIONSouth_East = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( REGION , $10. );
   %DMNORMIP( _dm10 )
   _dm_find = 0; drop _dm_find;
   if _dm10 <= 'SCOTTISH'  then do;
      if _dm10 <= 'NORTH'  then do;
         if _dm10 = 'MIDLANDS'  then do;
            REGIONMidlands = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm10 = 'NORTH'  then do;
               REGIONNorth = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm10 = 'SCOTTISH'  then do;
            REGIONScottish = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm10 = 'SOUTH EAST'  then do;
         REGIONSouth_East = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm10 = 'SOUTH WEST'  then do;
            REGIONMidlands = -1;
            REGIONNorth = -1;
            REGIONScottish = -1;
            REGIONSouth_East = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      REGIONMidlands = .;
      REGIONNorth = .;
      REGIONScottish = .;
      REGIONSouth_East = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for TV_REG ;
drop TV_REGBorder TV_REGC_Scotland TV_REGEast TV_REGLondon TV_REGMidlands 
        TV_REGN_East TV_REGN_Scot TV_REGN_West TV_REGS___S_East TV_REGS_West 
        TV_REGUlster TV_REGWales___West ;
*** encoding is sparse, initialize to zero;
TV_REGBorder = 0;
TV_REGC_Scotland = 0;
TV_REGEast = 0;
TV_REGLondon = 0;
TV_REGMidlands = 0;
TV_REGN_East = 0;
TV_REGN_Scot = 0;
TV_REGN_West = 0;
TV_REGS___S_East = 0;
TV_REGS_West = 0;
TV_REGUlster = 0;
TV_REGWales___West = 0;
if missing( TV_REG ) then do;
   TV_REGBorder = .;
   TV_REGC_Scotland = .;
   TV_REGEast = .;
   TV_REGLondon = .;
   TV_REGMidlands = .;
   TV_REGN_East = .;
   TV_REGN_Scot = .;
   TV_REGN_West = .;
   TV_REGS___S_East = .;
   TV_REGS_West = .;
   TV_REGUlster = .;
   TV_REGWales___West = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( TV_REG , $12. );
   %DMNORMIP( _dm12 )
   if _dm12 = 'LONDON'  then do;
      TV_REGLondon = 1;
   end;
   else if _dm12 = 'MIDLANDS'  then do;
      TV_REGMidlands = 1;
   end;
   else if _dm12 = 'S & S EAST'  then do;
      TV_REGS___S_East = 1;
   end;
   else if _dm12 = 'N WEST'  then do;
      TV_REGN_West = 1;
   end;
   else if _dm12 = 'WALES & WEST'  then do;
      TV_REGWales___West = 1;
   end;
   else if _dm12 = 'EAST'  then do;
      TV_REGEast = 1;
   end;
   else if _dm12 = 'YORKSHIRE'  then do;
      TV_REGBorder = -1;
      TV_REGC_Scotland = -1;
      TV_REGEast = -1;
      TV_REGLondon = -1;
      TV_REGMidlands = -1;
      TV_REGN_East = -1;
      TV_REGN_Scot = -1;
      TV_REGN_West = -1;
      TV_REGS___S_East = -1;
      TV_REGS_West = -1;
      TV_REGUlster = -1;
      TV_REGWales___West = -1;
   end;
   else if _dm12 = 'C SCOTLAND'  then do;
      TV_REGC_Scotland = 1;
   end;
   else if _dm12 = 'N EAST'  then do;
      TV_REGN_East = 1;
   end;
   else if _dm12 = 'S WEST'  then do;
      TV_REGS_West = 1;
   end;
   else if _dm12 = 'ULSTER'  then do;
      TV_REGUlster = 1;
   end;
   else if _dm12 = 'N SCOT'  then do;
      TV_REGN_Scot = 1;
   end;
   else if _dm12 = 'BORDER'  then do;
      TV_REGBorder = 1;
   end;
   else do;
      TV_REGBorder = .;
      TV_REGC_Scotland = .;
      TV_REGEast = .;
      TV_REGLondon = .;
      TV_REGMidlands = .;
      TV_REGN_East = .;
      TV_REGN_Scot = .;
      TV_REGN_West = .;
      TV_REGS___S_East = .;
      TV_REGS_West = .;
      TV_REGUlster = .;
      TV_REGWales___West = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   INBILL , 
   LOGLTIME , 
   LOG_AFFL , 
   LOG_AGE , 
   LOG_BILL , 
   LOG_LTIME , 
   LOG_S_CONV , 
   LOG_S_FVEG , 
   LOG_S_MT , 
   LOG_S_TOIL   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_INBILL  =    -1.54015846954087 +     2.18927998513272 * INBILL ;
   S_LOGLTIME  =    -3.21547508014533 +     3.97519006360012 * LOGLTIME ;
   S_LOG_AFFL  =    -6.17574768964289 +     2.79075953302032 * LOG_AFFL ;
   S_LOG_AGE  =    -15.4719595251569 +     3.89543310774884 * LOG_AGE ;
   S_LOG_BILL  =    -1.47019319248608 +     0.25881576775256 * LOG_BILL ;
   S_LOG_LTIME  =    -3.21547508014685 +     1.72640310913892 * LOG_LTIME ;
   S_LOG_S_CONV  =    -7.05491766707569 +     2.92105809323276 * LOG_S_CONV ;
   S_LOG_S_FVEG  =    -6.83450062217232 +     2.04670568477273 * LOG_S_FVEG ;
   S_LOG_S_MT  =    -7.80055025996739 +     2.44462661328155 * LOG_S_MT ;
   S_LOG_S_TOIL  =    -5.34235249999785 +     1.84245988645972 * LOG_S_TOIL ;
END;
ELSE DO;
   IF MISSING( INBILL ) THEN S_INBILL  = . ;
   ELSE S_INBILL  =    -1.54015846954087 +     2.18927998513272 * INBILL ;
   IF MISSING( LOGLTIME ) THEN S_LOGLTIME  = . ;
   ELSE S_LOGLTIME  =    -3.21547508014533 +     3.97519006360012 * LOGLTIME ;
   IF MISSING( LOG_AFFL ) THEN S_LOG_AFFL  = . ;
   ELSE S_LOG_AFFL  =    -6.17574768964289 +     2.79075953302032 * LOG_AFFL ;
   IF MISSING( LOG_AGE ) THEN S_LOG_AGE  = . ;
   ELSE S_LOG_AGE  =    -15.4719595251569 +     3.89543310774884 * LOG_AGE ;
   IF MISSING( LOG_BILL ) THEN S_LOG_BILL  = . ;
   ELSE S_LOG_BILL  =    -1.47019319248608 +     0.25881576775256 * LOG_BILL ;
   IF MISSING( LOG_LTIME ) THEN S_LOG_LTIME  = . ;
   ELSE S_LOG_LTIME  =    -3.21547508014685 +     1.72640310913892 * LOG_LTIME
         ;
   IF MISSING( LOG_S_CONV ) THEN S_LOG_S_CONV  = . ;
   ELSE S_LOG_S_CONV  =    -7.05491766707569 +     2.92105809323276 * 
        LOG_S_CONV ;
   IF MISSING( LOG_S_FVEG ) THEN S_LOG_S_FVEG  = . ;
   ELSE S_LOG_S_FVEG  =    -6.83450062217232 +     2.04670568477273 * 
        LOG_S_FVEG ;
   IF MISSING( LOG_S_MT ) THEN S_LOG_S_MT  = . ;
   ELSE S_LOG_S_MT  =    -7.80055025996739 +     2.44462661328155 * LOG_S_MT ;
   IF MISSING( LOG_S_TOIL ) THEN S_LOG_S_TOIL  = . ;
   ELSE S_LOG_S_TOIL  =    -5.34235249999785 +     1.84245988645972 * 
        LOG_S_TOIL ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.07883796848535 * S_INBILL  +     0.18905171597568 * S_LOGLTIME
          +     0.57333752089258 * S_LOG_AFFL  +    -0.59490184689174 * 
        S_LOG_AGE  +     -0.1598047104357 * S_LOG_BILL
          +     -0.1176915138964 * S_LOG_LTIME  +    -0.27005675182427 * 
        S_LOG_S_CONV  +    -0.02036305666033 * S_LOG_S_FVEG
          +     0.09479205121596 * S_LOG_S_MT  +     0.01389017736164 * 
        S_LOG_S_TOIL ;
   H12  =     0.05089710692367 * S_INBILL  +    -0.09668294925016 * S_LOGLTIME
          +     0.51207997737356 * S_LOG_AFFL  +    -0.30920931422479 * 
        S_LOG_AGE  +    -0.05438018032201 * S_LOG_BILL
          +    -0.05612499994177 * S_LOG_LTIME  +     0.28283459287912 * 
        S_LOG_S_CONV  +    -0.05263199956608 * S_LOG_S_FVEG
          +     -0.2027304823415 * S_LOG_S_MT  +     0.10498815022311 * 
        S_LOG_S_TOIL ;
   H13  =     0.18444328699407 * S_INBILL  +     0.10674846519867 * S_LOGLTIME
          +    -0.41816691724214 * S_LOG_AFFL  +    -0.00547799907408 * 
        S_LOG_AGE  +    -0.09775788183185 * S_LOG_BILL
          +    -0.01502579729306 * S_LOG_LTIME  +     0.05343220797696 * 
        S_LOG_S_CONV  +    -0.03799313722456 * S_LOG_S_FVEG
          +    -0.14807511631655 * S_LOG_S_MT  +     0.06066488072754 * 
        S_LOG_S_TOIL ;
   H11  = H11  +     0.11498287716378 * CLASSGold  +     0.23446528413483 * 
        CLASSPlatinum  +    -0.07584725512279 * CLASSSilver
          +     0.53746038127109 * GENDERF  +    -0.19277416793633 * GENDERM
          +     0.05201270335437 * NGROUPA  +    -0.31710354938322 * NGROUPB
          +    -0.16987384585651 * NGROUPC  +     0.00987044470977 * NGROUPD
          +    -0.25920221128988 * NGROUPE  +     0.03399287047892 * NGROUPF
          +    -0.15284033328561 * OAC1  +    -0.10446196062031 * OAC2
          +      0.1718626267842 * OAC3  +     0.16828083710382 * OAC4
          +    -0.19381156198533 * OAC5  +     0.02550737570223 * OAC6
          +    -0.23462332370985 * OAC7  +     -0.1411352902199 * 
        REGIONMidlands  +    -0.17550917894612 * REGIONNorth
          +    -0.08527448794793 * REGIONScottish  +    -0.04703133387024 * 
        REGIONSouth_East  +     0.05636669103534 * TV_REGBorder
          +     0.04824534639665 * TV_REGC_Scotland  +     0.12660029206504 * 
        TV_REGEast  +    -0.17081529966986 * TV_REGLondon
          +     0.07911273376488 * TV_REGMidlands  +     0.06823403664006 * 
        TV_REGN_East  +    -0.00941798612167 * TV_REGN_Scot
          +    -0.21501652759166 * TV_REGN_West  +     0.33291551124623 * 
        TV_REGS___S_East  +      0.0016350024918 * TV_REGS_West
          +    -0.26163329815184 * TV_REGUlster  +    -0.03053543095102 * 
        TV_REGWales___West ;
   H12  = H12  +    -0.03529309925761 * CLASSGold  +    -0.03511326436948 * 
        CLASSPlatinum  +    -0.04218565350201 * CLASSSilver
          +     0.35148358932407 * GENDERF  +    -0.08652419868587 * GENDERM
          +     0.02346781054465 * NGROUPA  +     0.12267323433574 * NGROUPB
          +    -0.03471781128491 * NGROUPC  +     0.00210082144926 * NGROUPD
          +    -0.00034146614908 * NGROUPE  +     0.08563980882293 * NGROUPF
          +     -0.0686838247594 * OAC1  +     0.22055716716429 * OAC2
          +     0.09283924290283 * OAC3  +     -0.2748079236447 * OAC4
          +     0.31400997345598 * OAC5  +     0.07608793451702 * OAC6
          +     0.04451342626455 * OAC7  +     0.12869847241841 * 
        REGIONMidlands  +    -0.00018713967328 * REGIONNorth
          +     0.15427053190662 * REGIONScottish  +     0.02943639259732 * 
        REGIONSouth_East  +     -0.0518000442353 * TV_REGBorder
          +     0.05127517833417 * TV_REGC_Scotland  +    -0.03833221509967 * 
        TV_REGEast  +     0.25624241752564 * TV_REGLondon
          +     0.03655369017019 * TV_REGMidlands  +    -0.13980738759076 * 
        TV_REGN_East  +     -0.0678869184179 * TV_REGN_Scot
          +     0.16504527765522 * TV_REGN_West  +    -0.00699317830875 * 
        TV_REGS___S_East  +     0.19289339373466 * TV_REGS_West
          +    -0.20518620988914 * TV_REGUlster  +     0.04787291807078 * 
        TV_REGWales___West ;
   H13  = H13  +    -0.13459416112411 * CLASSGold  +      0.2672379043734 * 
        CLASSPlatinum  +     0.02551051739744 * CLASSSilver
          +    -0.88057309487554 * GENDERF  +    -0.17222091024185 * GENDERM
          +    -0.05091869517122 * NGROUPA  +     0.28935443435203 * NGROUPB
          +    -0.05245253643235 * NGROUPC  +     0.40819766340081 * NGROUPD
          +     0.21468447053896 * NGROUPE  +    -0.14837778138209 * NGROUPF
          +     0.00475654083077 * OAC1  +    -0.10769945449111 * OAC2
          +     0.07863348913908 * OAC3  +     0.07865507725603 * OAC4
          +    -0.22331920240078 * OAC5  +     0.16962616834866 * OAC6
          +    -0.00372493953241 * OAC7  +    -0.05852138846719 * 
        REGIONMidlands  +     0.02367567371422 * REGIONNorth
          +    -0.20977748609231 * REGIONScottish  +     0.22865784883836 * 
        REGIONSouth_East  +     0.09973182016726 * TV_REGBorder
          +    -0.14619931735359 * TV_REGC_Scotland  +    -0.20054269422802 * 
        TV_REGEast  +     -0.2504838702122 * TV_REGLondon
          +     0.02199280350628 * TV_REGMidlands  +    -0.17582941687117 * 
        TV_REGN_East  +     0.01642766502384 * TV_REGN_Scot
          +    -0.02131370079521 * TV_REGN_West  +     0.23311222186685 * 
        TV_REGS___S_East  +    -0.11143383309996 * TV_REGS_West
          +      0.2854326192412 * TV_REGUlster  +    -0.14373202668586 * 
        TV_REGWales___West ;
   H11  =    -0.86636129731451 + H11 ;
   H12  =    -1.23214183754407 + H12 ;
   H13  =    -0.68077729279675 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node ORGYN ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_ORGYN1  =     1.45828987957244 * H11  +     0.87588118565847 * H12
          +     -1.2196553999227 * H13 ;
   P_ORGYN1  =     -1.0315011186798 + P_ORGYN1 ;
   P_ORGYN0  = 0; 
   _MAX_ = MAX (P_ORGYN1 , P_ORGYN0 );
   _SUM_ = 0.; 
   P_ORGYN1  = EXP(P_ORGYN1  - _MAX_);
   _SUM_ = _SUM_ + P_ORGYN1 ;
   P_ORGYN0  = EXP(P_ORGYN0  - _MAX_);
   _SUM_ = _SUM_ + P_ORGYN0 ;
   P_ORGYN1  = P_ORGYN1  / _SUM_;
   P_ORGYN0  = P_ORGYN0  / _SUM_;
END;
ELSE DO;
   P_ORGYN1  = .;
   P_ORGYN0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_ORGYN1  =     0.25901422428051;
   P_ORGYN0  =     0.74098577571948;
END;
*** *************************;
*** Writing the I_ORGYN  AND U_ORGYN ;
*** *************************;
_MAXP_ = P_ORGYN1 ;
I_ORGYN  = "1           " ;
U_ORGYN  =                    1;
IF( _MAXP_ LT P_ORGYN0  ) THEN DO; 
   _MAXP_ = P_ORGYN0 ;
   I_ORGYN  = "0           " ;
   U_ORGYN  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
