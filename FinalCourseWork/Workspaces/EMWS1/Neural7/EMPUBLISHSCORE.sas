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

      label H14 = 'Hidden: H1=4' ;

      label H15 = 'Hidden: H1=5' ;

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
   H11  =    -0.03129358440539 * S_AFFL  +    -0.01154609449004 * S_AGE
          +    -0.31172098326224 * S_BILL  +      0.0681814349077 * S_LTIME
          +     0.31728586076614 * S_S_CONV  +    -0.33414170882389 * S_S_FVEG
          +     0.09745732314147 * S_S_MT  +    -0.03065510821948 * S_S_TOIL ;
   H12  =    -0.41819826105137 * S_AFFL  +    -0.26503331430277 * S_AGE
          +       0.452419312101 * S_BILL  +    -0.13376095632674 * S_LTIME
          +      0.0374212937213 * S_S_CONV  +     0.28134157357072 * S_S_FVEG
          +    -0.08228123178292 * S_S_MT  +    -0.14062717904565 * S_S_TOIL ;
   H13  =     0.58830905280504 * S_AFFL  +     0.09316292733554 * S_AGE
          +     0.06103969309007 * S_BILL  +    -0.28267316469458 * S_LTIME
          +    -0.07509038661467 * S_S_CONV  +     0.29206299838048 * S_S_FVEG
          +     0.21879519233312 * S_S_MT  +    -0.24514658288016 * S_S_TOIL ;
   H14  =    -0.13541550535135 * S_AFFL  +     1.52768651919797 * S_AGE
          +    -0.20572330980917 * S_BILL  +     0.03229015080754 * S_LTIME
          +    -0.10624544069812 * S_S_CONV  +    -0.11091915443804 * S_S_FVEG
          +     0.11986869627338 * S_S_MT  +     0.00655911189987 * S_S_TOIL ;
   H15  =     0.21784590156138 * S_AFFL  +    -0.05796748102377 * S_AGE
          +    -0.03880428323835 * S_BILL  +     0.14756423641643 * S_LTIME
          +     0.12050041153975 * S_S_CONV  +    -0.20194560226254 * S_S_FVEG
          +    -0.33055996531684 * S_S_MT  +    -0.09557152706765 * S_S_TOIL ;
   H11  = H11  +     0.19837722494433 * CLASSGold  +     0.11269051863474 *
        CLASSPlatinum  +     0.34754802757856 * CLASSSilver
          +    -0.23172983865774 * GENDERF  +    -0.42334851772942 * GENDERM
          +    -0.12701287030435 * NGROUPA  +    -0.10063541112995 * NGROUPB
          +    -0.20860114382804 * NGROUPC  +    -0.19038293387115 * NGROUPD
          +     0.08718371158321 * NGROUPE  +    -0.15182580402633 * NGROUPF
          +     0.09025629144451 * OAC1  +    -0.07711354616527 * OAC2
          +     0.03342884490237 * OAC3  +    -0.10514370054467 * OAC4
          +     -0.0245594621849 * OAC5  +    -0.11587246433282 * OAC6
          +    -0.05876226659549 * OAC7  +     0.19953324203527 *
        REGIONMidlands  +     0.23648911984893 * REGIONNorth
          +     0.16232137357998 * REGIONScottish  +     0.29528264707383 *
        REGIONSouth_East  +     -0.1057436808333 * TV_REGBorder
          +     0.11955603516613 * TV_REGC_Scotland  +    -0.16191708525685 *
        TV_REGEast  +    -0.12819457853471 * TV_REGLondon
          +     -0.1830068478094 * TV_REGMidlands  +    -0.14565708564346 *
        TV_REGN_East  +     0.07979740909481 * TV_REGN_Scot
          +    -0.06490292574833 * TV_REGN_West  +     0.33257173658303 *
        TV_REGS___S_East  +    -0.01159536247412 * TV_REGS_West
          +    -0.05279979277566 * TV_REGUlster  +    -0.24953475397404 *
        TV_REGWales___West ;
   H12  = H12  +    -0.25986816869786 * CLASSGold  +    -0.15168693842355 *
        CLASSPlatinum  +     0.18543226331691 * CLASSSilver
          +    -0.66905007211512 * GENDERF  +    -0.10237068280323 * GENDERM
          +     0.41686437137121 * NGROUPA  +     0.16245779236945 * NGROUPB
          +    -0.02521916183773 * NGROUPC  +    -0.03944201642702 * NGROUPD
          +     0.51645177768199 * NGROUPE  +    -0.11847156367001 * NGROUPF
          +    -0.17912993383928 * OAC1  +    -0.00962983518322 * OAC2
          +     -0.1287436248133 * OAC3  +     -0.3237947590492 * OAC4
          +    -0.16007238730585 * OAC5  +    -0.10942845933648 * OAC6
          +     0.21496660068899 * OAC7  +     0.06891576493751 *
        REGIONMidlands  +     0.25747450502138 * REGIONNorth
          +     0.14230580182117 * REGIONScottish  +     0.15526435837832 *
        REGIONSouth_East  +     0.22645374859929 * TV_REGBorder
          +      -0.626562200776 * TV_REGC_Scotland  +     0.26692312979866 *
        TV_REGEast  +     0.13672981064459 * TV_REGLondon
          +    -0.05042507776269 * TV_REGMidlands  +     0.21103887594756 *
        TV_REGN_East  +    -0.03738849276322 * TV_REGN_Scot
          +    -0.27293460864855 * TV_REGN_West  +    -0.05041306220548 *
        TV_REGS___S_East  +     0.04614490756249 * TV_REGS_West
          +     0.06138961877134 * TV_REGUlster  +    -0.10442406986409 *
        TV_REGWales___West ;
   H13  = H13  +    -0.29399707639811 * CLASSGold  +     0.38760878940695 *
        CLASSPlatinum  +    -0.03850019586061 * CLASSSilver
          +     0.32558734478489 * GENDERF  +    -0.33896358061797 * GENDERM
          +     0.33845086829028 * NGROUPA  +    -0.28502419758619 * NGROUPB
          +     0.05932725948976 * NGROUPC  +     0.01732766803318 * NGROUPD
          +    -0.25191797147762 * NGROUPE  +     0.23697956455598 * NGROUPF
          +    -0.28148200077048 * OAC1  +    -0.05602643346495 * OAC2
          +    -0.40879970887112 * OAC3  +      0.0184857709371 * OAC4
          +    -0.11554814270839 * OAC5  +    -0.10997568181509 * OAC6
          +    -0.54437437200156 * OAC7  +     0.28702948335786 *
        REGIONMidlands  +    -0.19409910802925 * REGIONNorth
          +    -0.27124897678984 * REGIONScottish  +     0.34214360131786 *
        REGIONSouth_East  +      -0.099104834154 * TV_REGBorder
          +     0.15953276975121 * TV_REGC_Scotland  +     0.45577320930756 *
        TV_REGEast  +    -0.08271704765345 * TV_REGLondon
          +     0.05795313091659 * TV_REGMidlands  +     0.17527460063437 *
        TV_REGN_East  +    -0.31427720397621 * TV_REGN_Scot
          +    -0.54438243670328 * TV_REGN_West  +     0.57213000913749 *
        TV_REGS___S_East  +    -0.00500598590406 * TV_REGS_West
          +    -0.03605240674558 * TV_REGUlster  +    -0.23368604557866 *
        TV_REGWales___West ;
   H14  = H14  +     0.07146976275012 * CLASSGold  +    -0.08716842743256 *
        CLASSPlatinum  +     -0.0299775713064 * CLASSSilver
          +    -0.17024940578503 * GENDERF  +    -0.07834820164159 * GENDERM
          +    -0.48053212729029 * NGROUPA  +    -0.33826047334999 * NGROUPB
          +     0.15331578950985 * NGROUPC  +    -0.04115951434432 * NGROUPD
          +     -0.4858599070991 * NGROUPE  +     0.04394537638639 * NGROUPF
          +     0.16559221038363 * OAC1  +    -0.01150856580081 * OAC2
          +    -0.33935213358654 * OAC3  +     0.52225344776462 * OAC4
          +     0.03914553236984 * OAC5  +     0.10698377125829 * OAC6
          +     -0.4081622789935 * OAC7  +      0.0624277756938 *
        REGIONMidlands  +    -0.23776085045988 * REGIONNorth
          +    -0.07221993370767 * REGIONScottish  +    -0.10074847392145 *
        REGIONSouth_East  +     0.34480663600761 * TV_REGBorder
          +     0.03853445541786 * TV_REGC_Scotland  +    -0.04190523216097 *
        TV_REGEast  +    -0.11968968675675 * TV_REGLondon
          +     0.05193465517677 * TV_REGMidlands  +    -0.11588402241754 *
        TV_REGN_East  +     -0.1046921367766 * TV_REGN_Scot
          +    -0.01381756994822 * TV_REGN_West  +     0.28126605969957 *
        TV_REGS___S_East  +    -0.22766827670274 * TV_REGS_West
          +     0.27456701208019 * TV_REGUlster  +     -0.1096171531751 *
        TV_REGWales___West ;
   H15  = H15  +     0.01900221770427 * CLASSGold  +    -0.13197101076858 *
        CLASSPlatinum  +    -0.05018240298476 * CLASSSilver
          +    -0.34996836832861 * GENDERF  +    -0.05804917654614 * GENDERM
          +    -0.14076353152943 * NGROUPA  +     0.17854846729304 * NGROUPB
          +     0.05537183375475 * NGROUPC  +     0.08108049290205 * NGROUPD
          +    -0.06473984137799 * NGROUPE  +    -0.11892403521671 * NGROUPF
          +    -0.00563829244427 * OAC1  +    -0.03435678426901 * OAC2
          +     0.07385359039454 * OAC3  +     0.04741713240676 * OAC4
          +     0.00738298467305 * OAC5  +     0.06051421071641 * OAC6
          +     0.17965605537919 * OAC7  +    -0.01151000385418 *
        REGIONMidlands  +     -0.1294418841862 * REGIONNorth
          +    -0.13527253604849 * REGIONScottish  +    -0.09777310586377 *
        REGIONSouth_East  +    -0.06970436794195 * TV_REGBorder
          +     0.13054135974273 * TV_REGC_Scotland  +    -0.26262272111882 *
        TV_REGEast  +     0.03461589523043 * TV_REGLondon
          +     0.06135244386027 * TV_REGMidlands  +    -0.16695566229487 *
        TV_REGN_East  +     0.06949771347812 * TV_REGN_Scot
          +    -0.01710663901436 * TV_REGN_West  +      0.0496351885326 *
        TV_REGS___S_East  +    -0.00293390218905 * TV_REGS_West
          +     0.02854423050334 * TV_REGUlster  +    -0.09805746149306 *
        TV_REGWales___West ;
   H11  =     -1.6196252174453 + H11 ;
   H12  =    -0.10142233084549 + H12 ;
   H13  =    -0.92444318422244 + H13 ;
   H14  =     1.88722723407288 + H14 ;
   H15  =     -0.8554783359082 + H15 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
END;
*** *************************;
*** Writing the Node ORGYN ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_ORGYN1  =     -0.7525636144193 * H11  +    -1.78962926628788 * H12
          +     1.08549148274542 * H13  +    -1.93616820100136 * H14
          +      0.1361735544588 * H15 ;
   P_ORGYN1  =      -0.707241225228 + P_ORGYN1 ;
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
H14
H15
;
