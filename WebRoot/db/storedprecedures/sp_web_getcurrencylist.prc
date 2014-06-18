create or replace procedure sp_web_getcurrencylist(o_curresult out sys_refcursor) is
/*================================================================
功能说明:获得当前可选择的货币符号列表
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:创建电站页面
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_str1 varchar2(10);
v_str2 varchar2(10);
v_str3 varchar2(10);
v_str4 varchar2(10);
begin
  v_str1:='$';
  v_str2:='￥';
  v_str3:='�';
  v_str4:='kr';

  open o_curresult for 
                   select v_str1  currency from dual union 
                   select v_str2  currency from dual union 
                   select v_str3  currency from dual union 
                   select v_str4  currency from dual;
end sp_web_getcurrencylist;
/

