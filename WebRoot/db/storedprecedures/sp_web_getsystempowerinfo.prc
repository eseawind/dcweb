create or replace procedure sp_web_getsystempowerinfo(
cur_result out sys_refcursor--��������
   ) is
/*================================================================
����˵��:���ϵͳȫ�ַ�����ͳ����Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:��վ��ҳ
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
 v_co2rate number;--
v_stationnum_yesterday number;
v_stationnum number;
v_power_yesterday number;
v_power_total number;
v_co2_yesterday number;
v_co2_total number;

begin
  select nvl(count(1),0) into v_stationnum_yesterday from tb_station where trunc(createdt) = trunc(sysdate-1);
  select nvl(count(1),0) into v_stationnum from tb_station;
  select nvl(sum(e_today),0),nvl(sum(e_total),0) into v_power_yesterday,v_power_total from tb_invdaily where trunc(recvdate) = trunc(sysdate-1);
  select nvl(sum(e_today),0) into v_power_total from tb_invdaily;
  v_Co2Rate := to_number(fn_get_sys_param('sys_default','co2rate','0.0'));
  v_co2_yesterday :=v_power_yesterday * v_co2rate;
  v_co2_total :=v_power_total *  v_co2Rate;
  open cur_result for select v_stationnum_yesterday station_last,v_stationnum station_total,
                             fn_get_val_kwh(v_power_yesterday) e_last,fn_get_unit_kwh(v_power_yesterday) e_last_u,
                             fn_get_val_kwh(v_power_total) e_total,fn_get_unit_kwh(v_power_total) e_total_u,
                             fn_get_val_weight(v_co2_yesterday) co2_last,fn_get_unit_weight(v_co2_yesterday) co2_last_u,
                             fn_get_val_weight(v_co2_total) co2_total,fn_get_unit_weight(v_co2_total) co2_total_u from dual;
end sp_web_getsystempowerinfo;
/

