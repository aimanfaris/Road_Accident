select * 
from road_accident ra 

select sum(number_of_casualties) as total_korban_jiwa 
from road_accident ra 

select sum(number_of_casualties) as total_korban_jiwa 
from road_accident 
where accident_date like '%-2022' and accident_severity = 'Serious'

select cast(sum(number_of_casualties) as decimal (10,2)) * 100 / 
(select cast(sum(number_of_casualties) as decimal (10,2))from road_accident ra ) as percentage
from road_accident
where accident_severity ='Slight'

select 
case 
	when vehicle_type in ('Agricultural vehicle') then 'Agricultural'
	when vehicle_type in ('Car', 'Taxi/Private hire car') then 'Cars'
	when vehicle_type in ('Motorcycle 125cc and under', 'Motorcycle 50cc and under', 'Motorcycle  over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle' ) then 'Bike'
	when vehicle_type in ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') then 'Bus'
	when vehicle_type in ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t', 'Van / Goods 3 tones mgw or under') then 'Van'
	else 'other'
end as vehicle_group,
sum(number_of_casualties) as total_korban_jiwa 
from road_accident ra 
where accident_date like '%-2022'
group by 
case
	when vehicle_type in ('Agricultural vehicle') then 'Agricultural'
	when vehicle_type in ('Car', 'Taxi/Private hire car') then 'Cars'
	when vehicle_type in ('Motorcycle 125cc and under', 'Motorcycle 50cc and under', 'Motorcycle  over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle' ) then 'Bike'
	when vehicle_type in ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') then 'Bus'
	when vehicle_type in ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t', 'Van / Goods 3 tones mgw or under') then 'Van'
	else 'other'
end

select to_char(to_date(accident_date, 'dd-mm-yyyy'),'Month') as month_date, sum(number_of_casualties) as jumlah_korban 
from road_accident ra 
where accident_date like '%-2022'
group by month_date

select road_type, sum(number_of_casualties) as jumlah_korban
from road_accident 
where accident_date like '%-2022'
group by road_type

select urban_or_rural_area, sum(number_of_casualties) as jumlah_korban,
cast(sum(number_of_casualties) as decimal(10,2)) * 100 / 
(select cast(sum(number_of_casualties) as decimal(10,2)) from road_accident) as percentage
from road_accident
group by urban_or_rural_area

select 
case 
	when light_conditions in ('Daylight') then 'Day'
	when light_conditions in ('Darkness - lighting unknown', 
	'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') then 'Night'
	end as Light_conditions,
	cast(cast(sum(number_of_casualties) as decimal(10,2)) *100 /
	(select cast(sum(number_of_casualties) as decimal(10,2)) from 
	road_accident where accident_date like '%-2022') as decimal(10,2)) as percentage
from road_accident
where accident_date like '%-2022'
group by
case 
	when light_conditions in ('Daylight') then 'Day'
	when light_conditions in ('Darkness - lighting unknown', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') then 'Night'
end





