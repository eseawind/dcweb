create or replace function fn_get_val_yield(i_val number) return number is
--
begin
 /*  if i_val<1000 then
       return i_val;
   elsif i_val < 1000000 then
       return i_val/1000;
   else
       return i_val/1000000;
   end if;*/
   return i_val;
end fn_get_val_yield;
/

