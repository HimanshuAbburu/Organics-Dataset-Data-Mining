data EMWS1.MdlComp5_EMRANK;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg8" MODEL "Reg8" MODELDESCRIPTION "Filtered Step Regression" TARGETLABEL "";
set EMWS1.Reg8_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMSCOREDIST;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg8" MODEL "Reg8" MODELDESCRIPTION "Filtered Step Regression" TARGETLABEL "";
set EMWS1.Reg8_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMOUTFIT;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg8" MODEL "Reg8" MODELDESCRIPTION "Filtered Step Regression" TARGETLABEL "";
set WORK.Reg8_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMCLASSIFICATION;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg8" MODEL "Reg8" MODELDESCRIPTION "Filtered Step Regression" TARGETLABEL "";
set EMWS1.Reg8_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMEVENTREPORT;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg8" MODEL "Reg8" MODELDESCRIPTION "Filtered Step Regression" TARGETLABEL "";
set EMWS1.Reg8_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set EMWS1.Reg9_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMRANK;
set EMWS1.MdlComp5_EMRANK work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set EMWS1.Reg9_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMSCOREDIST;
set EMWS1.MdlComp5_EMSCOREDIST work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set WORK.Reg9_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMOUTFIT;
set EMWS1.MdlComp5_EMOUTFIT work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set EMWS1.Reg9_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMCLASSIFICATION;
set EMWS1.MdlComp5_EMCLASSIFICATION work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set EMWS1.Reg9_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMEVENTREPORT;
set EMWS1.MdlComp5_EMEVENTREPORT work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg10" MODEL "Reg10" MODELDESCRIPTION "Transformed Step Regression" TARGETLABEL "";
set EMWS1.Reg10_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMRANK;
set EMWS1.MdlComp5_EMRANK work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg10" MODEL "Reg10" MODELDESCRIPTION "Transformed Step Regression" TARGETLABEL "";
set EMWS1.Reg10_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMSCOREDIST;
set EMWS1.MdlComp5_EMSCOREDIST work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg10" MODEL "Reg10" MODELDESCRIPTION "Transformed Step Regression" TARGETLABEL "";
set WORK.Reg10_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMOUTFIT;
set EMWS1.MdlComp5_EMOUTFIT work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg10" MODEL "Reg10" MODELDESCRIPTION "Transformed Step Regression" TARGETLABEL "";
set EMWS1.Reg10_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMCLASSIFICATION;
set EMWS1.MdlComp5_EMCLASSIFICATION work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg10" MODEL "Reg10" MODELDESCRIPTION "Transformed Step Regression" TARGETLABEL "";
set EMWS1.Reg10_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp5_EMEVENTREPORT;
set EMWS1.MdlComp5_EMEVENTREPORT work.MdlComp5_TEMP;
run;
