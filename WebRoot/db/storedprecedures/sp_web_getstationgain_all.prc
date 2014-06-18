create or replace procedure SP_Web_GetStationGain_All(
i_stationid in number,--��վ���
curmain out sys_refcursor
) IS
/*================================================================
����˵��:��ѯָ����վ�����������
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Graphs/Yield/Total
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_gainrate number;--������̼����ϵ��
v_currency varchar2(16);
v_today number;
v_curdate date;--��վ����ʱ����ǰʱ��
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   select nvl(gainxs,0.2),nvl(money,'$') into v_gainrate,v_currency from tb_station where stationid  =i_stationid;

   insert into tmp_info(sv1,nv1) select to_char(recvdate,'yyyy') recvdate,sum(e_today) e_total from tb_invdaily
                                  where stationid = i_stationid group by to_char(recvdate,'yyyy')
                            ;
   v_today:=fn_get_station_e_today(i_stationid);
   if v_today >0 then
      update tmp_info set nv1 = nv1+v_today where sv1 = to_char(v_curdate,'yyyy');
   end if;
   commit;
   open curmain for select sv1 recvdate,round(nv1*v_gainrate,1) Gainval,v_currency unit from  tmp_info order by recvdate;
end SP_Web_GetStationGain_All;
/

