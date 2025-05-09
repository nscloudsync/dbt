{{
    config(
        materialized='incremental',
        unique_key = 'employee_id',
        incremental_strategy = 'delete+insert',
        tags = ['dim'],
        schema = 'DIM'

    )
}}


select
EMPLOYEE_ID,
FIRST_NAME,
LAST_NAME,
EMAIL,
PHONE_NUMBER,
HIRE_DATE,
JOB_ID,
SALARY,
COMMISSION_PCT,
MANAGER_ID,
DEPARTMENT_ID,
current_timestamp LOAD_TIME
from {{ ref('stg_employees') }}

{% if is_incremental() %}

{{incr()}}

{% endif %}


