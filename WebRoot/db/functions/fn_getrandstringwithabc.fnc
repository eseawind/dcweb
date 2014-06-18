create or replace function fn_getrandstringwithabc(i_len number) return varchar2 is
v_vvv varchar2(100);
Result varchar2(100);
begin
  v_vvv:='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  for icn in 1 .. i_len loop
        result:=result||SUBSTR(v_vvv,round(dbms_random.value * 62,0)+1,1);
  end loop;
  return(Result);
end fn_getrandstringwithabc;
/

