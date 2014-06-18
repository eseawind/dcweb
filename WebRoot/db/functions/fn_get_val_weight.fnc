create or replace function fn_get_val_weight(i_val number) return varchar2 is
--???£¿£¿??£¿£¿£¿???¦Ë??£¿£¿£¿,£¿£¿Kg
v_rate number;
begin
 if (i_val < 1000) then
     v_rate:=1;
  else
     v_rate:=1000;
  end if;
  return round(i_val/v_rate,2);
end fn_get_val_weight;
/

