create or replace function fn_get_unit_yield(i_val number,i_unit varchar2) return varchar2 is
begin
  /*if i_unit = '$' then
    if i_val<1000 then
         return i_unit;
     elsif i_val < 1000000 then
         return 'k'||i_unit;
     else
         return 'm'||i_unit;
     end if;
--  else
  end if;*/
  return i_unit;
end fn_get_unit_yield;
/

