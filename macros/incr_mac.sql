{% macro incr() %}

where load_time > (select coalesce(max(load_time),'1900-01-01') from {{this}})

{% endmacro %}