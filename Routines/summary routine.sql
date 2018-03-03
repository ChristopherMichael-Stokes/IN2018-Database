CREATE PROCEDURE Summary
(IN date_start date,IN date_end date)
BEGIN
DROP temporary table IF EXISTS Sum_table;
create temporary table Sum_table(Title char(20),Copy_Room time,Development time,Finishing time,Packing time);
call Sum_Day_shift1(date_start,date_end);
INSERT INTO Sum_table SELECT * FROM Sum_shift order by Sum_shift.Title;
DROP table IF EXISTS Sum_shift;
call Sum_Day_shift2(date_start,date_end);
INSERT INTO Sum_table SELECT * FROM Sum_shift order by Sum_shift.Title;
DROP table IF EXISTS Sum_shift;
call Sum_night_shift(date_start,date_end);
INSERT INTO Sum_table SELECT * FROM Sum_shift order by Sum_shift.Title;
select * from Sum_table;
select
sec_to_time(sum(time_to_sec(Copy_room))) as Copy_room,
sec_to_time(sum(time_to_sec(Development))) as Development,
sec_to_time(sum(time_to_sec(Finishing))) as Finishing, 
sec_to_time(sum(time_to_sec(Packing))) as Packing
from Sum_table;
DROP table IF EXISTS Sum_shift;
DROP temporary table IF EXISTS Sum_table;
END