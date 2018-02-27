use BAPERS;

SET FOREIGN_KEY_CHECKS = 0; 
truncate table Staff;
truncate table address;
truncate table card_details; 
truncate table customer_account;
truncate table discount_plan;
truncate table discount;
truncate table discount_band;
truncate table Task_discount;
truncate table job;
truncate table task;
truncate table Job_Task;
truncate table user_type;
truncate table payment_info;
truncate table payment;
SET FOREIGN_KEY_CHECKS = 1;

insert into User_Type (type) VALUES
('office manager'),
('receptionist'),
('technician'),
('shift manager');

insert into Staff (staff_id, first_name, surname, passphrase, fk_type) VALUES
('1','glynne','lancaster',
'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86',
(select type from user_type where type = 'office manager')),
('2','chris','stokes',
'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86',
(select type from user_type where type = 'shift manager')),
('3','edgar','ragde',
'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86',
(select type from user_type where type = 'technician')),
('4','mugeeth','hteegum',
'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86',
(select type from user_type where type = 'receptionist'));

insert into discount_plan (type) values 
('fixed'),
('variable'),
('flexible');

insert into customer_account (account_number,email,account_holder_name,title,first_name,surname,house_phone,mobile_phone) values
('ABC00001', 'the@business.com', 'megacorp business incorporated','Mr', 'the', 'businessman', '02012345678', '07123456789'),
('ABC00002', 'email@liame.com', 'big business','Mr', 'the', 'other businessman', '02012345679', '07123456780'),
('ABC00003', 'business3.contact@businessmail.com', 'business3','Mr', 'contact', 'person', '02012345670', '07123456781');

insert into address (address_line1,address_line2, postcode, city, country, fk_account_number) values
('101 nostreet','', 'n0000', 'londin', 'englind',
(select account_number from customer_account where account_number = 'ABC00001')),
('102 streetno','', 'n0001', 'londin', 'englind',
(select account_number from customer_account where account_number = 'ABC00002')),
('140 nstreeto','', 'n0000', 'londin', 'englind', 
(select account_number from customer_account where account_number = 'ABC00003'));

insert into task (task_id, description, location, shelf_slot, price, duration) values
('1', 'use of large copy camera', 'copy room', 'cr25', '1900', time '02:00:00'),
('2', 'use of large abc', 'copy room', 'cr420', '1911', time '03:00:00'),
('3', 'use of large def', 'your room', 'cr69', '1939', time '05:00:00'),
('4', 'use of large hij', 'my room', 'cr360', '1945', time '04:00:00'),
('5', 'use of large abb', 'god know whos room', 'cr007', '1996', time '06:00:00');

insert into Job (job_id, description,amount_due,deadline,urgent,fk_account_number) values
('1','Job1','1900',time'02:00:00',false,(select account_number from customer_account where account_number = 'ABC00001')),
('2','Job2','1911',time'02:11:00',false,(select account_number from customer_account where account_number = 'ABC00002')),
('3','Job3','1922',time'02:22:00',false,(select account_number from customer_account where account_number = 'ABC00003')),
('4','Job4','1933',time'02:33:00',false,(select account_number from customer_account where account_number = 'ABC00001')),
('5','Job5','1944',time'02:44:00',false,(select account_number from customer_account where account_number = 'ABC00001'));

insert into Job_Task (fk_job_id, fk_task_id,start_time,end_time,fk_staff_id) values
((select job_id from Job where job_id = '1'),
(select task_id from Task where task_id = '1'),
time'02:00:00',
time'03:00:00',
(select staff_id from Staff where staff_id ='1')),
((select job_id from Job where job_id = '1'),
(select task_id from Task where task_id = '2'),
time'02:00:00',
time'03:00:00',
(select staff_id from Staff where staff_id ='2')),
((select job_id from Job where job_id = '1'),
(select task_id from Task where task_id = '3'),
time'02:00:00',
time'03:00:00',
(select staff_id from Staff where staff_id ='2')),
((select job_id from Job where job_id = '2'),
(select task_id from Task where task_id = '2'),
time'02:00:00',
time'03:00:00',
(select staff_id from Staff where staff_id ='1'));

insert into Payment_info (payment_id,amount_paid,payment_type,date_paid) values
('1','123','cash','1996-10-07'),
('2','2341','card','1996-10-06'),
('3','4323','card','1996-10-05'),
('4','4465','cash','1996-10-04'),
('5','5423','card','1996-10-03'),
('6','54342','cash','1996-10-02'),
('7','3251','cash','1996-10-07');

insert into payment (fk_payment_id,fk_job_id) values
((select payment_id from payment_info where payment_id = '1'),
(select job_id from Job where job_id = '1')),
((select payment_id from payment_info where payment_id = '2'),
(select job_id from Job where job_id = '2')),
((select payment_id from payment_info where payment_id = '3'),
(select job_id from Job where job_id = '3')),
((select payment_id from payment_info where payment_id = '4'),
(select job_id from Job where job_id = '4')),
((select payment_id from payment_info where payment_id = '5'),
(select job_id from Job where job_id = '5'));