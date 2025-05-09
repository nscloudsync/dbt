{{
    config(
        materialized='table',
        database = 'DEV',
        schema = 'STG'
    )
}}

select
DEPARTMENT_ID,
DEPARTMENT_NAME,
MANAGER_ID,
LOCATION_ID,
LOAD_TIME
from {{ source('hr','src_departments') }}