{{
    config(
        materialized='incremental',
        unique_key = 'employee_id',
        incremental_strategy = 'delete+insert',
        tags = ['fct'],
        schema = 'fct'
    )
}}

{% set x = "(select coalesce(max(load_time),'1900-01-01') from "~this~") " %}

select 
    emp.EMPLOYEE_ID,
    jobs.JOB_ID,
    dept.department_id,
    loc.location_id,
    con.COUNTRY_ID,
    reg.region_id,
    SALARY_DATE,
    EMP.SALARY,
    HRA,
    ALLOWANCES,
    PF,
    (EMP.SALARY + HRA + ALLOWANCES + PF ) AS GROSS_SALARY,
     (EMP.SALARY + HRA + ALLOWANCES ) AS NET_SALARY,
    CURRENT_TIMESTAMP AS LOAD_TIME
FROM {{ ref('stg_salary') }} AS SAL
inner JOIN {{ ref('dim_employees') }} AS EMP
ON SAL.EMPLOYEE_ID = EMP.EMPLOYEE_ID
inner join {{ ref('dim_departments') }} as dept
on emp.department_id = dept.department_id
inner join {{ ref('dim_locations') }} as loc
on loc.location_id = dept.location_id
inner join {{ ref('dim_countries') }} as con
on con.country_id = loc.country_id
inner join {{ ref('dim_regions')}} as reg
on reg.region_id = con.region_id
inner join {{ ref('dim_jobs') }} as jobs
on jobs.job_id = emp.job_id

{% if is_incremental() %}

where SAL.load_time > {{x}}

or EMP.load_time > {{x}}

or dept.load_time > {{x}}

or loc.load_time > {{x}}

or con.load_time > {{x}}

or reg.load_time > {{x}}

or jobs.load_time > {{x}}

{% endif %}