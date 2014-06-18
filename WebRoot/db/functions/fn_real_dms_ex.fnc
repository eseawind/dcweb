create or replace function fn_real_dms_ex(
i_val number) return varchar2 is
--将数值转换为度分秒
v_val number;
v_rest number;
v_degrees number;
v_minutes number;
v_seconds number;
v_pre varchar2(10);

begin
if i_val is null then
   return null;
else

if i_val >=0 then
  v_pre:='+:';
  v_val:=(i_val);
else
  v_val:=abs(i_val);
  v_pre:='-:';
end if;
  v_degrees:=trunc(v_val);
  v_rest:=(v_val - v_degrees)*60;
  v_minutes:=trunc(v_rest);
  v_rest:=(v_rest-v_minutes)*60;
  v_seconds:=trunc(v_rest);
  return v_pre||v_degrees||'-'||v_minutes||'-'||v_seconds;
end if;
end fn_real_dms_ex;
/

