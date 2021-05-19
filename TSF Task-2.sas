/** FOR CSV Files uploaded from Windows **/
FILENAME IRIS "/home/u57841010/The Spark Foundation Task/Iris.csv";
/** Import the CSV file.  **/
PROC IMPORT DATAFILE=IRIS
		    OUT=WORK.IRIS
		    DBMS=CSV
		    REPLACE;
RUN;
/** Print the results. **/
PROC PRINT 
	DATA=WORK.IRIS (obs=15); 
RUN;
/** Unassign the file reference.  **/
FILENAME IRIS;

/* Checking the contents of the datasets */
proc means 
	data=work.iris N Nmiss mean median max min;
	var sepallengthcm--petalwidthcm;
run;

/* Perfoming Cluster Analysis */
ods graphics on;
proc cluster 
	data = work.iris 
	method = centroid ccc 
	print=15 
	outtree=Work.IRIS;
	var sepallengthcm--petalwidthcm;
run;
ods graphics off;

/* Retaining 3 clusters */
proc tree noprint ncl=3 
	out=Work.IRIS;
	copy sepallengthcm--petalwidthcm;
run;

/* To create a Scatterplot */
proc candisc 
	out = work.IRIS;
	class cluster;
	var petalwidthcm: sepallengthcm:;
run;

proc sgplot 
	data = Work.IRIS;
	title "Cluster Analysis for IRIS datasets";
	scatter y = can2 x = can1 / group = cluster 
	transparency=0.1;
run;


