select *
from volcanoevent v 

##  DATA CLEANING  ##

alter table volcanoevent
drop column missing,
drop column missing_description,
drop column injuries_description,
drop column death_description,
drop column damage_mil,
drop column damage_description,
drop column houses_destroyed,
drop column houses_destroyed_description,
drop column total_death_description,
drop column total_missing_description,
drop column total_injuries_description,
drop column total_damage_mil,
drop column total_damage_description,
drop column total_houses_destroyed,
drop column total_houses_destroyed_description

##  Provinsi mana yang paling banyak memiliki letusan gunungapi  ##
select 
	distinct(name_volcano)
from volcanoevent v 
where island = 'Nusa Tenggara'

select 
	year,
	erupt_date,
	name_volcano,
	island
from volcanoevent v 
where island = 'Nusa Tenggara'

select 
	island,
	count(erupt_date) as total_erupt,
	max(vei) as max_vei
from volcanoevent v 
group by island
order by max_vei desc

##  Gunungapi apa saja yang letusannya yang diikuti oleh tsunami dan gempabumi  ##
select 
	year,
	location,
	name_volcano,
	count(tsunami) as total_tsunami,
	count(gempabumi) as total_gempabumi
from volcanoevent v 
where 
	tsunami is not null or 
	gempabumi is not null
group by name_volcano 
order by total_tsunami desc

##  Letusan gunungapi yang memiliki paling banyak letusan dengan jumlah korban terbanyak dilihat dari injuries dan deathh  ##
select
	name_volcano,
	erupt_date
from volcanoevent v 
where name_volcano = 'Merapi'

select 
	year,
	location,
	name_volcano,
	count(erupt_date) as total_erupt,
	count(deaths) as total_mati,
	count(injuries) as total_injuries 
from volcanoevent v 
group by name_volcano 
order by total_mati desc

