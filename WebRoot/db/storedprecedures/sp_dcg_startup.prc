create or replace procedure sp_dcg_startup(
i_dcgatename varchar2
) is
--DCG���������¼�
v_curdate date;--��վ����ʱ����ǰʱ��
begin
   for cut in(select psno,stationid from tb_pmu where upper(curgate) = upper(i_dcgatename) and state = 1) loop
      v_curdate:=fn_get_station_local_date(cut.stationid);--��øõ�վ������ʱ���ĵ�ǰʱ��
      sp_dcg_pmu_offlineex(cut.stationid,cut.psno,v_curdate);
   end loop;
end sp_dcg_startup;
/

