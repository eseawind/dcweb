create or replace procedure sp_web_removeinvbasepmustation(
i_stationid number,
i_isno varchar2,
o_result out varchar2
) is
/*================================================================
功能说明:电站删除指定门口
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Config/Device management
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
   if i_stationid is not null and  length(i_isno)>2 then
      select count(1) into v_rownum from tb_inverter where stationid = i_stationid and isno=upper(i_isno);
      if v_rownum >0 then
         update tb_inverter set stationid = null,psno = null where isno = upper(i_isno);
         commit;
         o_result:='ok';
      else
         o_result:='err';
      end if;
   else
        o_result:='err_itemempty';
   end if;
end sp_web_removeinvbasepmustation;
/

