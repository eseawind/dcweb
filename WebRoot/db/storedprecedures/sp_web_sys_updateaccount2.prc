create or replace procedure sp_web_sys_updateaccount2(
i_account varchar2,
i_prg_up number,--升级程序
i_sta_config number,--电站管理
i_acc_config number,--帐号管理
i_dev_config number,--设备管理
i_event_query number,--事件查询
i_state number,
o_result out varchar2
) is
/*================================================================
功能说明:更新系统管理员帐号信息操作(主要是权限设置)
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:超级管理员功能之管理员管理
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_account varchar2(100);
v_rownum number;
v_rolestring varchar2(100);
v_roleid number;
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum >0 then
     select roleid into v_roleid from tb_user where account = v_account;
     if v_roleid = 3 then
         if i_prg_up is null or i_sta_config is null or i_acc_config is null or i_dev_config is null or i_event_query is null  then
            v_rolestring:=null;
         else
         v_rolestring:=to_char(i_prg_up)||','||to_char(i_sta_config)||','||to_char(i_acc_config)||','||to_char(i_dev_config)||','||to_char(i_event_query);
         end if;
         update tb_user set rolestring = nvl(v_rolestring,rolestring),
                            state = i_state
                where account = v_account;
         commit;
     else
        o_result:='err_notsysaccount';
     end if;
  else
     o_result:='err_notexists';
  end if;
end sp_web_sys_updateaccount2;
/

