-- models/fct_salary.sql

{{
    config(
        materialized='incremental',
        unique_key = 'employee_id',
        incremental_strategy = 'delete+insert',
        tags = ['fct']
    )
}}

{% set max_load_time = 
"(select coalesce(max(load_time),'1900-01-01 00:00:00') 
from "~ this ~" )" %}

SELECT
    emp.employee_id,
    emp.job_id,
    emp.department_id,
    dept.location_id,
    loc.country_id,
    country.region_id,
    sal.salary_date,
    emp.salary as basic_salary,
    sal.hra,
    sal.allowances,
    sal.pf,
    (emp.salary +  sal.hra + sal.allowances + sal.pf) as gross_salary,
    (emp.salary + sal.hra + sal.allowances) as net_salary,
    CURRENT_TIMESTAMP AS load_time
FROM {{ ref('stg_salary') }} as sal
JOIN {{ ref('dim_employees') }} as emp 
ON sal.employee_id = emp.employee_id 
JOIN {{ ref('dim_departments') }} as dept 
ON emp.department_id = dept.department_id
JOIN {{ ref('dim_jobs') }} as job 
ON emp.job_id = job.job_id
JOIN {{ ref('dim_locations') }} as loc 
ON dept.location_id = loc.location_id
JOIN {{ ref('dim_countries') }} as country 
ON loc.country_id = country.country_id
JOIN {{ ref('dim_regions') }} as region 
ON country.region_id = region.region_id

{% if is_incremental() %}

where sal.load_time > {{ max_load_time }}

or emp.load_time > {{ max_load_time }}

or dept.load_time > {{ max_load_time }}

or job.load_time > {{ max_load_time }}

or country.load_time > {{ max_load_time }}

or region.load_time > {{ max_load_time }}

{% endif %}