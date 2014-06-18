create or replace function fn_get_unit_weight(i_val number) return varchar2 is
--???£¿£¿??£¿£¿£¿???¦Ë??£¿£¿£¿,£¿£¿Kg
begin
  if (i_val < 1000 or i_val is null) then
     return 'Kg';
  else
     return 'T';
  end if;
end fn_get_unit_weight;
/

