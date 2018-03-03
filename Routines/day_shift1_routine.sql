CREATE PROCEDURE Day_shift1
(IN date_start date,IN date_end date)
BEGIN
call shift(date_start,date_end,'05:00:00','14:30:00');
END