-- models/stg_countries.sql
{{
	config(
		materialized = 'table',
		tags = ['stg']
	)
}}

SELECT
    country_id,
    country_name,
    region_id,
    CURRENT_TIMESTAMP AS load_time
FROM {{ source('hr','src_countries') }}
WHERE country_id IS NOT NULL
