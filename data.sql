use BAPERS;

SET FOREIGN_KEY_CHECKS = 0; 

SET FOREIGN_KEY_CHECKS = 1;

insert into Job (job_id, description,amount_due,deadline,urgent,fk_account_number) values
('abc123','Testing','1900',time'02:00:00',false,(select account_number from customer_account where account_number = 'acc0001'));

insert into Job_Task (fk_job_id, fk_task_id,start_time,end_time,fk_staff_id) values
((select job_id from Job where job_id = 'abc123'),
(select task_id from Task where task_id = '1'),
'2018-01-14 02:00:00',
'2018-01-14 03:00:00',
(select staff_id from Staff where staff_id ='0001')),
((select job_id from Job where job_id = 'abc123'),
(select task_id from Task where task_id = '2'),
'2018-01-13 22:00:00',
'2018-01-13 23:00:00',
(select staff_id from Staff where staff_id ='0002')),
((select job_id from Job where job_id = 'abc123'),
(select task_id from Task where task_id = '3'),
'2018-01-13 23:00:00',
'2018-01-14 00:00:00',
(select staff_id from Staff where staff_id ='0002')),
((select job_id from Job where job_id = 'abc123'),
(select task_id from Task where task_id = '2'),
'2018-01-14 01:00:00',
'2018-01-14 02:00:00',
(select staff_id from Staff where staff_id ='0001'));
