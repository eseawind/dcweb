create or replace procedure sp_web_updatestationinfo(
i_stationid number,--电站编号
i_stationname varchar2,--电站名称
i_picurl varchar2 default 'res/def/icon/plant01.jpg',--电站图片URL
i_startdt varchar2,--并网发电日期--
i_installcap number,--装机容量--
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
i_timezonex number--,--时区记录编号
) is
v_rownum number;
v_startdate date;
v_jd number;
v_wd number;
begin
   select count(1) into v_rownum from tb_station where stationid = i_stationid;
   if v_rownum >0 then
      v_wd:=fn_dms_real(i_wd);
      v_jd:=fn_dms_real(i_jd);
      v_startdate:=to_date(i_startdt,'yyyy-mm-dd');
      update tb_station set stationname=i_stationname,startdt=v_startdate,totalpower=i_installcap,
                      country=nvl(to_number(i_country),country),province=nvl(to_number(i_province),province),city=i_city,street=i_street,zip=i_zip,
                      jd=v_jd,wd=v_wd,h=i_height,comangle=i_insangle,co2xs=i_co2rate,gainxs=i_incomerate,
                      money=i_currency,timezone=i_timezone,w_keyval=i_timezonex,iconindex=i_picurl 
               where stationid = i_stationid;
      commit;
   end if;
   
end sp_web_updatestationinfo;
/

