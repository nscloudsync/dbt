{% macro multi_caps(a,b) %}

    {% set col = [a,b] %}

    {% for columns in col %}

        upper( {{columns}} ),

    {% endfor %}

{% endmacro %}