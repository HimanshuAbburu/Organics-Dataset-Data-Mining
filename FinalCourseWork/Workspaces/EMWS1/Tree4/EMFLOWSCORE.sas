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
        _NODE_  =                  110;
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
        IF  NOT MISSING(AFFL ) AND
                           9.5 <= AFFL  THEN DO;
          _NODE_  =                  113;
          _LEAF_  =                    4;
          P_ORGYN1  =     0.69565217391304;
          P_ORGYN0  =     0.30434782608695;
          Q_ORGYN1  =     0.69565217391304;
          Q_ORGYN0  =     0.30434782608695;
          V_ORGYN1  =     0.72727272727272;
          V_ORGYN0  =     0.27272727272727;
          I_ORGYN  = '1' ;
          U_ORGYN  =                    1;
          END;
        ELSE DO;
          IF  NOT MISSING(AGE ) AND
                            39.5 <= AGE  THEN DO;
            _NODE_  =                  115;
            _LEAF_  =                    3;
            P_ORGYN1  =      0.3763440860215;
            P_ORGYN0  =     0.62365591397849;
            Q_ORGYN1  =      0.3763440860215;
            Q_ORGYN0  =     0.62365591397849;
            V_ORGYN1  =     0.44827586206896;
            V_ORGYN0  =     0.55172413793103;
            I_ORGYN  = '0' ;
            U_ORGYN  =                    0;
            END;
          ELSE DO;
            _NODE_  =                  114;
            _LEAF_  =                    2;
            P_ORGYN1  =     0.57926829268292;
            P_ORGYN0  =     0.42073170731707;
            Q_ORGYN1  =     0.57926829268292;
            Q_ORGYN0  =     0.42073170731707;
            V_ORGYN1  =     0.64347826086956;
            V_ORGYN0  =     0.35652173913043;
            I_ORGYN  = '1' ;
            U_ORGYN  =                    1;
            END;
          END;
        END;
      END;
    ELSE DO;
      _NODE_  =                  109;
      _LEAF_  =                    5;
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
    _NODE_  =                  107;
    _LEAF_  =                    6;
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
  _NODE_  =                  105;
  _LEAF_  =                    7;
  P_ORGYN1  =     0.15256495669553;
  P_ORGYN0  =     0.84743504330446;
  Q_ORGYN1  =     0.15256495669553;
  Q_ORGYN0  =     0.84743504330446;
  V_ORGYN1  =     0.15162138475021;
  V_ORGYN0  =     0.84837861524978;
  I_ORGYN  = '0' ;
  U_ORGYN  =                    0;
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
 
drop _LEAF_;
