create or replace procedure sp_get_station_power_month2(
i_stationid in number,--��վ���
i_yearmonth in varchar2,--��ѯ����
o_startdt out varchar2,--�����ѯ��Χ�Ŀ�ʼ����
o_enddt out varchar2,--�����ѯ��Χ�Ľ�������
o_sumstr out varchar2,
cur_power out sys_refcursor--��ѯ��������
) is
--��ȡһ�����ڣ�����ķ�������Ϣ
   v_rangdts date;
   v_daynum number;
   v_rangdte date;
   v_unit varchar2(10);
   v_max number;
   v_rate number;
   v_month number;
   v_today number;--���շ�����
   v_curdate date;--��վ����ʱ����ǰʱ��
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   if i_yearmonth = to_char(v_curdate,'yyyy-mm') then
      v_today:=fn_get_station_e_today(i_stationid);
   else
      v_today:=0;
   end if;
   v_rangdts:=to_date(i_yearmonth||'-01','yyyy-mm-dd');
   v_rangdte :=last_day(v_rangdts);
   v_daynum :=to_number(to_char(v_rangdte,'dd'));
   o_startdt :=to_char(v_rangdts,'yyyy-mm-dd');
   o_enddt:=to_char(v_rangdte,'yyyy-mm-dd');
   insert into tmp_info(sv1,idd,nv1) select nvl(recvdate,i_yearmonth||'-'|| to_char(a.idd,'fm00')) recvdate,a.idd,nvl(b.e_total,0) e_total from tb_serial a,(
          select recvdate,to_number(substr(recvdate,9,2)) idd,e_total from(
          select to_char(recvdate,'yyyy-mm-dd') recvdate,sum(e_today) e_total from  tb_invdaily where (recvdate between v_rangdts and v_rangdte) and stationid = i_stationid  group by to_char(recvdate,'yyyy-mm-dd')
            ))b where a.idd = b.idd(+) and a.idd between 1 and v_daynum order by idd;
    select nvl(sum(e_today),0) into v_month from tb_invdaily where to_char(recvdate,'yyyy-mm') = to_char(v_rangdts,'yyyy-mm') and stationid = i_stationid;
    --�������շ�����
    if v_today>0 then
        update tmp_info set nv1 = nv1+v_today where sv1 = to_char(v_curdate,'yyyy-mm-dd');
        v_month:=v_month+v_today;
    end if;
    commit;
    select max(nv1) into v_max from tmp_info;
    v_rate:=fn_get_rate_kwh(v_max,v_unit);
    o_sumstr:=to_char(fn_get_val_kwh(v_month),'fm9999990.099')||fn_get_unit_kwh(v_month);
 open cur_power for select sv1 recvdate,idd,round(nv1 /v_rate,3) e_total,v_unit e_total_unit from tmp_info;
end sp_get_station_power_month2;
/

