create or replace function fn_get_rate_power(i_val number,o_unit out varchar2) return number is
--???¨´?£¿?£¿£¿£¿£¿???¦Ë,£¿£¿??¦ËW
begin
  if (i_val < 1000 or i_val is null) then
     o_unit:='W';
          return 1;
  elsif (i_val<1000*1000) then
     o_unit:='KW';
          return 1000;
  else
     o_unit:='MW';
     return      1000000;
  end if;
end fn_get_rate_power;
/

