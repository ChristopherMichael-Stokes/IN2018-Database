Create or replace view IPR1 as
select concat(first_name,' ',surname) as Name,
Job.job_id as 'Code',
Job_Task.fk_task_id as 'Task IDs',
Task.location as 'Department',
DATE(Job_Task.start_time) as 'Date',
TIME(Job_Task.start_time) as 'Start Time',
TIMEDIFF(Job_Task.end_time,Job_task.start_time) as 'Time Taken'
from staff
inner join job_task 
on staff.staff_id = job_task.fk_staff_id
inner join job
on job_task.fk_job_id = job.job_id
inner join task
on job_task.fk_task_id = task.task_id
where staff_id in('0001','0002','0003','0004','0005') 
order by Name,SUBSTRING_INDEX('Start time', " ", -1), SUBSTRING_INDEX('Start time', " ", 1)

