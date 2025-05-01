{{ 
    config(
        materialized='table'
    ) 
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['employee_id', 'first_name']) }} as surrogate_key,
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    manager_id,
    department_id,
    CURRENT_TIMESTAMP AS load_time
FROM hr.src_employees as src