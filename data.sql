use BAPERS;

SET FOREIGN_KEY_CHECKS = 0; 
truncate table user;
truncate table address;
truncate table card_details; 
truncate table customer_account;
truncate table discount_plan;
truncate table job;
truncate table task;
truncate table tasks;
truncate table user_type;
truncate table payment_info;
SET FOREIGN_KEY_CHECKS = 1;

insert into User_Type (type) VALUES
('office manager'),
('receptionist'),
('technician'),
('shift manager');

insert into User (username, first_name, surname, passphrase, fk_type) VALUES
('l_caster','glynne','lancaster',
'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86',
(select type from user_type where type = 'office manager')),
('chris','chris','stokes',
'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86',
(select type from user_type where type = 'shift manager')),
('edg','edgar','ragde',
'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86',
(select type from user_type where type = 'technician')),
('teeth','mugeeth','hteegum',
'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86',
(select type from user_type where type = 'receptionist'));

insert into discount_plan (type) values 
('fixed'),
('variable'),
('flexible');

insert into customer_account (account_number, email, account_holder_name, first_name, surname, house_phone, mobile_phone, valued, fk_type) values
('ABC00001', 'the@business.com', 'megacorp business incorporated', 'the', 'businessman', '02012345678', '07123456789', true, 
(select type from discount_plan where type = 'fixed')),
('ABC00002', 'email@liame.com', 'big business', 'the', 'other businessman', '02012345679', '07123456780', true, 
(select type from discount_plan where type = 'variable')),
('ABC00003', 'business3.contact@businessmail.com', 'business3', 'contact', 'person', '02012345670', '07123456781', true, 
(select type from discount_plan where type = 'flexible'));

insert into address (address_line1, postcode, city, country, fk_account_number) values
('101 nostreet', 'n0000', 'londin', 'englind',
(select account_number from customer_account where account_number = 'ABC00001')),
('102 streetno', 'n0001', 'londin', 'englind',
(select account_number from customer_account where account_number = 'ABC00002')),
('140 nstreeto', 'n0000', 'londin', 'englind', 
(select account_number from customer_account where account_number = 'ABC00003'));

insert into task (task_id, description, location, shelf_slot, price, duration) values
('1', 'use of large copy camera', 'copy room', 'cr25', '1900', time '02:00:00');


