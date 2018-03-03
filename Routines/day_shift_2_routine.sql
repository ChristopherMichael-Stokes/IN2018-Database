CREATE PROCEDURE Day_shift2
(IN date_start date,IN date_end date)
BEGIN
call shift(date_start,date_end,'14:30:00','22:00:00');
END