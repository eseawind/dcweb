create or replace procedure sp_web_shareaccountactiveex(
i_stationid number,--被共享的电站编号
i_userid number,--共享接收方的用户ID
i_state number,--1:接受,-1:拒绝,0:初值值
o_result  out varchar2--输出结果
) is
/*================================================================
功能说明:共享电站用户帐号激活
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:电站列表中,未激活电站的共享接受操作
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
--
v_rownum number;
begin
  if i_state in(-1,0,1) then
  select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid = i_userid;
  if v_rownum >0 then
        update tb_userstation set mailactive = i_state where stationid = i_stationid and userid = i_userid;
        commit;
        o_result:='ok';
  else
     o_result:='err_account';
  end if;
  else
    o_result:='err_state';
  end if;
end sp_web_shareaccountactiveex;
/

