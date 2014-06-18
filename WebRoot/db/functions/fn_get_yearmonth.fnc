create or replace function fn_get_yearmonth(
i_year number,
i_month number,
i_val number) return varchar2 is
begin
    if i_val>i_month  then
       return (i_year-1)||'-'||to_char(i_val,'fm00');
    else
       return i_year||'-'||to_char(i_val,'fm00');
    end if;
end fn_get_yearmonth;
/

