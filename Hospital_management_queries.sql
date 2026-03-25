create database Hospital;
use Hospital;
show tables;
select * from appointments limit 5;
select * from billing limit 5;
select * from doctors limit 5;
select * from patients limit 5;
select * from treatments limit 5;
describe appointments;
describe billing;
describe doctors;
describe patients;
describe treatments;
select * from appointments
where appointment_id is null
   or patient_id is null
   or doctor_id is null
   or appointment_date is null
   or appointment_time is null
   or reason_for_visit is null
   or status is null;
select * from billing
where bill_id is null
   or patient_id is null
   or treatment_id is null
   or bill_date is null
   or amount is null
   or payment_method is null
   or payment_status is null;
select * from doctors
where doctor_id is null
   or first_name is null
   or last_name is null
   or specialization is null
   or phone_number is null
   or years_experience is null
   or hospital_branch is null
   or email is null;
select * from doctors
where doctor_id is null
   or first_name is null
   or last_name is null
   or specialization is null
   or phone_number is null
   or years_experience is null
   or hospital_branch is null
   or email is null;
select * from patients
where patient_id is null
   or first_name is null
   or last_name is null
   or gender is null
   or date_of_birth is null
   or contact_number is null
   or address is null
   or registration_date is null
   or insurance_provider is null
   or insurance_number is null
   or email is null;
select * from treatments
where treatment_id is null
   or appointment_id is null
   or treatment_type is null
   or description is null
   or cost is null
   or treatment_date is null;
SELECT appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit, status, count(*)
FROM appointments
GROUP BY appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit, status
HAVING COUNT(*) > 1;
SELECT doctor_id, first_name, last_name, specialization, phone_number, years_experience, hospital_branch, email, count(*)
FROM doctors
GROUP BY doctor_id, first_name, last_name, specialization, phone_number, years_experience, hospital_branch, email
HAVING COUNT(*) > 1;
SELECT patient_id, first_name, last_name, gender, date_of_birth, contact_number, address, registration_date, insurance_provider, insurance_number, email, count(*)
FROM patients
GROUP BY patient_id, first_name, last_name, gender, date_of_birth, contact_number, address, registration_date, insurance_provider, insurance_number, email
HAVING COUNT(*) > 1;
SELECT treatment_id, appointment_id, treatment_type, description, cost, treatment_date, count(*)
FROM treatments
GROUP BY treatment_id, appointment_id, treatment_type, description, cost, treatment_date
HAVING COUNT(*) > 1;
alter table appointments
modify appointment_date date,
modify appointment_time time,
modify appointment_id varchar(10),
modify patient_id varchar(10),
modify doctor_id varchar(10);
alter table billing
modify bill_date date,
modify bill_id varchar(10),
modify treatment_id varchar(10),
modify patient_id varchar(10);
alter table doctors
modify doctor_id varchar(10);
alter table patients
modify date_of_birth date,
modify registration_date date,
modify patient_id varchar(10);
alter table treatments
modify treatment_date date,
modify treatment_id varchar(10),
modify appointment_id varchar(10);
desc appointments;
desc billing;
desc doctors;
desc patients;
desc treatments;

-- Add primary keys
alter table appointments
add primary key (appointment_id);
alter table billing
add primary key (bill_id);
alter table doctors
add primary key (doctor_id);
alter table patients
add primary key (patient_id);
alter table treatments
add primary key (treatment_id);

-- Add foreign keys
alter table appointments
add constraint fk_patient
foreign key (patient_id)
references patients(patient_id);
alter table appointments
add constraint fk_patient
foreign key (patient_id)
references patients(patient_id);
alter table appointments
add constraint fk_doctor
foreign key (doctor_id)
references doctors(doctor_id);
alter table billing
add constraint fk_billing_patient
foreign key (patient_id)
references patients(patient_id);
alter table treatments
add constraint fk_treatment_appointment
foreign key (appointment_id)
references appointments(appointment_id);
select table_name, column_name, referenced_table_name, referenced_column_name
from information_schema.key_column_usage
where table_schema = "hospital"
and referenced_table_name is not null;
select count(*) as "total_appointments"
from appointments;
select count(*) as "Total_billing"
from billing;
select count(*) as "Total_doctors"
from doctors;
select count(*) as "Total_patients"
from patients;
select count(*) as "Total_treatments"
from treatments;
select doctor_id, count(*) as total_appointments
from appointments
group by doctor_id;
select doctor_id, count(*) as appointments
from appointments
group by doctor_id
order by appointments desc;
select patient_id, count(*) as visits
from appointments
group by patient_id
order by visits desc;
select sum(amount) as Total_Revenue
from billing;
select payment_method, sum(amount) as Revenue
from billing
group by payment_method;
select treatment_type, count(*) as total
from treatments
group by treatment_type
order by total desc;

-- Monthly appointments
select month(appointment_date) as month, count(*) as total_appointments
from appointments
group by month;
drop view hospital_management;
drop view hospital_management;

-- joins the tables
create view hospital_management as
select 
-- Appointments
a.appointment_id,
a.appointment_date,
a.appointment_time,
a.reason_for_visit,
a.status,
-- Patients
p.patient_id,
p.first_name as p_first_name,
p.last_name as p_last_name,
p.gender,
p.date_of_birth,
p.contact_number,
p.address,
p.registration_date,
p.insurance_provider,
p.insurance_number,
p.email as p_email,
-- Doctors
d.doctor_id, 
d.first_name as d_first_name,
d.last_name as d_last_name,
d.specialization,
d.phone_number,
d.years_experience,
d.hospital_branch,
d.email as d_email,
-- Treatments
t.treatment_id,
t.treatment_type,
t.description,
t.cost,
t.treatment_date,
-- Billing
b.bill_id,
b.amount,
b.payment_status,
b.payment_method
from appointments a 
left join patients p
on a.patient_id = p.patient_id
left join doctors d
on a.doctor_id = d.doctor_id
left join treatments t  
on a.appointment_id = t.appointment_id
left join billing b
on p.patient_id = b.patient_id;
select * from hospital_management;

-- Check NULL values
select *
from hospital_management
where appointment_id is null 
or appointment_date is null
or appointment_time is null
or reason_for_visit is null
or status is null
or patient_id is null
or p_first_name is null
or p_last_name is null
or gender is null
or date_of_birth is null
or contact_number is null
or address is null
or registration_date is null
or insurance_provider is null
or insurance_number is null
or p_email is null
or doctor_id is null
or d_first_name is null
or d_last_name is null
or specialization is null
or phone_number is null
or years_experience is null
or hospital_branch is null
or d_email is null
or treatment_id is null
or treatment_type is null
or description is null
or cost is null
or treatment_date is null
or bill_id is null
or amount is null
or payment_status is null
or payment_method is null;

-- Check Duplicates
select
appointment_id, 
appointment_date,
appointment_time,
reason_for_visit, 
status, 
patient_id, 
p_first_name, 
p_last_name, 
gender, 
date_of_birth, 
contact_number, 
address, 
registration_date, 
insurance_provider, 
insurance_number, 
p_email, 
doctor_id, 
d_first_name, 
d_last_name, 
specialization, 
phone_number, 
years_experience, 
hospital_branch, 
d_email, 
treatment_id, 
treatment_type,
description, 
cost,
treatment_date, 
bill_id, 
amount, 
payment_status, 
payment_method,
COUNT(*) AS duplicate_count
FROM hospital_management
GROUP BY 
appointment_id, 
appointment_date,
appointment_time,
reason_for_visit, 
status, 
patient_id, 
p_first_name, 
p_last_name, 
gender, 
date_of_birth, 
contact_number, 
address, 
registration_date, 
insurance_provider, 
insurance_number, 
p_email, 
doctor_id, 
d_first_name, 
d_last_name, 
specialization, 
phone_number, 
years_experience, 
hospital_branch, 
d_email, 
treatment_id, 
treatment_type,
description, 
cost,
treatment_date, 
bill_id, 
amount, 
payment_status, 
payment_method
having count(*) >1;

-- Check invalid data
select *
from hospital_management
where amount <= 0;
select *
from hospital_management
where appointment_date  > CURDATE();

select status, count(*) as total_appointments
 from hospital_management
group by status;

-- Total Revenue
select sum(amount) as total_revenue
from hospital_management;

-- Revenue by Doctor
select doctor_id, d_first_name, sum(amount) as revenue
from hospital_management
group by doctor_id;

-- Total patients
select count(distinct patient_id) as total_patients
from hospital_management;

-- patients by gender
select gender, count(*) as total
from hospital_management
group by gender;

-- total appointments per doctor
select doctor_id, count(*) as total_appointments
from hospital_management
group by doctor_id;

-- Top 5 doctors
select doctor_id, count(*) as total_patients
from  hospital_management
group by  doctor_id
order by total_patients desc
limit 5;

-- Monthly Revenue
select month(appointment_date) as month, sum(amount) as revenue
from hospital_management
group by month(appointment_date);

-- Most common treatment
select treatment_type, count(*) as total
from hospital_management
group by treatment_type;

-- Top city by patient count
select address, count(*) as total_patients
from hospital_management
group by address
order by total_patients desc;
select * from hospital_management;

-- Business insights
-- 1.D009 doctor contributes the maximum revenue to the hospital income.alter
-- 2.Chemotherapy is not the most common treatment, indicating lower oncology demand and higher reliance on general medical services.
-- 3.Higher health issues among male population.
-- 4.D009 doctor handled the most of the patients and high demand doctor.
-- 5. August month generate highest revenue to the hospital, due to disease seasonal month.
-- 6. "Maple" city has highest number of patients to compare other cities.
