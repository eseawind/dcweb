create or replace procedure sp_dcg_eventEx(
i_stationid number,--电站编号
i_occdt varchar2,--发生日期时间
i_ssno varchar2,--设备序列号
i_eve_type number,--事件类型
i_eve_code number,--事件代码
i_devt number,--设备类型
o_Recid out number--输出当前所插入的记录编号
) is
--DCG网关事件上传存储过程
begin
  insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     i_stationid,upper(i_ssno),i_devt,to_date(i_occdt,'yyyy-mm-dd hh24:mi:ss'),
                     i_eve_type,i_eve_code,0,0);
--Eve_type=1,是特殊的事件，用来修改逆变器的状态(1:在线，0:离线)
  if i_eve_type = 1  then --信息类型
    if i_eve_code = 0 then --在线
      update tb_inverter set state = 0 where isno = upper(i_ssno);
    elsif i_eve_code =1 then  --在线
       update tb_inverter set state = 1 where isno = upper(i_ssno);
    end if;
  end if;
  commit;
  if i_eve_code = 312 then--特殊事件，重新计算电站日数据
     mp_recalc_daily(i_stationid,i_occdt);
  end if;
  select SEQ_INVEVENT_ID.currval  into o_recid from dual;
end sp_dcg_eventEx;
/

