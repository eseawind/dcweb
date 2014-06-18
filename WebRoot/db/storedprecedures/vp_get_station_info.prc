create or replace procedure vp_get_station_info(
--ͳ��ָ����վ��̬��Ϣ
i_stationid in number,
o_pmut out number,--�ܹ�PMU��Ŀ
o_pmu1 out number,--����PMU��Ŀ
o_invt out number,--�ܹ�INV��Ŀ
o_inv1 out number,--����INV��Ŀ
o_eventt out number,--�ܹ��¼�����
o_event0 out number--δ���¼�����
) is
begin
   select count(1) into o_eventt from tb_event_all
      where stationid =i_stationid /*and ssno in (
         select isno ssno from tb_inverter where stationid = i_stationid union
         select psno ssno from tb_pmu where stationid = i_stationid)*/
      and c_tag =0;
   --δ��ȡ���¼���ĿVal1:--1:��Ϣ,2:����,3:����
   select count(1) into o_event0 from tb_event_all
      where stationid = i_stationid /*and ssno in (
         select isno ssno from tb_inverter where stationid = i_stationid union
         select psno ssno from tb_pmu where stationid = i_stationid)*/
      and val1=3 and l_tag=0 and c_tag = 0;
   select count(1)into  o_pmut from tb_pmu where stationid = i_stationid;
   select count(1) into o_pmu1 from tb_pmu where stationid = i_stationid and state = 1 ;
   if (o_pmu1 >0) then
       select count(1) into o_inv1 from tb_inverter where stationid = i_stationid and state = 1;
    else
      o_inv1:=0;
    end if;
    select count(1) into o_invt from tb_inverter where stationid = i_stationid;
end vp_get_station_info;
/

