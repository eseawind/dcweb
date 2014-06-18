create or replace procedure sp_dcg_pmulogin(
i_psno varchar2,--pmu 序列号
i_idex out varchar2,--pmu设备序列号
i_clientip varchar2,--pmu ip地址
o_stationid out number,
o_timezone out number,--电站所在时区
o_result out varchar2 --登录结果
) is
v_idex varchar2(60);
v_rownum number;
v_stationid number;
v_curdate date;--电站所在时区当前时间

begin
   select count(1) into v_rownum from tb_pmu where psno = upper(i_psno);
   if v_rownum >0 then
      select nvl(stationid,0),idex into v_stationid,v_idex from tb_pmu where psno = upper(i_psno);
      if v_stationid >0 then--已经绑定电站的PMU
         if  true then --v_idex = i_idex  暂未判断验证码部分
           v_curdate:=fn_get_station_local_date(v_stationid);--获得该电站的所在时区的当前时间
            update tb_pmu set state = 1,llip = i_clientip,lldt=v_curdate,ludt=v_curdate where psno = upper(i_psno);
            insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     v_stationid,upper(i_psno),1,v_curdate,
                     1,301,0,0);--插入PMU上线事件记录
            commit;
            select nvl(timezone,8) into o_timezone from tb_station where stationid = v_stationid;
            o_stationid :=v_stationid;
            o_result:='ok';--登录成功
         else
            o_result:='err_idex';--扩展码错误
         end if;
      else
        o_result:='err_nobind';--PMU未绑定
      end if;
   else
      o_result:='err_psno';--PMU的序列号不存在
   end if;
end sp_dcg_pmulogin;
/

