create or replace procedure sp_web_getcountrylist(
i_language varchar2,--语言名称
cur_list out sys_refcursor--国家列表
) is
/*================================================================
功能说明:********
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:页面中用到国家列表的查询
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
begin
  open cur_list for select val1 c_code,val2,context countryname from tb_dict_ssiis where language=i_language and subtag = 'webcountrylist' order by val2,nlssort(countryname,'NLS_SORT=SCHINESE_PINYIN_M');
end sp_web_getcountrylist;
/

