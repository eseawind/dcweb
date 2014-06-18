create or replace procedure sp_geteventinfo(
i_eventid number,--事件编号
i_lan varchar2,--语种
cur_result out sys_refcursor) is
v_stationname varchar2(100);
v_byname varchar2(100);
v_describle varchar2(100);
v_stationid number;
v_ssno varchar2(60);
v_v1 number;
v_v2 number;
v_occdt date;
begin

  --v_stationname:='太空站';
  --v_byname:='1楼顶';
  --v_describle:='设备离线';
  select stationid,ssno,val1,val2,occdt  into v_stationid,v_ssno,v_v1,v_v2,v_occdt from tb_event_all where did = i_eventid;
  select stationname into v_stationname from tb_station where stationid = v_stationid;
  select nvl(byname,isno) into v_byname from tb_inverter where isno = v_ssno;
  select context into v_describle from tb_dict_ssiis where language = i_lan and val1 = v_v1 and val2=v_v2 and subtag = 'pmuerrcode';

  open cur_result for select v_stationname stationname,
                             v_ssno isno,
                             v_byname byname,
                             to_char(v_occdt,'yyyy-mm-dd hh24:mi:ss') occdt,
                             v_describle eventinfo from dual;

end sp_geteventinfo;
/

