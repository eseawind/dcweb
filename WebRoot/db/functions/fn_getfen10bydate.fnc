create or replace function fn_getfen10bydate(i_date date) return number is
--根据日期获得fen10数值
begin
  return round((i_date-trunc(i_date))*24*6);
end fn_getfen10bydate;
/

