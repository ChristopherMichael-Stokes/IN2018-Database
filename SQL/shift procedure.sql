use bapers;
DROP PROCEDURE IF EXISTS shift;
DELIMITER //
CREATE PROCEDURE shift
(IN date CHAR(20), in shift_start char(20), in shift_end char(20))
BEGIN
Select date(job_task.start_time) as 'Date',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Copy Room' and time(job_task.start_time) >= shift_start and time(job_task.start_time) < shift_end and date(job_task.end_time) = date
)
as 'Copy Room',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Development Area' and time(job_task.start_time) >= shift_start and time(job_task.start_time) < shift_end and date(job_task.end_time) = date
)
as 'Development',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Finishing Room' and time(job_task.start_time) >= shift_start and time(job_task.start_time) < shift_end and date(job_task.end_time) = date
)
as 'Finishing',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Packing Departments' and time(job_task.start_time) >= shift_start and time(job_task.start_time) < shift_end and date(job_task.end_time) = date
)
as 'Packing'
from Job_Task
inner join task
on Job_task.fk_task_id = task.task_id
group by date(job_task.start_time);
END //
DELIMITER ;