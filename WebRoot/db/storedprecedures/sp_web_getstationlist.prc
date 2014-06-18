create or replace procedure sp_web_getstationlist(
i_country varchar2,--国家
i_province varchar2,--省份
i_stationname varchar2,--电站名
cur_list out sys_refcursor
) is
--存在国家显示错误的存储过程
v_sql varchar2(1000);
--网站超级管理员获得电站列表
begin
v_sql:='select a.stationname,a.country,a.province,a.city,a.createdt,a.installcap,a.ludt,b.account from
               (select masterid,stationname,country,province,city,createdt,installcap,ludt from tb_station
                  where (:stationname_ is null or stationname = :stationname__)
                       and (:province_ is null or province=:province__)
                       and (:country_ is null or country=:country__)
                ) a ,tb_user b where a.masterid = b.userid(+)';
open cur_list for v_sql using i_stationname,i_stationname,i_province,i_province,i_country,i_country;
end sp_web_getstationlist;
/

