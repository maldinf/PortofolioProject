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
## Membagi setiap gunung terhadap provinsinya masing masing
select 
	case
		when name_volcano = 'Sinabung' then 'Sumatra Utara'
		when name_volcano = 'Kraktau' then 'Lampung'
		when name_volcano in ('Cereme', 'Papandayan', 'Galunggung', 'Tangkuban Parahu', 'Salak') then 'Jawa Barat'
		when name_volcano in ('Dieng Volcanic Complex', 'Merapi') then 'Jawa Tengah'
		when name_volcano in ('Ijen', 'Semeru', 'Raung', 'Kelut', 'Lamongan', 'Semeru', 'Tengger Caldera') then 'Jawa Timur'
		when name_volcano in ('Awu', 'Ruang', 'Banua Wuhu', 'Karangetang', 'Lokon-Empung', 'Soputan', 'Mahawu') then 'Sulawesi Utara'
		when name_volcano = 'Colo' then 'Sulawesi Tengah'
		when name_volcano in ('Dukono', 'Gamkonora', 'Gamalama', 'Makian') then 'Maluku Utara'
		when name_volcano = 'Wurlali' then 'Banda'
		when name_volcano in ('Tambora', 'Rinjani') then 'Nusa Tenggara Barat'
		when name_volcano in ('Agung', 'Batur')  then 'Bali'
		else 'Nusa Tenggara Timur'
	end as provinsi_pernama_gunung,
	count(erupt_date) as total_eruptdate
from volcanoevent v
group by provinsi_pernama_gunung
order by total_eruptdate desc

## Melihat sejarah erupsi gunungapi yang berada di Jawa Timur##
with vulcanEr as
	(select 
		name_volcano,
		erupt_date,
		case
			when name_volcano = 'Sinabung' then 'Sumatra Utara'
			when name_volcano = 'Kraktau' then 'Lampung'
			when name_volcano in ('Cereme', 'Papandayan', 'Galunggung', 'Tangkuban Parahu', 'Salak') then 'Jawa Barat'
			when name_volcano in ('Dieng Volcanic Complex', 'Merapi') then 'Jawa Tengah'
			when name_volcano in ('Ijen', 'Semeru', 'Raung', 'Kelut', 'Lamongan', 'Semeru', 'Tengger Caldera') then 'Jawa Timur'
			when name_volcano in ('Awu', 'Ruang', 'Banua Wuhu', 'Karangetang', 'Lokon-Empung', 'Soputan', 'Mahawu') then 'Sulawesi Utara'
			when name_volcano = 'Colo' then 'Sulawesi Tengah'
			when name_volcano in ('Dukono', 'Gamkonora', 'Gamalama', 'Makian') then 'Maluku Utara'
			when name_volcano = 'Wurlali' then 'Banda'
			when name_volcano in ('Tambora', 'Rinjani') then 'Nusa Tenggara Barat'
			when name_volcano in ('Agung', 'Batur')  then 'Bali'
			else 'Nusa Tenggara Timur'
		end as provinsi_pernama_gunung
	from volcanoevent v )
select *
from vulcanEr
where provinsi_pernama_gunung = 'Jawa Timur'
order by erupt_date 

2. Gunungapi apa saja yang letusannya yang diikuti oleh tsunami dan gempabumi  
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
		sum(deaths) as total_mati,
		sum(injuries) as total_injuries 
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
limit 10


