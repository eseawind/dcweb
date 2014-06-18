create or replace procedure sp_web_dict_Add(
i_subtag varchar2,
i_lan varchar2,
i_val1 number,
i_val2 number,
i_content varchar2,
o_result out varchar2
) is
v_rownum number;
begin
  select count(1) into v_rownum from tb_dict_ssiis  where subtag = i_subtag and language = i_lan and i_val1 = val1 and val2 = i_val2;
  if length(i_subtag)<= 3 or not i_lan in('en_US','zh_CN','da_DK') then
     o_result:='error_lan';
  else
  if v_rownum >0 then
      o_result:='error_exists';
  else
      insert into tb_dict_ssiis(subtag,language,val1,val2,context) values(i_subtag,i_lan,i_val1,i_val2,i_content);
      commit;
        o_result:='ok'  ;
  end if;
 end if;

end sp_web_dict_Add;
/

