create or replace function fn_get_unit_w(i_val number) return varchar2 is
--???¡Â??²Ó?£¿£¿£¿£¿???¦Ë,£¿£¿KWh
begin
  if (i_val < 1000 or i_val is null) then
     return 'W';
  elsif (i_val<1000000) then
     return 'KW';
  elsif(i_Val<1000000000) then
     return 'MW';
  else
    return'TW';
  end if;
end fn_get_unit_w;
/

