{{
    config(
        materialized = 'incremental',
        unique_key = 'EMPLOYEE_ID',
        incremental_strategy = 'insert_overwrite',
        partition_by = {'field': 'load_time', 'data_type':'timestamp'}
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
    MANAGER_ID,
    DEPARTMENT_ID,
    current_timestamp as LOAD_TIME
from {{ source('hr', 'src_employees') }} as src

{% if is_incremental() %}

where src.load_time >= dateadd(day, -7, current_timestamp)

{% endif %}