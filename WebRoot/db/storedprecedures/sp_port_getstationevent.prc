create or replace procedure sp_port_getstationevent (
i_stationid number,--电站编号
i_dts varchar2 default null,--开始日期
i_dte varchar2 default null,--结束日期
cur_result out sys_refcursor--输出结果集
) is
/*说明:
针对公共数据接口提供的电站事件查询*/
v_dts date;
v_dte date;
begin
     v_dts:=to_date(i_dts||' 00:00:00','yyyy-mm-dd hh24:mi:ss');
      v_dte:=to_date(i_dte||' 23:59:59','yyyy-mm-dd hh24:mi:ss');
----1:信息，2:警告,3:错误
   open cur_result for select did,ssno,occdt,val1 msgtype,val2 err_code from tb_event_all where stationid = i_stationid and occdt between v_dts and v_dte;
end sp_port_getstationevent;
/

