create or replace procedure sp_set_accountrightonstation(
i_stationid number,--电站编号
i_userid number,--共享的帐号
i_rightstr varchar2,--权限字符串,示例:x,x,x,x
o_result out varchar2) is
/*================================================================
功能说明:修改指定电站指定用户的当前管理权限
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Config/Shared config
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
--为电站指定共享帐号
v_rownum number;
begin
     select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid= i_userid;
     if v_rownum =1 then
        update tb_userstation set rightstr = i_rightstr where stationid = i_stationid and userid= i_userid;
        commit;
        o_result:='ok';
     else
       o_result:='err_notexists';
     end if;
end sp_set_accountrightonstation;
/

