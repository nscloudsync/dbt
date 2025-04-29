{% macro test_not_null(model, column) %}

    SELECT {{column}}
    FROM {{ref(model)}}
    WHERE {{column}} IS NULL 

{% endmacro %}