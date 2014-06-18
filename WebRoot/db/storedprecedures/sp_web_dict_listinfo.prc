create or replace procedure sp_web_dict_listinfo(
cur_subtag out sys_refcursor,
cur_lan out sys_refcursor
) is
begin
  open cur_subtag for select distinct subtag from tb_dict_ssiis;
  open cur_lan for select distinct language from tb_dict_ssiis;
end sp_web_dict_listinfo;
/

