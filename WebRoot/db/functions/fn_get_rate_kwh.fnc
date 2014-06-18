create or replace function fn_get_rate_kwh(i_val number,o_unit out varchar2) return varchar2 is
--???¡Â??²Ó?£¿£¿£¿£¿???¦Ë,£¿£¿KWh
begin
  if (i_val < 1000) then
     o_unit:='KWh';
     return 1;
  elsif (i_val<1000000) then
     o_unit:='MWh';
     return 1000;
  elsif(i_Val<1000000000) then
     o_unit:='GWh';
     return 1000000;
  else
    o_unit:='TWH';
    return 1000000000;
  end if;
end fn_get_rate_kwh;
/

