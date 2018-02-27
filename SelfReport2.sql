select Customer_Account.account_holder_name as 'Account Holder',
Sum(Payment_Info.amount_paid) as 'Total Amount Paid',
Count(Job.fk_account_number) as 'No. Of Jobs'
From Customer_Account
Inner join Job
On Customer_Account.account_number = Job.fk_account_number
Inner join Payment 
on Payment.fk_job_id = Job.job_id
Inner Join Payment_Info
On Payment_Info.payment_id = Payment.fk_payment_id
Group by Customer_Account.account_holder_name
order by sum(Payment_Info.amount_paid) DESC;

