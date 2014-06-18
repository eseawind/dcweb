create or replace procedure SP_Web_GetStationCo2_7Day(
i_stationid in number,--��վ���
i_date in varchar2,--��ʼ����
curmain out sys_refcursor--��ѯ�����
) IS
/*================================================================
����˵��:��ѯָ����վָ���������ڵ�ǰ����Ķ�����̼������
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Graphs/Co2/7 Days
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
v_co2rate number;
v_e_today number;
v_m number;
v_r number;
v_u varchar2(10);
v_curdate date;--��վ����ʱ����ǰʱ��
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   --
   v_querydate := to_date(i_date,'yyyy-mm-dd');
   v_rangdts:=v_querydate-6;
   v_rangdte:=v_querydate;
   --
   select nvl(co2xs,0.2) into v_co2rate from tb_station where stationid  =i_stationid;
   insert into tmp_info(sv1,nv1)
                          select to_char(nvl(b.recvdate,v_querydate+c.idd-7),'yyyy-mm-dd'),nvl(b.co2val,0) from
                                   (select idd from tb_serial where idd between 1 and 7) c,
                                   (select recvdate+7-v_querydate dayid,a.* from
                                          (select recvdate,sum(e_today)*v_co2rate co2val from tb_invdaily where (recvdate between v_rangdts and v_rangdte) and stationid = i_stationid group by recvdate
                                           ) a ) b
                                    where c.idd =b.dayid(+);
   v_e_today:=fn_get_station_e_today(i_stationid);
   if v_e_today>0 then
      update tmp_info set nv1 = nv1+v_e_today*v_co2rate where sv1 = to_char(v_curdate,'yyyy-mm-dd');
   end if;
   commit;
   select max(nv1) into v_m from tmp_info;
   v_r:=fn_get_rate_weight(v_m,v_u);
   open curmain for select sv1 recvdate,round(nv1/v_r,2) co2val,v_u unit from tmp_info order by recvdate;
end SP_Web_GetStationCo2_7Day;
/

