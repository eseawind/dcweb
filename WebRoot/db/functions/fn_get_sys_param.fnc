create or replace function fn_get_sys_param(segment varchar2,keyname varchar2,defval varchar2) return varchar2 is
  v_rownum number;
  v_result varchar2(1000);
begin
  select count(1) into v_rownum from tb_sysparam where segment = segment and key_name = keyname;
  if v_rownum >0 then
     select key_val into v_result from tb_sysparam where segment = segment and key_name = keyname;
  else
    v_result:=defval;
  end if;
  return(v_result);
end fn_get_sys_param;
/

