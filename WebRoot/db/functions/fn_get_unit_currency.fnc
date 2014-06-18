create or replace function fn_get_unit_currency(
i_currency varchar2,
i_val number
) return varchar2 is
--???£¿?¦Ë?£¿£¿?£¿
begin
  if i_currency = '$' then
      if (i_val < 1000 or i_val is null) then
         return '$';
      elsif (i_val<1000000) then
         return 'K$';
      elsif(i_Val<1000000000) then
         return 'M$';
      else
        return'G$';
      end if;
  elsif i_currency = '??' then
     if (i_val < 10000 or i_val is null) then
         return '??';
      elsif (i_val<100000000) then
         return '£¿??';
      else
         return '£¿??';
      end if;
  else
     return i_currency;
  end if;
end fn_get_unit_currency;
/

