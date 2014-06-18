create or replace function fn_timezone_string(
i_timezone number
) return varchar2 is
 v_timezone number;
begin
 
   if(i_timezone>0)then
      return 'GMT+'||to_char(trunc(i_timezone),'fm00')||':'||to_char(mod(i_timezone*60,60),'fm00');
   else
     v_timezone :=abs(i_timezone);
      return 'GMT-'||to_char(abs(trunc(v_timezone)),'fm00')||':'||to_char(mod(v_timezone*60,60),'fm00');
   end if;
end fn_timezone_string;
/

