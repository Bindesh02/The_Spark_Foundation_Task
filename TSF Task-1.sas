/*Data imported from URL  */
filename student "%sysfunc(getoption(WORK))/student.csv";

proc http 
	out=student 
	url="http://bit.ly/w-data" 
	method="GET";
run;

/*Data imported in SAS Studio  */
proc import 
	file=student 
	out=student_scores 
	dbms=csv replace;
run;

/*Table created using proc sql  */
PROC SQL;
	CREATE TABLE WORK.student_scores AS 
	SELECT Hours , Scores 
	FROM 
		WORK.student_scores;
QUIT;

PROC PRINT DATA=WORK.student_scores;
RUN;

/*Scetter plot Diagram using proc sgplot */
proc sgplot 
	data=WORK.student_scores;
	title "Hours vs Percentage";
	scatter x=Hours y=scores;
run;

/* Regrasion line in scatterplot */
proc sgplot data=WORK.student_scores;
	title "Hours vs Percentage";
	scatter x=Hours y=scores;
	reg x=Hours y=scores / lineattrs=(color=green thickness=2);
run;

/*--Scatter Plot Matrix--*/

title 'Study Profile';
proc sgscatter 
	data=work.student_scores;
  	matrix scores Hours  /
    transparency=0.1 markerattrs=graphdata3(symbol=circlefilled);
  run;

ods graphics on;

proc reg data=work.student_scores;
	MODEL scores=Hours / p;
	run;

ods graphics off;
  
ods noproctitle;
ods graphics / imagemap=on;

proc glmselect 
	data=WORK.STUDENT_SCORES;
	model Scores=Hours / selection=none;
	score out=work.STUDENT_SCORES1 predicted residual;
run;

proc print 
	data=work.STUDENT_SCORES1;
run;

/*prediction Model  */
data work.student_scores2;
   set work.student_scores;
    keep x1 y; 
   b0 =2.43 ; b1 = 9.78 ;
      x1 = 9.25;
      epsilon = 0 ;
      y = b0 + b1*x1 + epsilon;
      output;
run;

/* now let's Predict Value On the basis of simple linear regrassion   */
title "Predicted score(Y) of Student on the Basis of Hours(X1)";
proc print 
	data=work.student_scores2(obs=1);
run;
Title;


