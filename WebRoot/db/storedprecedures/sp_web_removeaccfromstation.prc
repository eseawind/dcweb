create or replace procedure sp_web_removeaccfromstation(
i_stationid number,--电站编号
i_userid number,--用户ID号
o_result out varchar2
) is
/*================================================================
功能说明:为指定电站删除共享的帐号
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
v_rownum number;
v_roleid number;
begin
      select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid = i_userid;
       if v_rownum  >0 then
           select roleid into v_roleid from tb_userstation where stationid = i_stationid and userid = i_userid;
           if v_roleid = 1 then
               delete tb_userstation where userid = i_userid and stationid = i_stationid;
               --检测该用户下是否还存在共享电站或自己的电站
               select count(1) into v_rownum from tb_userstation where userid= i_userid;
               if v_rownum =0 then--没有电站了
                   update tb_user set roleid = 0 where userid = i_userid;
               end if;
               commit;
               o_result:='ok';
           else
              o_result:='err_roleid';
           end if;
       else
           o_result:='err_norolerec';
       end if;
end sp_web_removeaccfromstation;
/

