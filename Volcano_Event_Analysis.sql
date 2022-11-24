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

1. Provinsi mana yang paling banyak memiliki letusan gunungapi 

## Melihat total erupsi di setiap pulau di Indonesia
select 
	island,
	count(erupt_date) as total_erupt
from volcanoevent v 
group by island
order by total_erupt desc

## Melihat Gunung yang aktif di Pulau Jawa ##
select 
	distinct name_volcano
from volcanoevent v 
where island = 'Java'

## Melihat gunungapi yang memiliki letusan terbanyak di Pulau Jawa ##
with volcanE as
	(select 
		year,
		name_volcano,
		island,
		count(erupt_date) as total_erupt,
		vei
	from volcanoevent v 
	where island = 'Java'
	)
select 
	island,
	total_erupt
from volcanE
group by island
order by vei desc

2. Gunungapi apa saja yang letusannya yang diikuti oleh tsunami dan gempabumi  
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

with vulcan as 
	(select 
		year,
		name_volcano,
		island,
		count(tsunami) as total_tsunami,
		count(gempabumi) as total_gempabumi
	from volcanoevent v 
	where 
		tsunami is not null or 
		gempabumi is not null
	group by name_volcano 
	order by total_tsunami desc
	)
select 
	name_volcano,
	total_tsunami,
	total_gempabumi
from vulcan

3. Letusan gunungapi yang memiliki paling banyak letusan dengan jumlah korban terbanyak dilihat dari injuries dan deathh 
select
	name_volcano,
	erupt_date,
	deaths,
	injuries
from volcanoevent v 
where name_volcano = 'Kelut'
order by year asc

with volcan as 
	(select 
		year,
		location,
		name_volcano,
		count(erupt_date) as total_erupt,
		count(deaths) as total_mati,
		count(injuries) as total_injuries 
	from volcanoevent v 
	group by name_volcano 
	order by total_mati desc
	)
select 
	name_volcano,
	total_erupt,
	total_mati,
	total_injuries
from volcan


