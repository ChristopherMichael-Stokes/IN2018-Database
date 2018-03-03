CREATE PROCEDURE shift
(in date_start char(20),in date_end char(20),in shift_start char(20), in shift_end char(20))
BEGIN
drop temporary table if exists tmp;
BEGIN
create temporary table tmp
Select date(job_task.start_time)as 'Date',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Copy Room' and job_task.start_time>=concat(date,' ',shift_start) and job_task.start_time < (IF(shift_end = '05:00:00',(SELECT concat(DATE_ADD(date, INTERVAL 1 DAY),' ',shift_end)),concat(date,' ',shift_end))) and if(shift_end ='05:00:00',if(date(job_task.start_time)>date,date(job_task.start_time)= DATE_ADD(date, INTERVAL 1 DAY),date(job_task.start_time) = date),date(job_task.start_time) = date)
)
as 'Copy_Room',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Development Area' and job_task.start_time>=concat(date,' ',shift_start) and job_task.start_time < (IF(shift_end = '05:00:00',(SELECT concat(DATE_ADD(date, INTERVAL 1 DAY),' ',shift_end)),concat(date,' ',shift_end))) and if(shift_end ='05:00:00',if(date(job_task.start_time)>date,date(job_task.start_time)= DATE_ADD(date, INTERVAL 1 DAY),date(job_task.start_time) = date),date(job_task.start_time) = date)
)
as 'Development',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Finishing Room' and job_task.start_time>=concat(date,' ',shift_start) and job_task.start_time < (IF(shift_end = '05:00:00',(SELECT concat(DATE_ADD(date, INTERVAL 1 DAY),' ',shift_end)),concat(date,' ',shift_end))) and if(shift_end ='05:00:00',if(date(job_task.start_time)>date,date(job_task.start_time)= DATE_ADD(date, INTERVAL 1 DAY),date(job_task.start_time) = date),date(job_task.start_time) = date)
)
as 'Finishing',
(select SEC_TO_TIME( SUM( TIME_TO_SEC( TIMEDIFF(Job_Task.end_time,Job_task.start_time) ) ) )
from Job_Task 
inner join Task 
on Job_Task.fk_task_id = task.task_id
where task.location = 'Packing Departments' and job_task.start_time>=concat(date,' ',shift_start) and job_task.start_time < (IF(shift_end = '05:00:00',(SELECT concat(DATE_ADD(date, INTERVAL 1 DAY),' ',shift_end)),concat(date,' ',shift_end))) and if(shift_end ='05:00:00',if(date(job_task.start_time)>date,date(job_task.start_time)= DATE_ADD(date, INTERVAL 1 DAY),date(job_task.start_time) = date),date(job_task.start_time) = date)
)
as 'Packing'
from Job_Task
inner join task
on Job_task.fk_task_id = task.task_id
where date(job_task.start_time) between date_start and date_end
group by date(job_task.start_time);
END;
select * from tmp;
select sec_to_time(sum(time_to_sec(Copy_room))) as Copy_room,
sec_to_time(sum(time_to_sec(Development))) as Development,
sec_to_time(sum(time_to_sec(Finishing))) as Finishing, 
sec_to_time(sum(time_to_sec(Packing))) as Packing
from tmp;
drop temporary table if exists tmp;
END