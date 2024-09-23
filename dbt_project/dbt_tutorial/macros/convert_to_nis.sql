
{%macro dollaers_to_nis(column_name,scale=2)%}
round(({{column_name}} *3.8),{{scale}}),2
{%endmacro%}