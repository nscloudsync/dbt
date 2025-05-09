-- models/stg_departments.sql
{{
	config(
		materialized = 'table',
		tags = ['stg']
	)
}}

SELECT
    department_id,
    department_name,
    manager_id,
    location_id,
		CURRENT_TIMESTAMP AS load_time
FROM {{ source('hr','src_departments') }}
WHERE department_id IS NOT NULL