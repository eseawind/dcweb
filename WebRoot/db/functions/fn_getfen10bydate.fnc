create or replace function fn_getfen10bydate(i_date date) return number is
--�������ڻ��fen10��ֵ
begin
  return round((i_date-trunc(i_date))*24*6);
end fn_getfen10bydate;
/

