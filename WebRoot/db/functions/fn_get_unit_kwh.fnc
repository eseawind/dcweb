create or replace function fn_get_unit_kwh(i_val number) return varchar2 is
--???¡Â??²Ó?£¿£¿£¿£¿???¦Ë,£¿£¿KWh
begin
  if (i_val < 1000 or i_val is null) then
     return 'KWh';
  elsif (i_val<1000000) then
     return 'MWh';
  elsif(i_Val<1000000000) then
     return 'GWh';
  else
    return'TWH';
  end if;
end fn_get_unit_kwh;
/

