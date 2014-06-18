create or replace procedure SP_Web_GetStationCo2_12M(
i_stationid in number,--��վ���
i_yearmonth in varchar2,--��ѯ������
curmain out sys_refcursor--��ѯ�����
) IS
/*================================================================
����˵��:��ѯָ������֮ǰ12����(������ָ�����·�)���¶�����̼���������
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Graphs/Co2/12 Months
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_querydate date;
v_rangdts date;
v_rangdte date;
v_month number;
v_year number;
v_co2rate number;--������̼����ϵ��
v_m number;
v_r number;
v_u varchar2(10);
v_today number;
v_curdate date;--��վ����ʱ����ǰʱ��
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   --
   v_querydate := to_date(i_yearmonth||'-01','yyyy-mm-dd');
   v_month:=to_number(to_char(v_querydate,'mm'));
   v_year:=to_number(to_char(v_querydate,'yyyy'));
   v_rangdts:=last_day(Add_months(v_querydate,-12))+1;
   v_rangdte:=last_day(v_querydate);
   select nvl(co2xs,0.2)  into v_co2rate from tb_station where stationid  =i_stationid;
   insert into tmp_info(sv1,nv1) select nvl(b.recvdate,fn_get_yearmonth(v_year,v_month,a.idd)) recvdate,nvl(b.e_total,0) e_total from(select idd from tb_serial where idd between 1 and 12)a,
                           (select recvdate,to_number(substr(recvdate,6,2)) mid,e_total from ( select to_char(recvdate,'yyyy-mm') recvdate,sum(e_today) e_total from tb_invdaily
                                  where (recvdate between v_rangdts and v_rangdte) and stationid = i_stationid group by to_char(recvdate,'yyyy-mm')
                            ))b where a.idd = b.mid(+) ;
   v_today:=fn_get_station_e_today(i_stationid);
   if v_today>0 then
      update tmp_info set nv1 = nv1+v_today where sv1 = to_char(v_curdate,'yyyy-mm');
   end if;
   commit;
   select max(nv1*v_co2rate) into v_m from tmp_info;
   v_r:=fn_get_rate_weight(v_m,v_u);
   open curmain for select sv1 recvdate,round(nv1*v_co2rate/v_r,2) co2val,v_u unit from tmp_info order by recvdate;
end SP_Web_GetStationCo2_12M;
/

