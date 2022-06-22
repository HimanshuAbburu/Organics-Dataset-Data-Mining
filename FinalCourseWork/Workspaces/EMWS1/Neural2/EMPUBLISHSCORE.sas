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
   S_AFFL  =    -2.53794507119216 +     0.29081819561053 * AFFL ;
   S_AGE  =    -4.07941720441219 +     0.07586524694472 * AGE ;
   S_BILL  =    -0.64166852872271 +     0.00014688955861 * BILL ;
   S_LTIME  =    -1.40610015609712 +     0.21370649020169 * LTIME ;
   S_S_CONV  =    -3.13547891308942 +     0.29099032158005 * S_CONV ;
   S_S_FVEG  =    -2.94383577577423 +     0.09923124447689 * S_FVEG ;
   S_S_MT  =    -3.00965656644771 +     0.12045013736575 * S_MT ;
   S_S_TOIL  =    -2.29761530583045 +     0.11857417291661 * S_TOIL ;
END;
ELSE DO;
   IF MISSING( AFFL ) THEN S_AFFL  = . ;
   ELSE S_AFFL  =    -2.53794507119216 +     0.29081819561053 * AFFL ;
   IF MISSING( AGE ) THEN S_AGE  = . ;
   ELSE S_AGE  =    -4.07941720441219 +     0.07586524694472 * AGE ;
   IF MISSING( BILL ) THEN S_BILL  = . ;
   ELSE S_BILL  =    -0.64166852872271 +     0.00014688955861 * BILL ;
   IF MISSING( LTIME ) THEN S_LTIME  = . ;
   ELSE S_LTIME  =    -1.40610015609712 +     0.21370649020169 * LTIME ;
   IF MISSING( S_CONV ) THEN S_S_CONV  = . ;
   ELSE S_S_CONV  =    -3.13547891308942 +     0.29099032158005 * S_CONV ;
   IF MISSING( S_FVEG ) THEN S_S_FVEG  = . ;
   ELSE S_S_FVEG  =    -2.94383577577423 +     0.09923124447689 * S_FVEG ;
   IF MISSING( S_MT ) THEN S_S_MT  = . ;
   ELSE S_S_MT  =    -3.00965656644771 +     0.12045013736575 * S_MT ;
   IF MISSING( S_TOIL ) THEN S_S_TOIL  = . ;
   ELSE S_S_TOIL  =    -2.29761530583045 +     0.11857417291661 * S_TOIL ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     -0.4576041542228 * S_AFFL  +      0.0277871694792 * S_AGE
          +     0.33652463098469 * S_BILL  +    -0.04881387723905 * S_LTIME
          +     0.08383174797074 * S_S_CONV  +     0.22170112511261 * S_S_FVEG
          +     0.13059673765902 * S_S_MT  +     0.00390525877446 * S_S_TOIL ;
   H12  =    -0.37658155266645 * S_AFFL  +     0.62438918540242 * S_AGE
          +    -0.13105222226727 * S_BILL  +     0.05343255093792 * S_LTIME
          +     0.01223887205901 * S_S_CONV  +    -0.08152533332319 * S_S_FVEG
          +     0.02303959670502 * S_S_MT  +    -0.03806759080138 * S_S_TOIL ;
   H13  =    -0.05490476016681 * S_AFFL  +    -0.36587276894945 * S_AGE
          +    -0.20305679474482 * S_BILL  +    -0.02733233725308 * S_LTIME
          +     0.01986643287206 * S_S_CONV  +    -0.12775261733785 * S_S_FVEG
          +    -0.43041456252079 * S_S_MT  +    -0.11976191073651 * S_S_TOIL ;
   H11  = H11  +     0.17521807682765 * CLASSGold  +     0.01935720523307 *
        CLASSPlatinum  +     0.08514987511114 * CLASSSilver
          +    -0.76832761303947 * GENDERF  +    -0.07553323671659 * GENDERM
          +    -0.16694620567459 * NGROUPA  +    -0.06093401397127 * NGROUPB
          +    -0.23206182313736 * NGROUPC  +    -0.22397128526666 * NGROUPD
          +    -0.11298108552694 * NGROUPE  +    -0.41842125212057 * NGROUPF
          +     0.13416093872484 * OAC1  +     -0.0609993040052 * OAC2
          +     0.01734748840677 * OAC3  +    -0.12066369567601 * OAC4
          +    -0.00517310650206 * OAC5  +    -0.04049129602308 * OAC6
          +     0.02337323126109 * OAC7  +     0.03278443697038 *
        REGIONMidlands  +     0.00492637548378 * REGIONNorth
          +     0.13742085442388 * REGIONScottish  +    -0.02692987284114 *
        REGIONSouth_East  +     0.03369127514779 * TV_REGBorder
          +    -0.32264984658537 * TV_REGC_Scotland  +    -0.00572625422559 *
        TV_REGEast  +     0.02401362507258 * TV_REGLondon
          +    -0.10112706372559 * TV_REGMidlands  +     0.22615838446123 *
        TV_REGN_East  +     0.15968880301233 * TV_REGN_Scot
          +    -0.08165009653851 * TV_REGN_West  +     0.02911986344804 *
        TV_REGS___S_East  +    -0.05912930047618 * TV_REGS_West
          +     0.02945270742254 * TV_REGUlster  +    -0.07511326172167 *
        TV_REGWales___West ;
   H12  = H12  +     0.05443164346674 * CLASSGold  +    -0.09232923780979 *
        CLASSPlatinum  +     0.01372952391874 * CLASSSilver
          +    -0.49111171552671 * GENDERF  +     0.03880535656436 * GENDERM
          +    -0.10551746949986 * NGROUPA  +     0.19124947029392 * NGROUPB
          +     0.14483388339745 * NGROUPC  +     0.06622664924592 * NGROUPD
          +     0.15856346076797 * NGROUPE  +     0.08534722668581 * NGROUPF
          +       0.075462247261 * OAC1  +    -0.08331461331966 * OAC2
          +    -0.14563617618158 * OAC3  +     0.17058636110497 * OAC4
          +    -0.02206450572118 * OAC5  +     0.03008750825037 * OAC6
          +     0.05556773797438 * OAC7  +    -0.13181396669497 *
        REGIONMidlands  +     0.12755156845385 * REGIONNorth
          +      0.0520431829525 * REGIONScottish  +    -0.06079597920067 *
        REGIONSouth_East  +    -0.03083594770014 * TV_REGBorder
          +    -0.08698630941198 * TV_REGC_Scotland  +     0.01924321783283 *
        TV_REGEast  +     0.02289212261268 * TV_REGLondon
          +     0.20174578327884 * TV_REGMidlands  +    -0.15725175526576 *
        TV_REGN_East  +     0.09863793006563 * TV_REGN_Scot
          +    -0.03993778425908 * TV_REGN_West  +    -0.00076357605373 *
        TV_REGS___S_East  +     0.00954348957363 * TV_REGS_West
          +    -0.08859349064857 * TV_REGUlster  +     0.10075490243944 *
        TV_REGWales___West ;
   H13  = H13  +    -0.38476133586469 * CLASSGold  +     0.08262807003649 *
        CLASSPlatinum  +     0.03672410719305 * CLASSSilver
          +    -0.03729704330342 * GENDERF  +    -0.16846849707221 * GENDERM
          +     0.29513444218446 * NGROUPA  +      -0.171343268949 * NGROUPB
          +     0.01519532312242 * NGROUPC  +     0.06432317212386 * NGROUPD
          +     0.06406978375566 * NGROUPE  +    -0.21958910676673 * NGROUPF
          +     0.00877241631237 * OAC1  +     0.26527190447487 * OAC2
          +     0.01913809421084 * OAC3  +    -0.25230536980156 * OAC4
          +    -0.09596458069762 * OAC5  +     0.00467472487228 * OAC6
          +     0.29229820218634 * OAC7  +     0.10085903304913 *
        REGIONMidlands  +     0.22737194224899 * REGIONNorth
          +    -0.03157812226683 * REGIONScottish  +     0.16318509802829 *
        REGIONSouth_East  +     0.03652832035621 * TV_REGBorder
          +    -0.09632567193671 * TV_REGC_Scotland  +     0.26046455727761 *
        TV_REGEast  +     0.15962559633939 * TV_REGLondon
          +    -0.45039791762106 * TV_REGMidlands  +     -0.4172429307222 *
        TV_REGN_East  +     0.13347069097052 * TV_REGN_Scot
          +     0.09018444046385 * TV_REGN_West  +    -0.22384852304581 *
        TV_REGS___S_East  +     0.03233194805211 * TV_REGS_West
          +      0.1272714078358 * TV_REGUlster  +    -0.02552738275522 *
        TV_REGWales___West ;
   H11  =    -0.43490173476414 + H11 ;
   H12  =      1.3360491524382 + H12 ;
   H13  =     0.96511771249917 + H13 ;
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
   P_ORGYN1  =    -2.02446240433424 * H11  +     -2.7602185579444 * H12
          +    -0.74717308713028 * H13 ;
   P_ORGYN1  =     -0.4037582026911 + P_ORGYN1 ;
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
drop
S_AFFL
S_AGE
S_BILL
S_LTIME
S_S_CONV
S_S_FVEG
S_S_MT
S_S_TOIL
H11
H12
H13
;
