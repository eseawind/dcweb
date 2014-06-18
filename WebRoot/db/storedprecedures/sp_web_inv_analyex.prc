create or replace procedure sp_web_inv_analyex(
o_totalnum out number,
o_totalbind out number,
cur_type out sys_refcursor,
cur_country out sys_refcursor
)  is
/*================================================================
功能说明:系统中逆变器信息按类型及国家地区查询
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:管理员功能之逆变器统计
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_totalnum number;
begin
  select count(1) into o_totalbind from tb_inverter where stationid >0;
  select count(1) into o_totalnum from tb_inverter where stationid >0;
  if o_totalnum =0 then
     v_totalnum:=1;
  else
     v_totalnum:=o_totalnum;
  end if;
  open cur_type for select nvl(trim(pt),'other') pt,pn,trim(to_char(round((pn*100/v_totalnum),1),'990.9')) pp from (select trim(devtypename) pt,count(1) pn from tb_inverter where stationid >0 group by trim(devtypename)) order by pn desc;
  open cur_country for select b.context,a.pn,trim(to_char(round((pn*100/o_totalbind),1),'990.9')) pp  from
                           (select country,count(1) pn from (
                              select nvl(b.country,86) country from  tb_inverter a,tb_station b where a.stationid = b.stationid(+) and a.stationid >0
                           )  group by country) a,
                           (select context,val1 country from tb_dict_ssiis where subtag= 'webcountrylist' and language='zh_CN') b
                           where a.country=b.country order by pn desc;

end sp_web_inv_analyex;
/

