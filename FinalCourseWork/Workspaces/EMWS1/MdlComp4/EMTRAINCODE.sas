data EMWS1.MdlComp4_EMRANK;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural3" MODEL "Neural3" MODELDESCRIPTION "Imputed Neural Network" TARGETLABEL "";
set EMWS1.Neural3_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMSCOREDIST;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural3" MODEL "Neural3" MODELDESCRIPTION "Imputed Neural Network" TARGETLABEL "";
set EMWS1.Neural3_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMOUTFIT;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural3" MODEL "Neural3" MODELDESCRIPTION "Imputed Neural Network" TARGETLABEL "";
set WORK.Neural3_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMCLASSIFICATION;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural3" MODEL "Neural3" MODELDESCRIPTION "Imputed Neural Network" TARGETLABEL "";
set EMWS1.Neural3_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMEVENTREPORT;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural3" MODEL "Neural3" MODELDESCRIPTION "Imputed Neural Network" TARGETLABEL "";
set EMWS1.Neural3_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set EMWS1.Tree_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMRANK;
set EMWS1.MdlComp4_EMRANK work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set EMWS1.Tree_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMSCOREDIST;
set EMWS1.MdlComp4_EMSCOREDIST work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set WORK.Tree_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMOUTFIT;
set EMWS1.MdlComp4_EMOUTFIT work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set EMWS1.Tree_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMCLASSIFICATION;
set EMWS1.MdlComp4_EMCLASSIFICATION work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set EMWS1.Tree_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMEVENTREPORT;
set EMWS1.MdlComp4_EMEVENTREPORT work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set EMWS1.Reg9_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMRANK;
set EMWS1.MdlComp4_EMRANK work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set EMWS1.Reg9_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMSCOREDIST;
set EMWS1.MdlComp4_EMSCOREDIST work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set WORK.Reg9_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMOUTFIT;
set EMWS1.MdlComp4_EMOUTFIT work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set EMWS1.Reg9_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMCLASSIFICATION;
set EMWS1.MdlComp4_EMCLASSIFICATION work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg9" MODEL "Reg9" MODELDESCRIPTION "Imputed Step Regression" TARGETLABEL "";
set EMWS1.Reg9_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp4_EMEVENTREPORT;
set EMWS1.MdlComp4_EMEVENTREPORT work.MdlComp4_TEMP;
run;
