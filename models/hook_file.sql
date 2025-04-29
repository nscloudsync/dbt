{{
    config(
        materialized='incremental',
        unique_key = 'EMPLOYEE_ID',

        pre_hook = ["
        insert into hr.audit_log(
            model_name,
            run_id,
            start_time,
            end_time,
            run_by_user
        )
        values(
            'stg_employees',
            '{{ invocation_id }}',
            current_timestamp,
            null,
            current_user
        )
        "],

        post_hook = ["
                update hr.audit_log
                set end_time = current_timestamp
                where model_name = 'stg_employees'
                and run_id = '{{ invocation_id }}'
        "]
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
    current_timestamp as LOAD_TIME
from {{ source('hr', 'src_employees') }}


