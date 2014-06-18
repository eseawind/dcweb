create or replace procedure mp_recalc_dailyexex(
--重新指定日期所有电站日统计数据
--i_stationid number,--电站编号
i_date varchar2,--重算日期,
i_dateend varchar2--重新计算结束日期
) is
v_date date;
v_daynum number;--天数
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

