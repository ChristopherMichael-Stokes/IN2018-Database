Select Job_Task.fk_task_id as 'Task ID',
count(Job_Task.fk_task_id) as 'No. Entries in Database'
From Job_Task
Group by Job_Task.fk_task_id
Order by Count(Job_Task.fk_task_id) DESC;