DROP PROCEDURE IF EXISTS Night_shift;
DELIMITER //
CREATE PROCEDURE Night_shift
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
where job_task.start_time >= 'date 22:00:00' and time(job_task.end_time) < 'date 05:00:00' and date(job_task.start_time) = date
group by date(job_task.start_time);
END //
DELIMITER ;