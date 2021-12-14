-- Q1 Count the number of customers whose income is at least twice the income of any customer whose last name is Butler.

Select count(c.cid)
from customer c 
where c.income >= any(select 2*c.income from customer c where c.last = 'Butler');

-- Q2 Customer id, income, account numbers and branch names of customers with income greater than 90,000 who own an account at both London and Athens branches, order by customer id then account number. The result should contain all the account numbers of customers who meet the criteria, even if the account itself is not held at London or Athens.

select c.cid, c.income, o.num, b.name from customer c, owns o, account a, branch b
where c.cid = o.cid and o.num = a.num and a.bid = b.bid and c.income > 90000 and c.cid in 
(select R1.cid from (
select c1.cid from customer c1 
JOIN owns o1 on c1.cid = o1.cid
JOIN account a1 on o1.num = a1.num
JOIN branch b2 on a1.bid = b2.bid and b2.name = 'Athens') R1
JOIN
(select c2.cid from customer c2
JOIN owns o2 on c2.cid = o2.cid
JOIN account a2 on o2.num = a2.num
JOIN branch b3 on a2.bid = b3.bid and b3.name = 'London') R2
on R1.cid = R2.cid order by R1.cid)
order by c.cid, o.num;

-- Q3 Branch name, account number and balance of accounts with balances greater than 110,000 held at the Athens branch, order by account number.

select b.name, o.num, a.balance from owns  o, account a, branch b
where o.num = a.num and a.bid = b.bid and a.balance > 110000 and b.name = 'Athens'
order by o.num;


-- Q4 Total number of all accounts.

select count(num) from account;

-- Q5 Branch name and total number of accounts in that branch. Order by branch name.

select b.name, count(num) from branch b, account a
where b.bid = a.bid
group by b.name
order by b.name;

-- Q6 Account number of all accounts co-owned by 3 or more people.

select o.num from owns o
group by o.num
having count(o.num) >= 3;

-- Q7 Number of customers who own accounts.


select count(distinct cid) from owns; 


-- Q8 Number of customers who do not co-own accounts.

select count(owns.cid) from owns where owns.num in (select o.num from owns o
group by o.num
having count(o.num) = 1);

-- Q9 Customer first and last name of customers whose name starts with 'B' and who have only one account.

select c.first, c.last from customer c, owns where c.cid = owns.cid and c.last like 'B%' and c.cid in (select owns.cid from owns 
group by owns.cid
having count(owns.cid) = 1);

-- Q10 Number of different accounts.

select count(distinct num) from account;


-- Q11 First name, last name and money of customer that have over 400,000 in all of their account combined. Order by total account balance descending.


select customer.first, customer.last, sum(account.balance) from account, owns, customer where account.num = owns.num and owns.cid = customer.cid and owns.cid in (select owns.cid from account, owns where account.num = owns.num
group by owns.cid having sum(account.balance)>400000)
group by (owns.cid, customer.first, customer.last)  order by sum(account.balance) DESC;

-- Q12 Branch name and number of (distinct) customers in that branch. Order by branch name.

select b.name, count(distinct o.cid) from branch b, account a, owns o
where b.bid = a.bid and a.num = o.num
group by b.name order by b.name;

-- Q13 First name, last name and money of the richest customer. Note that customers may have more than one account, all accounts must be considered in finding the richest customer.

select * from (select customer.first, customer.last, sum(account.balance) as money from account, owns, customer where account.num = owns.num and owns.cid = customer.cid 
group by (owns.cid,customer.first, customer.last)  order by sum(account.balance) DESC) sub limit 1;

