create or replace procedure sp_web_dict_update(
i_subtag varchar2,
i_lan varchar2,
i_val1 number,
i_val2 number,
i_content varchar2
) is
begin
  update tb_dict_ssiis set context  = i_content where subtag= i_subtag and language = i_lan and val1= i_val1 and val2 = i_val2;
  commit;
 end sp_web_dict_update;
/

