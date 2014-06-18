create or replace procedure sp_web_dict_remove(
i_subtag varchar2,
i_lan varchar2,
i_val1 number,
i_val2 number
) is
begin
  delete tb_dict_ssiis where subtag= i_subtag and language = i_lan and val1= i_val1 and val2 = i_val2;
  commit;
 end sp_web_dict_remove;
/

