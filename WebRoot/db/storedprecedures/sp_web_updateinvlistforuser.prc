create or replace procedure sp_web_updateinvlistforuser(
i_userid number,--用户ID号
i_stationid number,--电站编号
i_isnolist varchar2 default ''--xxxx,xxx,xxxx
) is
/*================================================================
功能说明:更新当前用户在指定电站的图表操作中，所选定的逆变器列表信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Graphs
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_itemnum number;
v_no varchar(32);
begin
  delete tb_userstationinv_def where userid = i_userid and stationid = i_stationid;
  v_itemNum :=fn_getitemnum(i_isnolist,',');
  for i in 1 .. v_itemnum loop
     v_no:=upper(fn_getmidstr(i_isnolist,i,','));
     if Length(v_no)> 3 then
         insert into tb_userstationinv_def(userid,stationid,isno) values(i_userid,i_stationid,v_no);
     end if;
  end loop;
  commit;
end sp_web_updateinvlistforuser;
/

