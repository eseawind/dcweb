create or replace procedure sp_web_getstationdevice(
i_stationid number,--��վ���
cur_list out sys_refcursor --�豸�б�
) is
--Ϊ��վ�ṩ���豸�б��ѯ
begin
  open cur_list for select isno ssno,nvl(byname,isno) byname,2 devt from tb_inverter where stationid = i_stationid union
  select psno ssno,nvl(byname,psno) byname,1 devt from tb_pmu where stationid = i_stationid order by devt,ssno;
end sp_web_getstationdevice;
/

