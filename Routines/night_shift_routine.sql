CREATE PROCEDURE Night_shift
(IN date_start date,IN date_end date)
BEGIN
call shift(date_start,date_end,'22:00:00','05:00:00');
END