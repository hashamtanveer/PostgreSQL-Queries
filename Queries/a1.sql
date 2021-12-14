-- Q1 Find all the distinct categories in the hall of fame table. Order alphabetically.

select distinct category 
from hall_of_fame 
order by category;

-- Q2 Find all people in the players table whose first name is 'Mariano'. Show the first and last name. Order by last name ascending.

select namefirst, namelast 
from players 
where namefirst = 'Mariano' 
order by namelast ASC;

-- Q3 Show the first and last names of all people in the players table born in Philadelphia whose first name is 'Frank'. Order by last name ascending.


select namefirst, namelast 
from players 
where birthcity = 'Philadelphia' and  namefirst = 'Frank' 
order by namelast ASC;


-- Q4 Find all people in the players table whose last name starts with "DiM". Show the first name, last name, birth year and death year.

select namefirst, namelast, birthyear, deathyear 
from players 
where namelast like 'DiM%';

-- Q5 Find all people in the players table whose last name starts with 'DiM' and who are still alive. Show the first name, last name and birth year.


select namefirst, namelast, birthyear 
from players 
where namelast like 'DiM%' and deathyear is NULL;


-- Q6 Find all different countries starting with 'G' where people in the players table were born. Order the countries alphabetically.


select distinct birthcountry 
from players 
where birthcountry like 'G%' order by birthcountry;

-- Q7 Find all players inducted to the hall of fame who were born in Venezuela. Show the first name, last name, birth country and year inducted to the hall of fame. Order by last name.


select p.namefirst, p.namelast, p.birthcountry, h.yearid
from players p, hall_of_fame h
where p.playerid = h.playerid and p.birthcountry = 'Venezuela' and h.category = 'Player'
order by p.namelast;


-- Q8 Find all the countries from which players were inducted to the hall of fame. Order by country name.

select distinct p.birthcountry
from players p, hall_of_fame h
where h.playerid = p.playerid and h.category = 'Player'
order by p.birthcountry;


-- Q9 Find all different people in the players table born in Mexico that were considered for the hall of fame but were not inducted. Show the people's first and last name. Order by last name.

select p.namefirst, p.namelast
from players p
where p.birthcountry = 'Mexico'  and (p.playerid not in (select h.playerid 
														from hall_of_fame h))  
order by p.namelast;

-- Q10 Find the first and last name of umpires inducted to the hall of fame. Show first and last name. Order by last name.

select p.namefirst, p.namelast
from players p, hall_of_fame h 
where h.playerid = p.playerid and h.category = 'Umpire'  
order by p.namelast;


