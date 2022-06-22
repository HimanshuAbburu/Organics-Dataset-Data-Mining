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
      label S_BILL = 'Standard: BILL' ;

      label S_IMP_AFFL = 'Standard: IMP_AFFL' ;

      label S_IMP_AGE = 'Standard: IMP_AGE' ;

      label S_IMP_LTIME = 'Standard: IMP_LTIME' ;

      label S_S_CONV = 'Standard: S_CONV' ;

      label S_S_FVEG = 'Standard: S_FVEG' ;

      label S_S_MT = 'Standard: S_MT' ;

      label S_S_TOIL = 'Standard: S_TOIL' ;

      label CLASSGold = 'Dummy: CLASS=Gold' ;

      label CLASSPlatinum = 'Dummy: CLASS=Platinum' ;

      label CLASSSilver = 'Dummy: CLASS=Silver' ;

      label IMP_GENDERF = 'Dummy: IMP_GENDER=F' ;

      label IMP_GENDERM = 'Dummy: IMP_GENDER=M' ;

      label IMP_NGROUPA = 'Dummy: IMP_NGROUP=A' ;

      label IMP_NGROUPB = 'Dummy: IMP_NGROUP=B' ;

      label IMP_NGROUPC = 'Dummy: IMP_NGROUP=C' ;

      label IMP_NGROUPD = 'Dummy: IMP_NGROUP=D' ;

      label IMP_NGROUPE = 'Dummy: IMP_NGROUP=E' ;

      label IMP_NGROUPF = 'Dummy: IMP_NGROUP=F' ;

      label IMP_OAC1 = 'Dummy: IMP_OAC=1' ;

      label IMP_OAC2 = 'Dummy: IMP_OAC=2' ;

      label IMP_OAC3 = 'Dummy: IMP_OAC=3' ;

      label IMP_OAC4 = 'Dummy: IMP_OAC=4' ;

      label IMP_OAC5 = 'Dummy: IMP_OAC=5' ;

      label IMP_OAC6 = 'Dummy: IMP_OAC=6' ;

      label IMP_OAC7 = 'Dummy: IMP_OAC=7' ;

      label IMP_REGIONMidlands = 'Dummy: IMP_REGION=Midlands' ;

      label IMP_REGIONNorth = 'Dummy: IMP_REGION=North' ;

      label IMP_REGIONScottish = 'Dummy: IMP_REGION=Scottish' ;

      label IMP_REGIONSouth_East = 'Dummy: IMP_REGION=South East' ;

      label IMP_TV_REGBorder = 'Dummy: IMP_TV_REG=Border' ;

      label IMP_TV_REGC_Scotland = 'Dummy: IMP_TV_REG=C Scotland' ;

      label IMP_TV_REGEast = 'Dummy: IMP_TV_REG=East' ;

      label IMP_TV_REGLondon = 'Dummy: IMP_TV_REG=London' ;

      label IMP_TV_REGMidlands = 'Dummy: IMP_TV_REG=Midlands' ;

      label IMP_TV_REGN_East = 'Dummy: IMP_TV_REG=N East' ;

      label IMP_TV_REGN_Scot = 'Dummy: IMP_TV_REG=N Scot' ;

      label IMP_TV_REGN_West = 'Dummy: IMP_TV_REG=N West' ;

      label IMP_TV_REGS___S_East = 'Dummy: IMP_TV_REG=S & S East' ;

      label IMP_TV_REGS_West = 'Dummy: IMP_TV_REG=S West' ;

      label IMP_TV_REGUlster = 'Dummy: IMP_TV_REG=Ulster' ;

      label IMP_TV_REGWales___West = 'Dummy: IMP_TV_REG=Wales & West' ;

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

*** Generate dummy variables for IMP_GENDER ;
drop IMP_GENDERF IMP_GENDERM ;
if missing( IMP_GENDER ) then do;
   IMP_GENDERF = .;
   IMP_GENDERM = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( IMP_GENDER , $1. );
   %DMNORMIP( _dm1 )
   if _dm1 = 'F'  then do;
      IMP_GENDERF = 1;
      IMP_GENDERM = 0;
   end;
   else if _dm1 = 'M'  then do;
      IMP_GENDERF = 0;
      IMP_GENDERM = 1;
   end;
   else if _dm1 = 'U'  then do;
      IMP_GENDERF = -1;
      IMP_GENDERM = -1;
   end;
   else do;
      IMP_GENDERF = .;
      IMP_GENDERM = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_NGROUP ;
drop IMP_NGROUPA IMP_NGROUPB IMP_NGROUPC IMP_NGROUPD IMP_NGROUPE IMP_NGROUPF ;
*** encoding is sparse, initialize to zero;
IMP_NGROUPA = 0;
IMP_NGROUPB = 0;
IMP_NGROUPC = 0;
IMP_NGROUPD = 0;
IMP_NGROUPE = 0;
IMP_NGROUPF = 0;
if missing( IMP_NGROUP ) then do;
   IMP_NGROUPA = .;
   IMP_NGROUPB = .;
   IMP_NGROUPC = .;
   IMP_NGROUPD = .;
   IMP_NGROUPE = .;
   IMP_NGROUPF = .;
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
            IMP_NGROUPA = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'B'  then do;
               IMP_NGROUPB = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'C'  then do;
            IMP_NGROUPC = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'D'  then do;
               IMP_NGROUPD = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm1 <= 'F'  then do;
         if _dm1 = 'E'  then do;
            IMP_NGROUPE = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'F'  then do;
               IMP_NGROUPF = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'U'  then do;
            IMP_NGROUPA = -1;
            IMP_NGROUPB = -1;
            IMP_NGROUPC = -1;
            IMP_NGROUPD = -1;
            IMP_NGROUPE = -1;
            IMP_NGROUPF = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      IMP_NGROUPA = .;
      IMP_NGROUPB = .;
      IMP_NGROUPC = .;
      IMP_NGROUPD = .;
      IMP_NGROUPE = .;
      IMP_NGROUPF = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_OAC ;
drop IMP_OAC1 IMP_OAC2 IMP_OAC3 IMP_OAC4 IMP_OAC5 IMP_OAC6 IMP_OAC7 ;
*** encoding is sparse, initialize to zero;
IMP_OAC1 = 0;
IMP_OAC2 = 0;
IMP_OAC3 = 0;
IMP_OAC4 = 0;
IMP_OAC5 = 0;
IMP_OAC6 = 0;
IMP_OAC7 = 0;
if missing( IMP_OAC ) then do;
   IMP_OAC1 = .;
   IMP_OAC2 = .;
   IMP_OAC3 = .;
   IMP_OAC4 = .;
   IMP_OAC5 = .;
   IMP_OAC6 = .;
   IMP_OAC7 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( IMP_OAC , BEST12. );
   %DMNORMIP( _dm12 )
   _dm_find = 0; drop _dm_find;
   if _dm12 <= '4'  then do;
      if _dm12 <= '2'  then do;
         if _dm12 = '1'  then do;
            IMP_OAC1 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '2'  then do;
               IMP_OAC2 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm12 = '3'  then do;
            IMP_OAC3 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '4'  then do;
               IMP_OAC4 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm12 <= '6'  then do;
         if _dm12 = '5'  then do;
            IMP_OAC5 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '6'  then do;
               IMP_OAC6 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm12 = '7'  then do;
            IMP_OAC7 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm12 = '8'  then do;
               IMP_OAC1 = -1;
               IMP_OAC2 = -1;
               IMP_OAC3 = -1;
               IMP_OAC4 = -1;
               IMP_OAC5 = -1;
               IMP_OAC6 = -1;
               IMP_OAC7 = -1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   if not _dm_find then do;
      IMP_OAC1 = .;
      IMP_OAC2 = .;
      IMP_OAC3 = .;
      IMP_OAC4 = .;
      IMP_OAC5 = .;
      IMP_OAC6 = .;
      IMP_OAC7 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_REGION ;
drop IMP_REGIONMidlands IMP_REGIONNorth IMP_REGIONScottish 
        IMP_REGIONSouth_East ;
*** encoding is sparse, initialize to zero;
IMP_REGIONMidlands = 0;
IMP_REGIONNorth = 0;
IMP_REGIONScottish = 0;
IMP_REGIONSouth_East = 0;
if missing( IMP_REGION ) then do;
   IMP_REGIONMidlands = .;
   IMP_REGIONNorth = .;
   IMP_REGIONScottish = .;
   IMP_REGIONSouth_East = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( IMP_REGION , $10. );
   %DMNORMIP( _dm10 )
   _dm_find = 0; drop _dm_find;
   if _dm10 <= 'SCOTTISH'  then do;
      if _dm10 <= 'NORTH'  then do;
         if _dm10 = 'MIDLANDS'  then do;
            IMP_REGIONMidlands = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm10 = 'NORTH'  then do;
               IMP_REGIONNorth = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm10 = 'SCOTTISH'  then do;
            IMP_REGIONScottish = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm10 = 'SOUTH EAST'  then do;
         IMP_REGIONSouth_East = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm10 = 'SOUTH WEST'  then do;
            IMP_REGIONMidlands = -1;
            IMP_REGIONNorth = -1;
            IMP_REGIONScottish = -1;
            IMP_REGIONSouth_East = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      IMP_REGIONMidlands = .;
      IMP_REGIONNorth = .;
      IMP_REGIONScottish = .;
      IMP_REGIONSouth_East = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_TV_REG ;
drop IMP_TV_REGBorder IMP_TV_REGC_Scotland IMP_TV_REGEast IMP_TV_REGLondon 
        IMP_TV_REGMidlands IMP_TV_REGN_East IMP_TV_REGN_Scot IMP_TV_REGN_West 
        IMP_TV_REGS___S_East IMP_TV_REGS_West IMP_TV_REGUlster 
        IMP_TV_REGWales___West ;
*** encoding is sparse, initialize to zero;
IMP_TV_REGBorder = 0;
IMP_TV_REGC_Scotland = 0;
IMP_TV_REGEast = 0;
IMP_TV_REGLondon = 0;
IMP_TV_REGMidlands = 0;
IMP_TV_REGN_East = 0;
IMP_TV_REGN_Scot = 0;
IMP_TV_REGN_West = 0;
IMP_TV_REGS___S_East = 0;
IMP_TV_REGS_West = 0;
IMP_TV_REGUlster = 0;
IMP_TV_REGWales___West = 0;
if missing( IMP_TV_REG ) then do;
   IMP_TV_REGBorder = .;
   IMP_TV_REGC_Scotland = .;
   IMP_TV_REGEast = .;
   IMP_TV_REGLondon = .;
   IMP_TV_REGMidlands = .;
   IMP_TV_REGN_East = .;
   IMP_TV_REGN_Scot = .;
   IMP_TV_REGN_West = .;
   IMP_TV_REGS___S_East = .;
   IMP_TV_REGS_West = .;
   IMP_TV_REGUlster = .;
   IMP_TV_REGWales___West = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( IMP_TV_REG , $12. );
   %DMNORMIP( _dm12 )
   if _dm12 = 'LONDON'  then do;
      IMP_TV_REGLondon = 1;
   end;
   else if _dm12 = 'MIDLANDS'  then do;
      IMP_TV_REGMidlands = 1;
   end;
   else if _dm12 = 'S & S EAST'  then do;
      IMP_TV_REGS___S_East = 1;
   end;
   else if _dm12 = 'N WEST'  then do;
      IMP_TV_REGN_West = 1;
   end;
   else if _dm12 = 'WALES & WEST'  then do;
      IMP_TV_REGWales___West = 1;
   end;
   else if _dm12 = 'EAST'  then do;
      IMP_TV_REGEast = 1;
   end;
   else if _dm12 = 'YORKSHIRE'  then do;
      IMP_TV_REGBorder = -1;
      IMP_TV_REGC_Scotland = -1;
      IMP_TV_REGEast = -1;
      IMP_TV_REGLondon = -1;
      IMP_TV_REGMidlands = -1;
      IMP_TV_REGN_East = -1;
      IMP_TV_REGN_Scot = -1;
      IMP_TV_REGN_West = -1;
      IMP_TV_REGS___S_East = -1;
      IMP_TV_REGS_West = -1;
      IMP_TV_REGUlster = -1;
      IMP_TV_REGWales___West = -1;
   end;
   else if _dm12 = 'C SCOTLAND'  then do;
      IMP_TV_REGC_Scotland = 1;
   end;
   else if _dm12 = 'N EAST'  then do;
      IMP_TV_REGN_East = 1;
   end;
   else if _dm12 = 'S WEST'  then do;
      IMP_TV_REGS_West = 1;
   end;
   else if _dm12 = 'ULSTER'  then do;
      IMP_TV_REGUlster = 1;
   end;
   else if _dm12 = 'N SCOT'  then do;
      IMP_TV_REGN_Scot = 1;
   end;
   else if _dm12 = 'BORDER'  then do;
      IMP_TV_REGBorder = 1;
   end;
   else do;
      IMP_TV_REGBorder = .;
      IMP_TV_REGC_Scotland = .;
      IMP_TV_REGEast = .;
      IMP_TV_REGLondon = .;
      IMP_TV_REGMidlands = .;
      IMP_TV_REGN_East = .;
      IMP_TV_REGN_Scot = .;
      IMP_TV_REGN_West = .;
      IMP_TV_REGS___S_East = .;
      IMP_TV_REGS_West = .;
      IMP_TV_REGUlster = .;
      IMP_TV_REGWales___West = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   BILL , 
   IMP_AFFL , 
   IMP_AGE , 
   IMP_LTIME , 
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
   S_BILL  =    -0.64166852872271 +     0.00014688955861 * BILL ;
   S_IMP_AFFL  =    -2.60732769563511 +     0.29876861576582 * IMP_AFFL ;
   S_IMP_AGE  =    -4.20204555633209 +     0.07814577618081 * IMP_AGE ;
   S_IMP_LTIME  =    -1.41354270418761 +     0.21483764776801 * IMP_LTIME ;
   S_S_CONV  =    -3.13547891308942 +     0.29099032158005 * S_CONV ;
   S_S_FVEG  =    -2.94383577577423 +     0.09923124447689 * S_FVEG ;
   S_S_MT  =    -3.00965656644771 +     0.12045013736575 * S_MT ;
   S_S_TOIL  =    -2.29761530583045 +     0.11857417291661 * S_TOIL ;
END;
ELSE DO;
   IF MISSING( BILL ) THEN S_BILL  = . ;
   ELSE S_BILL  =    -0.64166852872271 +     0.00014688955861 * BILL ;
   IF MISSING( IMP_AFFL ) THEN S_IMP_AFFL  = . ;
   ELSE S_IMP_AFFL  =    -2.60732769563511 +     0.29876861576582 * IMP_AFFL ;
   IF MISSING( IMP_AGE ) THEN S_IMP_AGE  = . ;
   ELSE S_IMP_AGE  =    -4.20204555633209 +     0.07814577618081 * IMP_AGE ;
   IF MISSING( IMP_LTIME ) THEN S_IMP_LTIME  = . ;
   ELSE S_IMP_LTIME  =    -1.41354270418761 +     0.21483764776801 * IMP_LTIME
         ;
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
   H11  =    -0.04210458975962 * S_BILL  +     0.57726878734129 * S_IMP_AFFL
          +    -0.11757570740974 * S_IMP_AGE  +     0.10995542668141 * 
        S_IMP_LTIME  +    -0.01302719374812 * S_S_CONV
          +    -0.12186667215335 * S_S_FVEG  +     0.06886708407774 * S_S_MT
          +     0.08602562060514 * S_S_TOIL ;
   H12  =     0.03196983572542 * S_BILL  +     0.66767809495721 * S_IMP_AFFL
          +    -0.28697339545029 * S_IMP_AGE  +    -0.13152771603445 * 
        S_IMP_LTIME  +    -0.15888030527746 * S_S_CONV
          +    -0.13864973839208 * S_S_FVEG  +     0.15869801706082 * S_S_MT
          +     0.01087054037895 * S_S_TOIL ;
   H13  =    -0.05164022153436 * S_BILL  +     0.27571555245094 * S_IMP_AFFL
          +    -0.64079064263349 * S_IMP_AGE  +     0.05718488744621 * 
        S_IMP_LTIME  +     0.04624359513002 * S_S_CONV
          +     0.14089286207351 * S_S_FVEG  +    -0.06066166550156 * S_S_MT
          +      0.1135885498038 * S_S_TOIL ;
   H11  = H11  +    -0.08326089247017 * CLASSGold  +    -0.18619262932032 * 
        CLASSPlatinum  +     -0.0918657412216 * CLASSSilver
          +     0.63859712593467 * IMP_GENDERF  +     0.05154347375118 * 
        IMP_GENDERM  +    -0.08910298987209 * IMP_NGROUPA
          +      0.0605922036599 * IMP_NGROUPB  +     0.08329063445012 * 
        IMP_NGROUPC  +     0.10502344350687 * IMP_NGROUPD
          +    -0.23996116609238 * IMP_NGROUPE  +     0.33524211124899 * 
        IMP_NGROUPF  +    -0.14641580132888 * IMP_OAC1
          +     0.11007914748386 * IMP_OAC2  +    -0.03101201250395 * IMP_OAC3
          +     0.28943225761136 * IMP_OAC4  +     0.04179872936734 * IMP_OAC5
          +     -0.0627138726567 * IMP_OAC6  +    -0.14104266853741 * IMP_OAC7
          +    -0.20579735682295 * IMP_REGIONMidlands
          +    -0.04708577559717 * IMP_REGIONNorth  +    -0.06622720589454 * 
        IMP_REGIONScottish  +    -0.00947868027638 * IMP_REGIONSouth_East
          +     0.16495514886384 * IMP_TV_REGBorder  +      0.2008950865658 * 
        IMP_TV_REGC_Scotland  +    -0.01160346605196 * IMP_TV_REGEast
          +     0.18976974331501 * IMP_TV_REGLondon  +     0.10009495915618 * 
        IMP_TV_REGMidlands  +    -0.14380799271465 * IMP_TV_REGN_East
          +    -0.08778323207855 * IMP_TV_REGN_Scot  +    -0.11299655477035 * 
        IMP_TV_REGN_West  +     -0.0167928054069 * IMP_TV_REGS___S_East
          +     0.02693740509036 * IMP_TV_REGS_West  +    -0.28321092372201 * 
        IMP_TV_REGUlster  +     0.29092258582775 * IMP_TV_REGWales___West ;
   H12  = H12  +    -0.10438732943402 * CLASSGold  +     0.13863785831836 * 
        CLASSPlatinum  +    -0.03598042751917 * CLASSSilver
          +     0.41848775234744 * IMP_GENDERF  +    -0.08724462346384 * 
        IMP_GENDERM  +    -0.20467119181382 * IMP_NGROUPA
          +    -0.44611780178288 * IMP_NGROUPB  +    -0.10852979909576 * 
        IMP_NGROUPC  +    -0.22618886671267 * IMP_NGROUPD
          +     -0.0155263010777 * IMP_NGROUPE  +     0.08225454391076 * 
        IMP_NGROUPF  +     0.02035664130206 * IMP_OAC1
          +     0.10662654894305 * IMP_OAC2  +    -0.13064836635201 * IMP_OAC3
          +     -0.0136539918074 * IMP_OAC4  +    -0.11480830700193 * IMP_OAC5
          +    -0.00467220505911 * IMP_OAC6  +     -0.1247338302323 * IMP_OAC7
          +     0.21523247558521 * IMP_REGIONMidlands
          +    -0.41653089741687 * IMP_REGIONNorth  +     0.00191696512388 * 
        IMP_REGIONScottish  +    -0.04879667796815 * IMP_REGIONSouth_East
          +     0.10490545632063 * IMP_TV_REGBorder  +     0.26006312909674 * 
        IMP_TV_REGC_Scotland  +     0.03253329547017 * IMP_TV_REGEast
          +    -0.21284882315143 * IMP_TV_REGLondon  +    -0.27633257606686 * 
        IMP_TV_REGMidlands  +     0.13945289780683 * IMP_TV_REGN_East
          +     0.10885466243293 * IMP_TV_REGN_Scot  +    -0.01770123035201 * 
        IMP_TV_REGN_West  +    -0.02550987780767 * IMP_TV_REGS___S_East
          +     0.09090983736459 * IMP_TV_REGS_West  +     0.06467327192721 * 
        IMP_TV_REGUlster  +      -0.147608244396 * IMP_TV_REGWales___West ;
   H13  = H13  +     0.05055522019514 * CLASSGold  +      0.1990280249189 * 
        CLASSPlatinum  +    -0.08153616026042 * CLASSSilver
          +     0.43426886863777 * IMP_GENDERF  +     -0.1282732373053 * 
        IMP_GENDERM  +     0.17590606821189 * IMP_NGROUPA
          +     0.07580698780679 * IMP_NGROUPB  +    -0.05435547035847 * 
        IMP_NGROUPC  +     0.13012844755474 * IMP_NGROUPD
          +    -0.07614710678299 * IMP_NGROUPE  +     0.01396662036112 * 
        IMP_NGROUPF  +     0.02536994787372 * IMP_OAC1
          +    -0.08149279029886 * IMP_OAC2  +     0.21589798769085 * IMP_OAC3
          +    -0.20023843131609 * IMP_OAC4  +    -0.04483682993784 * IMP_OAC5
          +    -0.03741802880343 * IMP_OAC6  +     0.09950705447684 * IMP_OAC7
          +      0.0776582718278 * IMP_REGIONMidlands
          +      0.1351222897624 * IMP_REGIONNorth  +    -0.16696124359372 * 
        IMP_REGIONScottish  +     0.18129111199522 * IMP_REGIONSouth_East
          +     0.07246354324647 * IMP_TV_REGBorder  +     0.17120963235164 * 
        IMP_TV_REGC_Scotland  +    -0.23335141695716 * IMP_TV_REGEast
          +     -0.0284731222181 * IMP_TV_REGLondon  +     0.00731484140899 * 
        IMP_TV_REGMidlands  +    -0.02721126383884 * IMP_TV_REGN_East
          +     0.01399274340872 * IMP_TV_REGN_Scot  +       0.011644496562 * 
        IMP_TV_REGN_West  +    -0.09934980032881 * IMP_TV_REGS___S_East
          +    -0.01075098770745 * IMP_TV_REGS_West  +     0.06495065229985 * 
        IMP_TV_REGUlster  +     0.05059136468461 * IMP_TV_REGWales___West ;
   H11  =     1.16142901983657 + H11 ;
   H12  =    -0.74226890924466 + H12 ;
   H13  =    -2.19622621751302 + H13 ;
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
   P_ORGYN1  =     3.21123476336239 * H11  +      0.9631047078858 * H12
          +     3.35094087082483 * H13 ;
   P_ORGYN1  =    -0.70911772692593 + P_ORGYN1 ;
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
   P_ORGYN1  =               0.2435;
   P_ORGYN0  =               0.7565;
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
