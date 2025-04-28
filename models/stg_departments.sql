{{
    config(materialized='table')
}}

select * from {{ source('hr','departments') }}