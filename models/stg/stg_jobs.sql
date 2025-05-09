-- models/stg_jobs.sql
{{
	config(
		materialized = 'table',
		tags = ['stg']
	)
}}

SELECT
    job_id,
    job_title,
    min_salary,
    max_salary,
    CURRENT_TIMESTAMP AS load_time
FROM {{ source('hr','src_jobs') }}
WHERE job_id IS NOT NULL