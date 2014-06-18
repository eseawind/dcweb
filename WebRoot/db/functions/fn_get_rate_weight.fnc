create or replace function fn_get_rate_weight(i_val number,o_unit out varchar2) return varchar2 is
--???£¿£¿??£¿£¿£¿???¦Ë??£¿£¿£¿,£¿£¿Kg
begin
  if (i_val < 1000) then
     o_unit:='Kg';
     return 1;
  else
     o_unit:='T';
     return 1000;
  end if;
end fn_get_rate_weight;
/

