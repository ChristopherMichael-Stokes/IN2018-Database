DROP PROCEDURE IF EXISTS Day_shift2;
DELIMITER //
CREATE PROCEDURE Day_shift2
(IN date CHAR(20))
BEGIN
Select date(job_task.start_time) as 'Date',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Copy Room')
as 'Copy Room',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Development Area')
as 'Development',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Finishing Room')
as 'Finishing',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Packing Departments')
as 'Packing'
from Job_Task
inner join task
on Job_task.fk_task_id = task.task_id
where time(time_to_sec(job_task.start_time)) >=time_to_sec('14:30:00') and time(time_to_sec(job_task.start_time)) < time_to_sec('22:00:00') and date(job_task.end_time) = date
group by date(job_task.start_time);
END //
DELIMITER ;