create or replace procedure sp_web_query_inv_pageex(
i_stationname varchar2,
i_type varchar2,--型号
i_isno varchar2,
i_rowperpage number ,--每页行数
i_pos number default 1,--当前行数
o_pages out number,--返回总页数
cur_result out sys_refcursor
) is
/*================================================================
功能说明:根据条件分页查询逆变器列表
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:管理员功能之逆变器查询
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rownum  number;
v_rowperpage number;
begin
  if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
  else v_rowperpage:=3;
  end if;
  select count(1) into v_rownum from (select a.isno,trim(a.devtypename)devtype,b.stationname from  tb_inverter a ,tb_station b where a.stationid = b.stationid ) where
                          (i_stationname is null or stationname like '%'||i_stationname||'%')
                      and (i_type is null or devtype like '%'||i_type||'%')
                      and (i_isno is null or isno like upper('%'||i_isno||'%'));
  o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
  if o_pages<=0  then
     o_pages:=1;
  end if;
      open cur_result for
      select c.isno,c.factoryname,c.penpai,c.invtype,c.state,c.stationname,d.context country,c.city
          from (select * from (select isno,factoryname,country,city,state,penpai,invtype,stationname,rownum rn from (select a.isno,a.factoryname,a.state,a.penpai,a.invtype,b.stationname,b.country,b.city from
                         ( select stationid,isno,factoryname,penpai,state,trim(devtypename) invtype from tb_inverter
                                where(i_type is null or devtypename like '%'||i_type||'%')
                                and (i_isno is null or isno like upper('%'||i_isno||'%'))
                                order by state desc,isno)a,
                          tb_station b where a.stationid = b.stationid )
  where (i_stationname is null or stationname like '%'||i_stationname||'%')) where (rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage)   ) c,
               (select context,val1 country
                from tb_dict_ssiis
                where subtag= 'webcountrylist' and language='zh_CN') d
                          where c.country = d.country(+);
end sp_web_query_inv_pageex;
/

