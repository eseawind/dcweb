create or replace procedure sp_web_getprovincelist(
i_code number,--国家代码
i_language varchar2,--语言
cur_list out sys_refcursor--查询结果集
) is
/*================================================================
功能说明:根据指定代码及语言种类名称获得该国家的州省信息列表
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rownum number;
begin
  select count(1)into v_rownum from tb_dict_ssiis where subtag = 'webprovince' and language = i_language and val1 = i_code;
  if v_rownum >0 then
    open cur_list for select val2 pid,context provincename from tb_dict_ssiis where subtag = 'webprovince' and language = i_language and val1 = i_code;
  else
     open cur_list for select 1 pid,context provincename from tb_dict_ssiis where subtag = 'webcountrylist' and language = i_language and val1 = i_code;
  end if;
end sp_web_getprovincelist;
/

