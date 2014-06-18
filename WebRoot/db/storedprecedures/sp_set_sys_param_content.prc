create or replace procedure sp_set_sys_param_content(i_segment varchar2,i_key varchar2,i_value varchar2,i_content varchar2) is
v_rownum number;
begin
  select count(1) into v_rownum from tb_sysparam where segment = i_segment and key_name = i_key;
  if  v_rownum >0 then
      update tb_sysparam set key_val = i_value,content=i_content where segment = i_segment and key_name = i_key;
  else
      insert into tb_sysparam(segment,key_name,key_val,content) values (i_segment,i_key,i_value,i_content);
  end if;
  commit;
end sp_set_sys_param_content;
/

