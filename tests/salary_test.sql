select * from {{ ref('stg_employees') }}
where salary < 0
or salary is null