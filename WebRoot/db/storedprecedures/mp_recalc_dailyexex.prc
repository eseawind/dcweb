create or replace procedure mp_recalc_dailyexex(
--����ָ���������е�վ��ͳ������
--i_stationid number,--��վ���
i_date varchar2,--��������,
i_dateend varchar2--���¼����������
) is
v_date date;
v_daynum number;--����
--v_tablename varchar2(50);
--v_sql varchar2(2000);
begin
     v_date :=to_date(i_date,'yyyy-mm-dd');
     v_daynum:=to_date(i_dateend,'yyyy-mm-dd')-v_date+1;
     for i in 1 .. v_daynum loop
         mp_recalc_dailyex(to_char(v_date,'yyyy-mm-dd'));
        -- v_tablename:=to_char(v_date,'yyyy-mm-dd');
         v_date:=v_date+1;
     end loop;
end mp_recalc_dailyexex;
/

