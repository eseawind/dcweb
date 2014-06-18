create or replace procedure sp_web_gettimezonelist(
i_language varchar2,
cur_list out sys_refcursor) is
/*================================================================
功能说明:指定语言，提取页面时区列表信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:创建电站页面等
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
  open cur_list for select val1 areacode,val2 keyval,context areaname, ex1 isdst from tb_dict_ssiis where subtag = 'webtimezone' and language = i_language order by val1,context ;
end sp_web_gettimezonelist;
/

