CREATE PROCEDURE Sum_Day_shift2
(IN date_start date,IN date_end date)
BEGIN
call Summary_shift(date_start,date_end,'14:30:00','22:00:00','Day Shift2');
END