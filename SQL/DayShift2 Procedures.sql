use bapers;
DROP PROCEDURE IF EXISTS Day_shift2;
DELIMITER //
CREATE PROCEDURE Day_shift2
(IN date CHAR(20))
BEGIN
call shift(date, '14:30:00', '22:00:00');
END //
DELIMITER ;