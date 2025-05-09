{% macro inc() %}

where load_time > (
    select coalesce(max(load_time),'1900-01-01 00:00:00')
    from {{ this }}
)

{% endmacro %}