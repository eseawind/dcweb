create or replace procedure sp_stationbindpmu(
i_stationid in number,--电站编号
i_psno in varchar2,--pmu序列号
i_serial varchar2,--pmu验证码格式为:xxxx-xxxx-xxxx-xxxx
i_opdate varchar2,
o_result out varchar2) is
/*================================================================
功能说明:电站绑定PMU操作
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:创建电站及进入电站后，绑定新的PMU操作
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_r1 number;
v_r2 number;
v_idex varchar2(64);
v_oldid number;
v_curdate date;--电站所在时区当前时间
begin
   select count(1) into v_r1 from tb_station where stationid = i_stationid;
   select count(1)into v_r2 from tb_pmu where psno = upper(i_psno);
   if v_r1 > 0 and v_r2 >0 then
      select nvl(stationid,0),idex into v_oldid,v_idex from tb_pmu where psno = upper(i_psno);
      if v_oldid=0 then
         if v_idex = i_serial then --v_idex = i_serial
           update tb_pmu set stationid = i_stationid where psno = upper(i_psno);
           update tb_inverter set stationid = i_stationid  where upper(psno) = upper(i_psno);
         --v_curdate:=fn_get_station_local_date(i_stationid);--获得该电站的所在时区的当前时间
         v_curdate:= to_date(i_opdate,'yyyy-MM-dd hh24:mi:ss');
           insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     i_stationid,upper(i_psno),1,v_curdate,
                     1,303,0,0);--PMU绑定事件
           commit;
           o_result:='ok';
         else
           o_result:='err_serial';
         end if;
      else
         o_result:='err_usednow';
      end if;
   else
      o_result:='err_notexists';
   end if;
end sp_stationbindpmu;
/

