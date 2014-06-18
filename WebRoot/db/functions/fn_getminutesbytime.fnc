create or replace function fn_getminutesbytime(i_timestr varchar2) return number is
--11:33
begin
  if i_timestr is null then
    return null;
  end if;
  if length(i_timestr)=5  or length(i_timestr)=8 then
       return to_number(substr(i_timestr,1,2))*60 + to_number(substr(i_timestr,4,2));
  end if;
  return 0;
end fn_getminutesbytime;
/

