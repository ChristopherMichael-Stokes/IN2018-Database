/* Run to Use The Data Base BAPERS */
USE BAPERS;
/* Create the Night Shift report according to input value with parameter(Start_date,End_date), If End_date values is later then datas date, it will return datas between start_date till the end of the data's date includsively. */
/* Outcome: Hours on each location accodring to date and Total hours on each location on period specify by the user in the parameter. */
call night_shift('2018-01-13','2018-01-17');
/* Create the Day Shift1 report according to input value with parameter(Start_date,End_date), If End_date values is later then datas date, it will return datas between start_date till the end of the data's date includsively. */
/* Outcome: Hours on each location accodring to date and Total hours on each location on period specify by the user in the parameter. */
call day_shift1('2018-01-13','2018-01-17');
/* Create the Day Shift2 report according to input value with parameter(Start_date,End_date), If End_date values is later then datas date, it will return datas between start_date till the end of the data's date includsively. */
/* Outcome: Hours on each location accodring to date and Total hours on each location on period specify by the user in the parameter. */
call day_shift2('2018-01-13','2018-01-17');
/* Create Summary Report according to input value with parameter(Start_date,End_date), if End_date valies is later than datas date, it will return datas between Start_date till the end of the data's date includsively. */
/*Outcome: Total Hours from each Shift from the period specify by the parameter and total hours for each location neglect from which shift. */
call summary('2018-01-13','2018-01-17');
/* Create Individual Performance Report with parameter(ID), which ID represent the staff_id in the database. User can also input 'all' inside the parameter to get every technician performance report with the total effort for each individual and overall effort which combine all individual's hours. */
/*Outcome: Details of the selected individual's job_task, time spend on each task and total time spend on task by selected individual, and total effort(Total time spend on task) from the report generate.) */
call ipr('all');