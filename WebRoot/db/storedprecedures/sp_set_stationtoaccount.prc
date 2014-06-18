create or replace procedure sp_set_stationtoaccount(
i_stationid number,--电站编号
i_account varchar2,--共享的帐号
i_rightstr varchar2,--权限字符串,示例:x,x,x,x
o_result out varchar2) is
/*================================================================
功能说明:将指定电站共享给指定帐号操作
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
v_account varchar2(60);
v_rownum number;
v_userid number;
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum >0 then
     select userid into v_userid from tb_user where account = v_account;
     select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid= v_userid;
     if v_rownum =0 then
        insert into tb_userstation(userid,stationid,createdt,roleid,rightstr,state,mailactive) values(v_userid,i_stationid,sysdate,1,i_rightstr,0,1);
        commit;
        o_result:='ok';
     else
       o_result:='err_exists';
     end if;
  else
     o_result:='err_account';
  end if;
end sp_set_stationtoaccount;
/

