create or replace function fn_get_val_w(i_val number) return number is
--???¡Â??²Ó?£¿£¿£¿£¿???¦Ë,£¿£¿KWh
v_rate number;
begin
  if (i_val < 1000) then
     v_rate:=1;
  elsif (i_val<1000000) then
     v_rate:=1000;
  elsif(i_Val<1000000000) then
     v_rate:=1000000;
  else
    v_rate:=1000000000;
  end if;
  return round(i_val/v_rate,2);
end fn_get_val_w;
/

