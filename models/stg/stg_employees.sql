-- models/stg_employees.sql
{{
	config(
		materialized = 'table',
		tags = ['stg']
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
FROM {{ source('hr','src_employees') }}
WHERE salary IS NOT NULL