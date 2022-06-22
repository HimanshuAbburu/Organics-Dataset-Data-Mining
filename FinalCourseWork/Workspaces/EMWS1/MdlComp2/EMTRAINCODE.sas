data EMWS1.MdlComp2_EMRANK;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree3" MODEL "Tree3" MODELDESCRIPTION "3way Decision Tree" TARGETLABEL "";
set EMWS1.Tree3_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMSCOREDIST;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree3" MODEL "Tree3" MODELDESCRIPTION "3way Decision Tree" TARGETLABEL "";
set EMWS1.Tree3_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMOUTFIT;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree3" MODEL "Tree3" MODELDESCRIPTION "3way Decision Tree" TARGETLABEL "";
set WORK.Tree3_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMCLASSIFICATION;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree3" MODEL "Tree3" MODELDESCRIPTION "3way Decision Tree" TARGETLABEL "";
set EMWS1.Tree3_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMEVENTREPORT;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree3" MODEL "Tree3" MODELDESCRIPTION "3way Decision Tree" TARGETLABEL "";
set EMWS1.Tree3_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree4" MODEL "Tree4" MODELDESCRIPTION "Manual DT" TARGETLABEL "";
set EMWS1.Tree4_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMRANK;
set EMWS1.MdlComp2_EMRANK work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree4" MODEL "Tree4" MODELDESCRIPTION "Manual DT" TARGETLABEL "";
set EMWS1.Tree4_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMSCOREDIST;
set EMWS1.MdlComp2_EMSCOREDIST work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree4" MODEL "Tree4" MODELDESCRIPTION "Manual DT" TARGETLABEL "";
set WORK.Tree4_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMOUTFIT;
set EMWS1.MdlComp2_EMOUTFIT work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree4" MODEL "Tree4" MODELDESCRIPTION "Manual DT" TARGETLABEL "";
set EMWS1.Tree4_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMCLASSIFICATION;
set EMWS1.MdlComp2_EMCLASSIFICATION work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree4" MODEL "Tree4" MODELDESCRIPTION "Manual DT" TARGETLABEL "";
set EMWS1.Tree4_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMEVENTREPORT;
set EMWS1.MdlComp2_EMEVENTREPORT work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree2" MODEL "Tree2" MODELDESCRIPTION "Decision Tree Pruned" TARGETLABEL "";
set EMWS1.Tree2_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMRANK;
set EMWS1.MdlComp2_EMRANK work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree2" MODEL "Tree2" MODELDESCRIPTION "Decision Tree Pruned" TARGETLABEL "";
set EMWS1.Tree2_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMSCOREDIST;
set EMWS1.MdlComp2_EMSCOREDIST work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree2" MODEL "Tree2" MODELDESCRIPTION "Decision Tree Pruned" TARGETLABEL "";
set WORK.Tree2_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMOUTFIT;
set EMWS1.MdlComp2_EMOUTFIT work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree2" MODEL "Tree2" MODELDESCRIPTION "Decision Tree Pruned" TARGETLABEL "";
set EMWS1.Tree2_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMCLASSIFICATION;
set EMWS1.MdlComp2_EMCLASSIFICATION work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree2" MODEL "Tree2" MODELDESCRIPTION "Decision Tree Pruned" TARGETLABEL "";
set EMWS1.Tree2_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMEVENTREPORT;
set EMWS1.MdlComp2_EMEVENTREPORT work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set EMWS1.Tree_EMRANK;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMRANK;
set EMWS1.MdlComp2_EMRANK work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set EMWS1.Tree_EMSCOREDIST;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMSCOREDIST;
set EMWS1.MdlComp2_EMSCOREDIST work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set WORK.Tree_OUTFIT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMOUTFIT;
set EMWS1.MdlComp2_EMOUTFIT work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set EMWS1.Tree_EMCLASSIFICATION;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMCLASSIFICATION;
set EMWS1.MdlComp2_EMCLASSIFICATION work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Tree" MODEL "Tree" MODELDESCRIPTION "Decision Tree Default" TARGETLABEL "";
set EMWS1.Tree_EMEVENTREPORT;
where upcase(TARGET) = upcase("ORGYN");
run;
data EMWS1.MdlComp2_EMEVENTREPORT;
set EMWS1.MdlComp2_EMEVENTREPORT work.MdlComp2_TEMP;
run;
