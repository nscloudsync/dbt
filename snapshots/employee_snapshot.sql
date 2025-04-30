{% snapshot employee_snapshot %}

{{
    config(
        target_schema = 'dev',
        unique_key = 'EMPLOYEE_ID',
        strategy = 'timestamp',
        updated_at = 'load_time',
        invalidate_hard_deletes = true
    )

}}

select 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    load_time
from {{ source('hr', 'src_employees') }}



{% endsnapshot %}