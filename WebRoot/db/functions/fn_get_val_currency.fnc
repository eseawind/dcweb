create or replace function fn_get_val_currency(
i_currency varchar2,
i_val number
) return number is
v_rate number;
begin
  if i_currency = '$' then
      if (i_val < 1000 or i_val is null) then
         v_rate:=1;
      elsif (i_val<1000000) then
         v_rate:=1000;
      elsif(i_Val<1000000000) then
         v_rate:=1000000;
      else
        v_rate:=1000000000;
      end if;
  elsif i_currency = '??' then
     if (i_val < 10000 or i_val is null) then
         v_rate:=1;
      elsif (i_val<100000000) then
         v_rate:=10000;
      else
         v_rate:=100000000;
      end if;
  else
     v_rate:=1;
  end if;
  return round(i_val/v_rate,2);
end fn_get_val_currency;
/

