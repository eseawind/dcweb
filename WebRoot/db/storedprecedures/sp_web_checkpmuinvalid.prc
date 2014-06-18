create or replace procedure sp_web_checkpmuinvalid(
i_psno varchar2,--PMU序列号
i_idex varchar2,--注册码
o_result out varchar2--检测结果
) is
/*================================================================
功能说明:创建电站，绑定PMU时，检测输入的PMU信息是否正确
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:创建电站，绑定PMU，解除绑定PMU
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
v_stationid number;
v_idex varchar2(60);
begin
  select count(1) into v_rownum from tb_pmu where psno = upper(i_psno);
  if v_rownum >0 then
       select stationid,idex into v_stationid,v_idex from tb_pmu where psno = upper(i_psno);
       if v_stationid is null then
            if v_idex = i_idex then
                o_result:='ok';
            else
                o_result:='err_idex';
            end if;
       else
                 o_result:='err_used';
       end if;

  else
      o_result:='err_nofound';
  end if;

end sp_web_checkpmuinvalid;
/

