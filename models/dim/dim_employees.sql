-- models/dim_employees.sql

{{
    config(
        materialized='incremental',
        unique_key = 'employee_id',
        incremental_strategy = 'delete+insert',
        tags = ['dim']
    )
}}

SELECT
    employee_id,
    first_name,
    last_name,
    email AS email,
    phone_number,
    hire_date,
    job_id,
    salary,
    manager_id,
    department_id,
    CURRENT_TIMESTAMP AS load_time
FROM {{ ref('stg_employees') }}

{% if is_incremental() %}

{{ inc() }}

{% endif %}