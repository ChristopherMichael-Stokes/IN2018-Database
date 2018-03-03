CREATE PROCEDURE Sum_Day_shift1
(IN date_start date,IN date_end date)
BEGIN
call Summary_Shift(date_start,date_end,'05:00:00','14:30:00','Day Shift1');
END
