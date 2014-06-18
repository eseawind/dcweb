create or replace procedure sp_web_querystationpageexex(
i_country varchar2,--国家代码
i_province varchar2,--省份代码
i_stationname varchar2,--电站名称
i_rowperpage number ,--每页行数
i_account varchar2,--用户帐号
i_isselect number,--查询是否选中,-1:全部
i_pos number default 1,--当前行数
o_pages out number,--返回总页数
cur_result out sys_refcursor
) is
/*================================================================
功能说明:根据入参中各条件组合查询电站信息并分页显示
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:超级管理员的电站查询功能
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
v_account varchar2(100);
begin
     v_account:=lower(trim(i_account));
     if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
     else v_rowperpage:=3;
     end if;
     select count(1) into v_rownum from tb_station a,tb_user b
          where a.masterid = b.userid and
                (i_country is null or a.country = to_number(i_country)) and
                (i_province is null or a.province = to_number(i_province)) and
                (i_isselect = -1 or nvl(isselect,0) = i_isselect) and 
                (i_stationname is null or a.stationname like '%'||i_stationname||'%') and
                (v_account is null or b.account like '%'||v_account||'%');
     o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
     if o_pages<=0  then
     o_pages:=1;
  end if;
  open cur_result for
          select d.stationid,d.stationname,e.context country,f.province,d.city,to_char(d.createdt,'yyyy-mm-dd') createdt,d.totalpower,to_char(d.ludt,'yyyy-mm-dd') ludt,d.account,d.isselect from
             (select * from (select c.*,rownum rn from (
                 select stationid,stationname,city,country,country*1000+province province,createdt,totalpower,ludt,account,isselect from(
                     select a.stationid,a.stationname,a.city,a.country,a.province,a.createdt,a.totalpower,a.ludt,b.account,nvl(a.isselect,0) isselect from tb_station a,tb_user b
                     where (a.masterid = b.userid(+)) order by createdt desc)
                 where (i_country is null or country = to_number(i_country)) and
                       (i_province is null or province = to_number(i_province)) and
                       (i_stationname is null or stationname like '%'||i_stationname||'%') and
                       (i_isselect = -1 or nvl(isselect,0) = i_isselect) and 
                       (v_account is null or account like '%'||v_account||'%')) c)
             where rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage
             ) d,
             (select context,val1 country
                from tb_dict_ssiis
                where subtag= 'webcountrylist' and language='zh_CN'
              ) e,
             (select context province,val1*1000+val2 provinceid from tb_dict_ssiis where subtag= 'webprovince' and language='zh_CN'
             ) f
             where d.country=e.country(+) and d.province = f.provinceid(+) order by createdt desc;
end sp_web_querystationpageexex;
/

