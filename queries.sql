-- 1. Total Patients
select count(*) from data; - 55500

-- 2. Age group with highest admission
select
age_group,
count(*) as total_patients
from data 
group by age_group
order by total_patients desc; 

-- 3. Gender distribution of patients
select 
gender,
count(*) as total_patients
from data
group by gender
order by total_patients desc

-- 4. Most common medical condition by gender
select gender,medical_condition,total_patients from
(select 
gender,
medical_condition,
count(*) as total_patients,
row_number() over(partition by gender order by count(*) desc) as rn
from data
group by gender,medical_condition
order by total_patients desc) 
where rn = 1;

-- 5. Total and Average Billing by gender
select
gender,
round(sum(billing_amount)::numeric,2) as total_bill,
round(avg(billing_amount)::numeric,2) as average_bill,
round(min(billing_amount)::numeric,2) as minimum_bill,
round(max(billing_amount)::numeric,2) as maximum_bill
from data
group by gender
order by total_bill desc;

-- 6. Distribution of blood groups in patients
select
blood_type,count(*) as total_patients from data
group by blood_type
order by total_patients desc;

-- 7. blood group vs. medical conditions
select 
blood_type,medical_condition,total_patients
from(
select blood_type,medical_condition,
count(*) as total_patients,
row_number() over (partition by blood_type order by count(*) desc) as rn
from data
group by blood_type,medical_condition
)
where rn = 1 order by total_patients desc;

-- 8. Top most common condition
select
medical_condition,
count(*) as total_patients
from data
group by medical_condition
order by total_patients desc;

-- 9. Costlist Condition
select
medical_condition,
count(*) as total_patients,
round(sum(billing_amount)::numeric,2) as total_amount
from data
group by medical_condition
order by total_amount desc;

-- 10. Total admission trends over yearly
select 
extract(YEAR from date_of_admission) as year,
count(*) as total_patients
from data
group by year
order by year desc;

-- 11. Total admission trends over previous year months
select 
to_char(date_of_admission, 'Month') as months,
count(*) as total_patients
from data
where extract(year from date_of_admission) = 2023
group by months
order by total_patients desc;

-- 12. Top 5 best doctor 
select 
doctor,
count(*) as total_patients
from data
group by doctor
order by total_patients desc
limit 5;

-- 13. Average billing of top 5 doctor
select 
doctor,
round(avg(billing_amount)::numeric,2) as avg_amount
from data
group by doctor
order by avg_amount desc
limit 5;

-- 14. Top 5 Hospital with highest patient load or revenue
select 
hospital,
count(*) as total_patients,
round(sum(billing_amount)::numeric,2) as total_amount
from data 
group by hospital
order by total_patients desc
limit 5;

-- 15. 

