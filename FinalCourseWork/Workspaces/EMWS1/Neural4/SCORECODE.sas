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
      label S_AFFL = 'Standard: AFFL' ;

      label S_AGE = 'Standard: AGE' ;

      label S_BILL = 'Standard: BILL' ;

      label S_LTIME = 'Standard: LTIME' ;

      label S_S_CONV = 'Standard: S_CONV' ;

      label S_S_FVEG = 'Standard: S_FVEG' ;

      label S_S_MT = 'Standard: S_MT' ;

      label S_S_TOIL = 'Standard: S_TOIL' ;

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

      label TV_REGC_Scotland = 'Dummy: TV_REG=C Scotland' ;

      label TV_REGEast = 'Dummy: TV_REG=East' ;

      label TV_REGLondon = 'Dummy: TV_REG=London' ;

      label TV_REGMidlands = 'Dummy: TV_REG=Midlands' ;

      label TV_REGN_East = 'Dummy: TV_REG=N East' ;

      label TV_REGN_Scot = 'Dummy: TV_REG=N Scot' ;

      label TV_REGN_West = 'Dummy: TV_REG=N West' ;

      label TV_REGS___S_East = 'Dummy: TV_REG=S & S East' ;

      label TV_REGS_West = 'Dummy: TV_REG=S West' ;

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
   else if _dm8 = 'TIN'  then do;
      CLASSGold = -1;
      CLASSPlatinum = -1;
      CLASSSilver = -1;
   end;
   else if _dm8 = 'GOLD'  then do;
      CLASSGold = 1;
      CLASSPlatinum = 0;
      CLASSSilver = 0;
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
drop NGROUPA NGROUPB NGROUPC NGROUPD NGROUPE ;
*** encoding is sparse, initialize to zero;
NGROUPA = 0;
NGROUPB = 0;
NGROUPC = 0;
NGROUPD = 0;
NGROUPE = 0;
if missing( NGROUP ) then do;
   NGROUPA = .;
   NGROUPB = .;
   NGROUPC = .;
   NGROUPD = .;
   NGROUPE = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( NGROUP , $1. );
   %DMNORMIP( _dm1 )
   _dm_find = 0; drop _dm_find;
   if _dm1 <= 'C'  then do;
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
      end;
   end;
   else do;
      if _dm1 <= 'E'  then do;
         if _dm1 = 'D'  then do;
            NGROUPD = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'E'  then do;
               NGROUPE = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'F'  then do;
            NGROUPA = -1;
            NGROUPB = -1;
            NGROUPC = -1;
            NGROUPD = -1;
            NGROUPE = -1;
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
drop TV_REGC_Scotland TV_REGEast TV_REGLondon TV_REGMidlands TV_REGN_East 
        TV_REGN_Scot TV_REGN_West TV_REGS___S_East TV_REGS_West 
        TV_REGWales___West ;
*** encoding is sparse, initialize to zero;
TV_REGC_Scotland = 0;
TV_REGEast = 0;
TV_REGLondon = 0;
TV_REGMidlands = 0;
TV_REGN_East = 0;
TV_REGN_Scot = 0;
TV_REGN_West = 0;
TV_REGS___S_East = 0;
TV_REGS_West = 0;
TV_REGWales___West = 0;
if missing( TV_REG ) then do;
   TV_REGC_Scotland = .;
   TV_REGEast = .;
   TV_REGLondon = .;
   TV_REGMidlands = .;
   TV_REGN_East = .;
   TV_REGN_Scot = .;
   TV_REGN_West = .;
   TV_REGS___S_East = .;
   TV_REGS_West = .;
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
      TV_REGC_Scotland = -1;
      TV_REGEast = -1;
      TV_REGLondon = -1;
      TV_REGMidlands = -1;
      TV_REGN_East = -1;
      TV_REGN_Scot = -1;
      TV_REGN_West = -1;
      TV_REGS___S_East = -1;
      TV_REGS_West = -1;
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
   else if _dm12 = 'N SCOT'  then do;
      TV_REGN_Scot = 1;
   end;
   else do;
      TV_REGC_Scotland = .;
      TV_REGEast = .;
      TV_REGLondon = .;
      TV_REGMidlands = .;
      TV_REGN_East = .;
      TV_REGN_Scot = .;
      TV_REGN_West = .;
      TV_REGS___S_East = .;
      TV_REGS_West = .;
      TV_REGWales___West = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   AFFL , 
   AGE , 
   BILL , 
   LTIME , 
   S_CONV , 
   S_FVEG , 
   S_MT , 
   S_TOIL   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_AFFL  =    -2.71639978656344 +      0.3133331634252 * AFFL ;
   S_AGE  =     -4.0543012465827 +     0.07604915772249 * AGE ;
   S_BILL  =    -0.76430267827396 +     0.00020434130878 * BILL ;
   S_LTIME  =    -1.75291639473636 +     0.28678929018285 * LTIME ;
   S_S_CONV  =    -3.20110026053038 +     0.30167190823141 * S_CONV ;
   S_S_FVEG  =    -2.97194534686281 +     0.09974075338819 * S_FVEG ;
   S_S_MT  =    -3.07081954536403 +     0.12172135577786 * S_MT ;
   S_S_TOIL  =    -2.37132481965132 +     0.11974200730531 * S_TOIL ;
END;
ELSE DO;
   IF MISSING( AFFL ) THEN S_AFFL  = . ;
   ELSE S_AFFL  =    -2.71639978656344 +      0.3133331634252 * AFFL ;
   IF MISSING( AGE ) THEN S_AGE  = . ;
   ELSE S_AGE  =     -4.0543012465827 +     0.07604915772249 * AGE ;
   IF MISSING( BILL ) THEN S_BILL  = . ;
   ELSE S_BILL  =    -0.76430267827396 +     0.00020434130878 * BILL ;
   IF MISSING( LTIME ) THEN S_LTIME  = . ;
   ELSE S_LTIME  =    -1.75291639473636 +     0.28678929018285 * LTIME ;
   IF MISSING( S_CONV ) THEN S_S_CONV  = . ;
   ELSE S_S_CONV  =    -3.20110026053038 +     0.30167190823141 * S_CONV ;
   IF MISSING( S_FVEG ) THEN S_S_FVEG  = . ;
   ELSE S_S_FVEG  =    -2.97194534686281 +     0.09974075338819 * S_FVEG ;
   IF MISSING( S_MT ) THEN S_S_MT  = . ;
   ELSE S_S_MT  =    -3.07081954536403 +     0.12172135577786 * S_MT ;
   IF MISSING( S_TOIL ) THEN S_S_TOIL  = . ;
   ELSE S_S_TOIL  =    -2.37132481965132 +     0.11974200730531 * S_TOIL ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.48492378994884 * S_AFFL  +     -0.1253339043606 * S_AGE
          +     0.41658004852111 * S_BILL  +    -0.08797255218304 * S_LTIME
          +    -0.03072794219529 * S_S_CONV  +     0.29846285095826 * S_S_FVEG
          +    -0.10711939887901 * S_S_MT  +    -0.05794704471696 * S_S_TOIL ;
   H12  =     0.31470633542638 * S_AFFL  +     0.06451269573987 * S_AGE
          +     0.17672851317765 * S_BILL  +    -0.33420988695771 * S_LTIME
          +    -0.26540473312981 * S_S_CONV  +     0.16910833778779 * S_S_FVEG
          +     0.12894474881349 * S_S_MT  +    -0.23484719198022 * S_S_TOIL ;
   H13  =    -0.24894403692461 * S_AFFL  +      0.8177855053386 * S_AGE
          +     -0.0333755922922 * S_BILL  +    -0.04571277947287 * S_LTIME
          +    -0.04037839498325 * S_S_CONV  +    -0.11469606131946 * S_S_FVEG
          +     0.04579193753114 * S_S_MT  +    -0.08217708137879 * S_S_TOIL ;
   H11  = H11  +    -0.10289228067883 * CLASSGold  +     0.04252276055699 * 
        CLASSPlatinum  +     0.13272691485334 * CLASSSilver
          +    -0.70199153754585 * GENDERF  +    -0.03146539522065 * GENDERM
          +    -0.03571675453541 * NGROUPA  +     0.07408284991361 * NGROUPB
          +    -0.02829852860275 * NGROUPC  +     -0.0261825158343 * NGROUPD
          +      0.1224369931331 * NGROUPE  +     0.08760373186522 * OAC1
          +    -0.07777685308152 * OAC2  +    -0.00438086782198 * OAC3
          +    -0.06716576297479 * OAC4  +    -0.19273363874679 * OAC5
          +     0.07832273546614 * OAC6  +     0.26751844855188 * OAC7
          +     0.10401839051462 * REGIONMidlands  +      0.1194653782666 * 
        REGIONNorth  +    -0.01832853559959 * REGIONScottish
          +      0.1068897839112 * REGIONSouth_East  +     -0.2846438725875 * 
        TV_REGC_Scotland  +     0.17442502406152 * TV_REGEast
          +     0.11680801215329 * TV_REGLondon  +    -0.10150597873482 * 
        TV_REGMidlands  +    -0.02927705641904 * TV_REGN_East
          +    -0.07976821128181 * TV_REGN_Scot  +     0.02453342371778 * 
        TV_REGN_West  +    -0.02964383499967 * TV_REGS___S_East
          +     0.07510526075605 * TV_REGS_West  +    -0.15108385245359 * 
        TV_REGWales___West ;
   H12  = H12  +    -0.02816051727016 * CLASSGold  +    -0.12783069748706 * 
        CLASSPlatinum  +     0.07553974292845 * CLASSSilver
          +     0.34243544563009 * GENDERF  +     0.00949733644285 * GENDERM
          +     -0.1112924391343 * NGROUPA  +     0.15638987423001 * NGROUPB
          +      0.0622179734047 * NGROUPC  +    -0.18558718874402 * NGROUPD
          +    -0.15176470091018 * NGROUPE  +     0.09871834723236 * OAC1
          +    -0.05514336039763 * OAC2  +    -0.08837083151859 * OAC3
          +     0.17079308605523 * OAC4  +    -0.11868730096957 * OAC5
          +    -0.09508912329373 * OAC6  +     0.17695262336737 * OAC7
          +     0.11532079814235 * REGIONMidlands  +    -0.08393554129268 * 
        REGIONNorth  +    -0.14331254280726 * REGIONScottish
          +     0.08209682381845 * REGIONSouth_East  +     0.09058832718518 * 
        TV_REGC_Scotland  +     0.23631784447521 * TV_REGEast
          +    -0.16409485247916 * TV_REGLondon  +    -0.08827775579289 * 
        TV_REGMidlands  +     0.03191590353835 * TV_REGN_East
          +     0.03800780071102 * TV_REGN_Scot  +     0.12404420568759 * 
        TV_REGN_West  +    -0.18822830166672 * TV_REGS___S_East
          +    -0.02998596290785 * TV_REGS_West  +      0.0938199375206 * 
        TV_REGWales___West ;
   H13  = H13  +    -0.04249167462624 * CLASSGold  +    -0.57427947474777 * 
        CLASSPlatinum  +     0.25306913905829 * CLASSSilver
          +    -0.37421342400732 * GENDERF  +     -0.0530694256835 * GENDERM
          +    -0.16255619075774 * NGROUPA  +     0.13814346053141 * NGROUPB
          +      0.0736747326783 * NGROUPC  +    -0.05798409635954 * NGROUPD
          +    -0.02953837011318 * NGROUPE  +     0.11877339180632 * OAC1
          +    -0.00040474451595 * OAC2  +     -0.1753216629642 * OAC3
          +     0.20166199466392 * OAC4  +    -0.02570782113795 * OAC5
          +    -0.01463029731825 * OAC6  +    -0.10155798043434 * OAC7
          +     0.06415529634946 * REGIONMidlands  +     0.01881957837638 * 
        REGIONNorth  +     0.14200006339606 * REGIONScottish
          +    -0.03184496378445 * REGIONSouth_East  +    -0.27075285699705 * 
        TV_REGC_Scotland  +     0.05416802422583 * TV_REGEast
          +    -0.01001726326342 * TV_REGLondon  +     0.05478879064021 * 
        TV_REGMidlands  +     0.06109115142884 * TV_REGN_East
          +    -0.06406209933293 * TV_REGN_Scot  +     0.05600457803789 * 
        TV_REGN_West  +    -0.06346329966536 * TV_REGS___S_East
          +     0.17601517929592 * TV_REGS_West  +     0.01661658739726 * 
        TV_REGWales___West ;
   H11  =    -0.47533052152947 + H11 ;
   H12  =      0.5003220002607 + H12 ;
   H13  =     1.36313161062014 + H13 ;
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
   P_ORGYN1  =     -1.8384300225475 * H11  +      0.9006427223969 * H12
          +    -2.67014563515253 * H13 ;
   P_ORGYN1  =    -0.86774348366289 + P_ORGYN1 ;
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
   P_ORGYN1  =     0.25909909909909;
   P_ORGYN0  =      0.7409009009009;
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
