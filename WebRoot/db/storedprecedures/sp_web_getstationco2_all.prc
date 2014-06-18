create or replace procedure SP_Web_GetStationCo2_ALL(
i_stationid in number,--��վ���
curmain out sys_refcursor
) IS
/*================================================================
����˵��:ͳ��ָ����վ����Ķ�����̼���������
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Graphs/Co2/Year
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_co2rate number;--������̼����ϵ��
v_today number;
v_m number;
v_r number;
v_u varchar2(10);
v_curdate date;--��վ����ʱ����ǰʱ��
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   select nvl(co2xs,0.2) into v_co2rate from tb_station where stationid  =i_stationid;
   insert into tmp_info(sv1,nv1)
          select to_char(recvdate,'yyyy') recvdate,sum(e_today) e_total from tb_invdaily
                                  where stationid = i_stationid group by to_char(recvdate,'yyyy');
   v_today:=fn_get_station_e_today(i_stationid);
   if v_today >0 then
      update tmp_info set nv1 = nv1+v_today where sv1 = to_char(v_curdate,'yyyy');
   end if;
   commit;
   select max(nv1*v_co2rate) into v_m from tmp_info;
   v_r:=fn_get_rate_weight(v_m,v_u);
   open curmain for select sv1 recvdate,round(nv1*v_co2rate/v_r,2) co2val,v_u unit from tmp_info order by recvdate;
end SP_Web_GetStationCo2_ALL;
/

