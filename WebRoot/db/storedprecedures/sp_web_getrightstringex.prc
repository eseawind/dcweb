create or replace procedure sp_web_getrightstringex(
i_userid number,
i_stationid number,
cur_result  out sys_refcursor
) is
/*tb_user rolestring=a,b,c,d
a:升级程序
b:电站管理
c:帐号管理
d:设备管理
*/
/*tb_userstation rolestring=a,b,c
编辑电站信息
设备管理
配置报告
*/
/*电站列表菜单功能 a,b,c,d,e
a:电站查询
b:管理员配置
c:监控器管理
d:逆变器管理
e:用户帐号管理
*/
/*out string:
a,b,c,d,e,f,g,h,i
1,2,3,4,5,6,7,8,9
12345678901234567
123456789
a:电站查询
b:监控器查询
c:逆变器器查询
d:用户帐号查询
e:管理员配置
------------------------------
f:设备概览
g:报告配置
h:电站配置
i:共享配置
*/
v_rolestr varchar2(32);
v_rightstr varchar2(32);
v_roleid number;
v_rightid number;
v_listconfig number;
v_deflisturl number;
v_stationconfig number;
v_defurlstation number;
o_result varchar2(100);
begin
  if i_userid = 0 then
     o_result:='0,0,0,0,0,0,0,0,0';
  else
    select nvl(roleid,0),nvl(rolestring,'0,0,0') into v_roleid,v_rolestr from tb_user where userid = i_userid;
    if v_roleid = 4 then--超级管理员
         if i_stationid = 0 then
            v_rolestr:='1,1,1,1,1';
         else
            v_rolestr:='0,0,0,0,0';
        end if;
    elsif v_roleid=3 then--系统管理员
       if i_stationid = 0 then
         v_rolestr:=substr(v_rolestr,3,1)|| ',' ||substr(v_rolestr,7,1)|| ',' ||substr(v_rolestr,7,1)|| ','|| substr(v_rolestr,5,1)||',0';
       else
         v_rolestr:='0,0,0,0,0';
       end if;
    else
         v_rolestr:='0,0,0,0,0';
    end if;
    if v_rolestr = '0,0,0,0,0' then
       v_listconfig:=0;
       v_deflisturl:=0;
    else
      v_listconfig:=1;
      v_deflisturl:=instr(v_rolestr,'1');
    end if;
    if i_stationid >0 then
        if v_roleid in(3,4) then
           v_rightstr:='1,1,1,1';
        else
          select nvl(rightstr,'0,0,0'),nvl(roleid,0) into v_rightstr,v_rightid from tb_userstation where userid = i_userid and stationid  = i_stationid;
          if v_rightid = 2 then
            --电站管理员
            v_rightstr:='1,1,1,1';
          else
             v_rightstr:=v_rightstr||',0';
          end if;
        end if;
    else
        v_rightstr:='0,0,0,0';
    end if;
    if v_rightstr='0,0,0,0' then
      v_defurlstation:=0;
       v_stationconfig:=0;
    else
       v_stationconfig:=1;
       v_defurlstation:=instr(v_rightstr,'1');
    end if;
    --
    o_result:=v_rolestr||','||v_rightstr;
  end if;
  open cur_result for select decode(i_stationid,0,v_listconfig,v_stationconfig) config,
                             o_result menulist,
                             decode(i_stationid,0,
                                  /*列表菜单*/decode(v_deflisturl,1,'plantmanager.action',3,'confPmuList.action',5,'confInvList.action',7,'accountManager.action',9,'accountList.action','none'),
                                  /*电站菜单*/decode(v_defurlstation,1,'showStationModify.action',3,'equip_view.action',5,'reportDayShow.action',7,'shareAccountList.action','none'))defurl from dual;
end sp_web_getrightstringex;
/

