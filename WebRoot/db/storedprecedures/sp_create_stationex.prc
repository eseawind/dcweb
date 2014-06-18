create or replace procedure sp_create_stationex(
i_userid number,--用户ID号
i_stationname varchar2,--电站名称
i_picurl varchar2 default '/res/def/icon/plant01.jpg',--电站图片URL
i_startdt varchar2,--并网发电日期--
i_installcap number,--装机容量
i_company varchar2,
i_country varchar2,--国家名称--
i_city     varchar2,--城市名称--
i_street   varchar2,--所在街道--
i_province varchar2,--省份
i_zip      varchar2,--邮编
i_jd       varchar2 default 137,--经度:(东经23度，37分，30秒，格式为:e:23-27-30,西经为:w:23-27-30)
i_wd       varchar2 default 37,--纬度:(北纬132度,30分，27秒，格式为:n:132-30-27,南纬为:s:132-30-37)
i_height   number,--海拔单位（米）
i_insangle number,--安装倾向角
i_co2rate  number default 0.7,--二氧化碳减排系数
i_incomerate number default 0.8,--电站收益系数
i_currency  varchar2 default '$',--货币单位
i_timezone number default 8,--电站所在时区，东正,西负
i_timezonex number,--时区记录编号
o_stationid out number,
i_customerflag NUMBER DEFAULT 1) is
/*================================================================
功能说明:网页创建电站,返回0创建未成功
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:电站列表中创建电站操作
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_startdate date;
v_jd number;
v_wd number;
v_rownum number;
begin
   select count(1) into v_rownum from tb_user where userid = i_userid;
   if v_rownum >0 then
      v_wd:=fn_dms_real(i_wd);
      v_jd:=fn_dms_real(i_jd);
      v_startdate:=to_date(i_startdt,'yyyy-mm-dd');
      insert into tb_station(stationid,stationname,createdt,masterid,startdt,totalpower,companyname,country,province,city,street,zip,jd,wd,h,comangle,co2xs,gainxs,money,timezone,w_keyval,pmutnum,pmu1num,inv1num,sharet,iconindex,bgurl,customerflag) values (seq_stationid.nextval,i_stationname,sysdate,i_userid,v_startdate,i_installcap,i_company,to_number(i_country),to_number(i_province),i_city,i_street,i_zip,v_jd,v_wd,i_height,i_insangle,i_co2rate,i_incomerate,i_currency,i_timezone,i_timezonex,0,0,0,0,nvl(i_picurl,'/res/def/icon/plant01.jpg'),'/upload/station/defultBg.jpg',i_customerflag);
      select seq_stationid.currval into o_stationid from dual;
      update tb_user set roleid = 12 where userid = i_userid and roleid = 0; --=3,4的系统管理员角色不变
      insert into tb_userstation(userid,stationid,createdt,roleid,state,mailactive) values(i_userid,o_stationid,sysdate,2,1,1);
      commit;
      --插入电站报告配置记录
      sp_create_stationreportconfig(o_stationid);
  else
     o_stationid:=0;
  end if;
end sp_create_stationex;
/

