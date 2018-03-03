CREATE PROCEDURE Sum_Night_shift
(IN date_start date,IN date_end date)
BEGIN
call Summary_Shift(date_start,date_end,'22:00:00','05:00:00','Night Shift');
END