****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;

******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_ORGYN  $   12; 
LENGTH I_ORGYN  $   12; 
LENGTH _WARN_  $    4; 

******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_ORGYN1 = 'Predicted: ORGYN=1' ;
label P_ORGYN0 = 'Predicted: ORGYN=0' ;
label Q_ORGYN1 = 'Unadjusted P: ORGYN=1' ;
label Q_ORGYN0 = 'Unadjusted P: ORGYN=0' ;
label V_ORGYN1 = 'Validated: ORGYN=1' ;
label V_ORGYN0 = 'Validated: ORGYN=0' ;
label R_ORGYN1 = 'Residual: ORGYN=1' ;
label R_ORGYN0 = 'Residual: ORGYN=0' ;
label F_ORGYN = 'From: ORGYN' ;
label I_ORGYN = 'Into: ORGYN' ;
label U_ORGYN = 'Unnormalized Into: ORGYN' ;
label _WARN_ = 'Warnings' ;


******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12; 
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_1 $      1; DROP _ARBFMT_1; 
_ARBFMT_1 = ' '; /* Initialize to avoid warning. */


_ARBFMT_12 = PUT( ORGYN , BEST12.);
 %DMNORMCP( _ARBFMT_12, F_ORGYN );

******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(AGE ) AND 
  AGE  <                 44.5 THEN DO;
  IF  NOT MISSING(AFFL ) AND 
    AFFL  <                 10.5 THEN DO;
    _ARBFMT_1 = PUT( GENDER , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      IF  NOT MISSING(AFFL ) AND 
        AFFL  <                  5.5 THEN DO;
        _NODE_  =                   16;
        _LEAF_  =                    1;
        P_ORGYN1  =             0.265625;
        P_ORGYN0  =             0.734375;
        Q_ORGYN1  =             0.265625;
        Q_ORGYN0  =             0.734375;
        V_ORGYN1  =     0.31914893617021;
        V_ORGYN0  =     0.68085106382978;
        I_ORGYN  = '0' ;
        U_ORGYN  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   17;
        _LEAF_  =                    2;
        P_ORGYN1  =     0.54601226993865;
        P_ORGYN0  =     0.45398773006134;
        Q_ORGYN1  =     0.54601226993865;
        Q_ORGYN0  =     0.45398773006134;
        V_ORGYN1  =     0.60829493087557;
        V_ORGYN0  =     0.39170506912442;
        I_ORGYN  = '1' ;
        U_ORGYN  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                    9;
      _LEAF_  =                    3;
      P_ORGYN1  =     0.21186440677966;
      P_ORGYN0  =     0.78813559322033;
      Q_ORGYN1  =     0.21186440677966;
      Q_ORGYN0  =     0.78813559322033;
      V_ORGYN1  =     0.22110552763819;
      V_ORGYN0  =      0.7788944723618;
      I_ORGYN  = '0' ;
      U_ORGYN  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    4;
    P_ORGYN1  =     0.72849462365591;
    P_ORGYN0  =     0.27150537634408;
    Q_ORGYN1  =     0.72849462365591;
    Q_ORGYN0  =     0.27150537634408;
    V_ORGYN1  =     0.75686274509803;
    V_ORGYN0  =     0.24313725490196;
    I_ORGYN  = '1' ;
    U_ORGYN  =                    1;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(AFFL ) AND 
                    12.5 <= AFFL  THEN DO;
    IF  NOT MISSING(S_MT ) AND 
                    33.315 <= S_MT  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    8;
      P_ORGYN1  =     0.77777777777777;
      P_ORGYN0  =     0.22222222222222;
      Q_ORGYN1  =     0.77777777777777;
      Q_ORGYN0  =     0.22222222222222;
      V_ORGYN1  =     0.47619047619047;
      V_ORGYN0  =     0.52380952380952;
      I_ORGYN  = '1' ;
      U_ORGYN  =                    1;
      END;
    ELSE DO;
      _ARBFMT_1 = PUT( GENDER , $1.);
       %DMNORMIP( _ARBFMT_1);
      IF _ARBFMT_1 IN ('F' ) THEN DO;
        _NODE_  =                   28;
        _LEAF_  =                    6;
        P_ORGYN1  =     0.50318471337579;
        P_ORGYN0  =      0.4968152866242;
        Q_ORGYN1  =     0.50318471337579;
        Q_ORGYN0  =      0.4968152866242;
        V_ORGYN1  =     0.57894736842105;
        V_ORGYN0  =     0.42105263157894;
        I_ORGYN  = '1' ;
        U_ORGYN  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   29;
        _LEAF_  =                    7;
        P_ORGYN1  =     0.27083333333333;
        P_ORGYN0  =     0.72916666666666;
        Q_ORGYN1  =     0.27083333333333;
        Q_ORGYN0  =     0.72916666666666;
        V_ORGYN1  =               0.2625;
        V_ORGYN0  =               0.7375;
        I_ORGYN  = '0' ;
        U_ORGYN  =                    0;
        END;
      END;
    END;
  ELSE DO;
    _NODE_  =                    6;
    _LEAF_  =                    5;
    P_ORGYN1  =     0.11979358643568;
    P_ORGYN0  =     0.88020641356432;
    Q_ORGYN1  =     0.11979358643568;
    Q_ORGYN0  =     0.88020641356432;
    V_ORGYN1  =     0.12046444121915;
    V_ORGYN0  =     0.87953555878084;
    I_ORGYN  = '0' ;
    U_ORGYN  =                    0;
    END;
  END;

*****  RESIDUALS R_ *************;
IF  F_ORGYN  NE '1' 
AND F_ORGYN  NE '0'  THEN DO; 
        R_ORGYN1  = .;
        R_ORGYN0  = .;
 END;
 ELSE DO;
       R_ORGYN1  =  -P_ORGYN1 ;
       R_ORGYN0  =  -P_ORGYN0 ;
       SELECT( F_ORGYN  );
          WHEN( '1'  ) R_ORGYN1  = R_ORGYN1  +1;
          WHEN( '0'  ) R_ORGYN0  = R_ORGYN0  +1;
       END;
 END;

****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;

