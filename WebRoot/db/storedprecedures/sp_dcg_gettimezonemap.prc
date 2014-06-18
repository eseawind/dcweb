create or replace procedure sp_dcg_gettimezonemap(
cur_list out sys_refcursor) is

begin
  open cur_list for select d.val2 timezoneid,d.ex2 timezonename from tb_dict_ssiis d where subtag = 'webtimezone' and language = 'en_US' ;
end sp_dcg_gettimezonemap;
/

