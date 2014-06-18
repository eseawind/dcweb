create or replace function fn_real_dms(
i_val number) return varchar2 is
--将数值转换为度分秒
v_rest number;
v_degrees number;
v_minutes number;
v_seconds number;
v_str varchar2(100);
begin
if i_val is null then
  return null;
else
  v_degrees:=trunc(i_val);
  v_rest:=(abs(i_val) - abs(v_degrees))*60;
  v_minutes:=trunc(v_rest);
  v_rest:=(v_rest-v_minutes)*60;
  v_seconds:=trunc(v_rest);
  v_str:=v_degrees||'°'||v_minutes||'’'||v_seconds||'”';
return v_str;
end if;
end fn_real_dms;
/

