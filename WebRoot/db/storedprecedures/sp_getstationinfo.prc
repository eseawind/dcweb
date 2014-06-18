create or replace procedure sp_getstationinfo(
i_stationid in number,
cur_station out sys_refcursor,
cur_master out sys_refcursor
) is
--获得电站的详细情况，存在国家显示错误的过程
--i_StationID:电站编号
--cur_station:电站信息结果集
--cur_master:电站管理员信息
--适应于:手机,wap
v_sharet number;
v_userid number;
begin
   select masterid,sharet into v_userid,v_sharet from tb_station where stationid = i_stationid;
   --下面语句修改存储过程后，打开
   open cur_station for select a.stationname,a.startdt,a.totalpower,a.companyname,a.city,b.context country,a.zip,a.jd,a.wd,a.height,a.timezone,a.bgurl from
                                (select stationname,nvl(to_char(startdt,'yyyy-mm-dd'),'2000-01-01') startdt,totalpower,nvl(companyname,'') companyname,city,country,nvl(zip,'') zip,nvl(fn_real_dms(jd),'') jd,nvl(fn_real_dms(wd),'') wd,h||'(m)' height,fn_timezone_string(timezone) timezone,bgurl from tb_station where stationid = i_stationid)a,
                                (select context,val1 country from tb_dict_ssiis where subtag= 'webcountrylist' and language='zh_CN')b where a.country = b.country;
   --open cur_station for select stationname,startdt,totalpower,companyname,city,country,zip,jd,wd,h height,timezone,bgurl from tb_station where stationid = i_stationid;
   open cur_master for select firstname,secondname,company,street,city,country,account e_mail,tel from tb_user where userid = v_userid;
end sp_getstationinfo;
/

