{{ 
    config(
        target_schema = 'stg',
        materialized='incremental', 
        unique_key='employee_id'
    ) 
}}

SELECT
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
FROM hr.employees as src