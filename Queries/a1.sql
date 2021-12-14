-- Q1

select distinct category 
from hall_of_fame 
order by category;

-- Q2

select namefirst, namelast 
from players 
where namefirst = 'Mariano' 
order by namelast ASC;

-- Q3

select namefirst, namelast 
from players 
where birthcity = 'Philadelphia' and  namefirst = 'Frank' 
order by namelast ASC;


-- Q4

select namefirst, namelast, birthyear, deathyear 
from players 
where namelast like 'DiM%';

-- Q5

select namefirst, namelast, birthyear 
from players 
where namelast like 'DiM%' and deathyear is NULL;


-- Q6

select distinct birthcountry 
from players 
where birthcountry like 'G%' order by birthcountry;

-- Q7

select p.namefirst, p.namelast, p.birthcountry, h.yearid
from players p, hall_of_fame h
where p.playerid = h.playerid and p.birthcountry = 'Venezuela' and h.category = 'Player'
order by p.namelast;


-- Q8

select distinct p.birthcountry
from players p, hall_of_fame h
where h.playerid = p.playerid and h.category = 'Player'
order by p.birthcountry;


-- Q9

select p.namefirst, p.namelast
from players p
where p.birthcountry = 'Mexico'  and (p.playerid not in (select h.playerid 
														from hall_of_fame h))  
order by p.namelast;

-- Q10

select p.namefirst, p.namelast
from players p, hall_of_fame h 
where h.playerid = p.playerid and h.category = 'Umpire'  
order by p.namelast;


