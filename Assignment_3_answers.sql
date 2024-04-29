-- TASK 2

-- QUES 2

-- QUES 1

select first_name, last_name, account_type, email
from Customers INNER JOIN Accounts 
on Customers.customer_id = Accounts.customer_id;

-- QUES 2

select c.first_name, c.last_name, t.transaction_id, t.transaction_type, t.amount, t.transaction_date
from Customers c INNER JOIN Accounts a 
on c.customer_id = a.customer_id INNER JOIN Transactions t 
on a.account_id = t.account_id;


-- QUES 3

update Accounts
set balance = balance + 1000
where account_id = 1;

-- select * from Accounts

-- QUES 4

select concat(first_name, ' ', last_name) as full_name
from Customers;

-- QUES 5

delete from Accounts
where balance = 0 and account_type = 'savings';

-- QUES 6

select * from customers
where address = 'Indore';

-- QUES 7

select balance from Accounts
where account_id = 1;

-- QUES 8

select * from accounts
where account_type = 'current' and balance > 1000.00;

-- QUES 9

select * from transactions
where account_id = 3;

-- QUES 10

select account_id, balance * 3 as interest_accrued
from accounts
where account_type = 'savings';

-- QUES 11

select * from accounts
where balance < 5000;

-- QUES 12

select * from customers
where address <> 'Indore';
-- where address not like '%Indore%';

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TASK 3

-- QUES 1

select avg(balance) from accounts;

-- QUES 2

-- select * from accounts;

select account_id, customer_id, account_type, balance 
from accounts
order by balance desc
limit 10;
 
-- QUES 3

select sum(amount) as total_deposits
from Transactions
where transaction_type = 'deposit'
and transaction_date = '2021-01-11';

-- select * from transactions;

-- QUES 4

/*
WITH OldestCustomer as (select customer_id, first_name, last_name
	from Customers
    where DOB = (select min(DOB) from Customers)
),
NewestCustomer AS (
  SELECT customer_id, first_name, last_name
  FROM Customers
  WHERE DOB = (SELECT MAX(DOB) FROM Customers)
)
SELECT 'Oldest Customer:' AS customer_type, oc.customer_id, oc.first_name, oc.last_name
FROM OldestCustomer oc
UNION ALL
SELECT 'Newest Customer:' AS customer_type, nc.customer_id, nc.first_name, nc.last_name
FROM NewestCustomer nc;
*/

-- QUES 5

select t.transaction_id, t.transaction_type, t.amount, t.transaction_date, a.account_type
from Transactions t INNER JOIN Accounts a 
on t.account_id = a.account_id;


-- QUES 6

select c.customer_id, c.first_name, c.last_name, a.account_id, a.account_type, a.balance
from Customers c INNER JOIN Accounts a 
on c.customer_id = a.customer_id;

-- QUES 7

select c.customer_id, c.first_name, c.last_name, t.transaction_id, t.transaction_type, t.amount, t.transaction_date
from Customers c INNER JOIN Accounts a 
on c.customer_id = a.customer_id INNER JOIN Transactions t 
on a.account_id = t.account_id
where a.account_id = 1;


-- QUES 8

select c.customer_id, c.first_name, c.last_name
from Customers c INNER JOIN Accounts a 
on c.customer_id = a.customer_id
group by c.customer_id
having count(a.account_id) > 1;


-- QUES 9

select sum(case when transaction_type = 'deposit' 
	then amount else 0 end) as total_deposits,
       sum(case when transaction_type = 'withdrawal' 
	then amount else 0 end) as total_withdrawals,
       sum(case when transaction_type = 'deposit' 
	then amount else 0 end) - 
       sum(case when transaction_type = 'withdrawal' 
	then amount else 0 end) as difference
from Transactions;


--  QUES 10
/*
select account_id, avg(balance) as average_daily_balance
from (select account_id, sum(balance) as balance
    from Accounts
    where date(transaction_date) between '2021-01-12' and '2021-01-14'
    group by account_id, date(transaction_date)
) as daily_balances
group byaccounts account_id;
*/

-- QUES 11

select account_type, sum(balance) as total_balance
from Accounts
group by account_type;


-- QUES 12

select a.account_id, count(t.transaction_id) as transaction_count
from Accounts a INNER JOIN Transactions t 
on a.account_id = t.account_id
group by a.account_id
order by transaction_count desc;


-- QUES 13

select c.customer_id, c.first_name, c.last_name, a.account_type, sum(a.balance) as total_balance
from Customers c INNER JOIN Accounts a 
on c.customer_id = a.customer_id
group by c.customer_id, a.account_type
having total_balance > 10000;



-- QUES 14

select transaction_id, account_id, transaction_type, amount, transaction_date
from Transactions
where (amount, transaction_date, account_id) in (
    select amount, transaction_date, account_id
    from Transactions
    group by amount, transaction_date, account_id
    having count(*) > 1
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TASK 4

-- QUES 1

select * from Customers
where customer_id = (
    select customer_id
    from Accounts
    order by balance desc
    limit 1
);

-- QUES 2

select avg(avg_balance) as average_balance
from (
    select customer_id, avg(balance) as avg_balance
    from Accounts
    group by customer_id
    having count(*) > 1
) as avg_balances;

-- QUES 3

select account_id
from Transactions
where amount > (
    select avg(amount)
    from Transactions
);

-- QUES 4

select *
from Customers
where customer_id not in (
    select distinct customer_id
    from Transactions
);

-- QUES 5

select sum(balance) as total_balance
from Accounts
where account_id not in (
    select distinct account_id
    from Transactions
);

-- QUES 6

select *
from Transactions
where account_id = (
    select account_id
    from Accounts
    order by balance
    limit 1
);

-- QUES 7

select customer_id
from Accounts
group by customer_id
having count(distinct account_type) > 1;

-- QUES 8

select account_type, count(*) as account_count,
       (count(*) * 100.0) / (select count(*) from Accounts) as percentage
from Accounts
group by account_type;

-- QUES 9

select *
from Transactions
where account_id in (
    select account_id
    from Accounts
    where customer_id = 1
);

-- QUES 10

select account_type,
       (select sum(balance) from Accounts where account_type = a.account_type) as total_balance
from Accounts a
group by account_type;