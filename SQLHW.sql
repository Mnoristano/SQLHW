use sakila;

#1a.
select
first_name, last_name 
from 
actor;

#1b.
select 
concat(first_name,' ', last_name) as 'Actor Name'
from
actor;

#2a.
select 
actor_id, first_name, last_name 
from
actor
where
first_name = 'Joe';

#2b.
select
* 
from 
actor
where 
last_name like '%GEN%';

#2c.
select 
* 
from 
actor
where
last_name like '%LI%'
order by
last_name, first_name;

#2d.
select 
country_id, country
from 
country
where
country in ('Afghanistan', 'Bangladesh', 'China');

#3a.
ALTER TABLE actor
ADD COLUMN  description BLOB;

#3b.
ALTER TABLE actor
DROP COLUMN description;

#4a.
select
last_name, count(last_name) as 'Count of Names'
from 
actor
group by 
last_name;

#4b.
select
last_name, count(last_name) as 'Count of Names'
from 
actor
group by 
last_name
having 
count(last_name) >= 2;

#4c.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' and last_name = 'WILLIAMS';

#4d.
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

#5a.
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'address';

#5a.
show create table address;

#6a.
select 
s.first_name, s.last_name, ad.address
from
staff s
join 
address ad 
on
s.address_id = ad.address_id;

#6b.
select
s.first_name, s.last_name, sum(p.amount) as 'Total Rung'
from 
staff s 
join
payment p
on 
s.staff_id = p.staff_id
where
p.payment_date 
between '2005-08-01 00:00:00' and '2005-08-31 23:59:59'
group by 
s.first_name, s.last_name;

#6c.
select 
f.title, count(fa.actor_id) as '# of actors'
from
film f
inner join
film_actor fa 
on
fa.film_id = f.film_id
group by 
f.title;

#6d.
select 
count(*) as '# in iventory' 
from 
inventory 
where 
film_id in
(select film_id from film where title = 'Hunchback Impossible');

#6e.
select 
c.first_name, c.last_name, sum(p.amount) as 'Total Amount Paid' 
from  
customer c
join
payment p
on
c.customer_id = p.customer_id
group by
c.first_name, c.last_name
order by
c.last_name, sum(p.amount);

#7a.
select title 
from 
film
where 
(title LIKE 'K%'
or title LIKE 'Q%')
and
language_id
in (select language_id from language where name = 'English');

#7b.
select
first_name, last_name
from 
actor
where 
actor_id in 
(select actor_id from film_actor where film_id in
(select film_id from film where title = 'Alone Trip'));

#7c.
select
first_name, last_name, email 
from 
customer
where 
address_id in
(select address_id from address where city_id in
(select city_id from city where country_id in 
(select country_id from country where country = 'Canada')));

#7d.
select
title 
from 
film
where 
film_id in 
(select film_id from film_category where category_id in 
(select category_id from category where name = 'Family'));

#7e.
select 
f.title, count(r.rental_id) as '# of rentals'
from
rental r 
join 
inventory i 
on i.inventory_id = r.inventory_id
join
film f 
on i.film_id = f.film_id
group by f.title
order by count(r.rental_id) desc;

#7f.
select 
store.store_id, sum(p.amount) as 'Business brought in'
from 
store 
join 
payment p
on
store.manager_staff_id = p.staff_id
group by store.store_id;

#7g.
select 
s.store_id, c.city, cn.country
from 
store s
join 
address a 
on 
a.address_id = s.address_id
join
city c
on 
c.city_id = a.city_id
join
country cn
on
cn.country_id = c.country_id;

#7h.
select 
c.name, sum(p.amount) as 'Gross Revenue'
from 
category c
join
film_category fc
on
c.category_id = fc.category_id
join
inventory i 
on
fc.film_id = i.film_id
join
rental r
on
i.inventory_id = r.inventory_id
join
payment p 
on p.rental_id = r.rental_id
group by 
c.name
order by 
sum(p.amount) desc
limit 5;

#8a.
create view TopCategories as

select 
c.name, sum(p.amount) as 'Gross Revenue'
from 
category c
join
film_category fc
on
c.category_id = fc.category_id
join
inventory i 
on
fc.film_id = i.film_id
join
rental r
on
i.inventory_id = r.inventory_id
join
payment p 
on p.rental_id = r.rental_id
group by 
c.name
order by 
sum(p.amount) desc
limit 5;

#8b.
select 
* 
from 
TopCategories;

#8c.
DROP VIEW TopCategories;