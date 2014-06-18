create or replace function GetLocalCurrentDatetime(i_areacode number) return date is
  Result date;
v_sql varchar(200);
begin
 v_sql:='select systimestamp at time zone '''||substr(fn_timezone_string(i_areacode),4,6)||''' from dual';
  execute immediate v_sql into result;
  return(Result);
end GetLocalCurrentDatetime;
/

