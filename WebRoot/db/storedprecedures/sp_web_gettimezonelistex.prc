create or replace procedure sp_web_gettimezonelistex(
i_language varchar2,
i_clientzonestr varchar2,   --客户端时区
o_timezoneid out number,
cur_list out sys_refcursor) is
/*================================================================
功能说明:指定语言，提取页面时区列表信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:创建电站页面等
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rn number;
begin
  --select * from tb_sys_log; 
  select count(1) into v_rn from tb_dict_ssiis where subtag = 'webtimezonedef' and language = 'zh_CN' and val1 = to_number(i_clientzonestr);
  if v_rn =1  then
  select val2 into o_timezoneid from tb_dict_ssiis where subtag = 'webtimezonedef' and language = 'zh_CN' and val1 = to_number(i_clientzonestr);
  else
         o_timezoneid:=101;
    end if;
  insert into tb_sys_log(idd,occdt,context) values (seq_idd_log.nextval,sysdate,i_clientzonestr);
  commit;
  open cur_list for select val1 areacode,val2 keyval,context areaname from tb_dict_ssiis where subtag = 'webtimezone' and language = i_language ;
end sp_web_gettimezonelistex;
/

