create or replace procedure sp_get_stationinfo(
i_stationid in number,
cur_result out sys_refcursor
) is
v_e_today number;
v_e_total number;
v_lastupdate date;
v_curdate date;--电站所在时区当前时间
v_timezone number;
v_tablename varchar2(32);--当天电量所在的表名称
v_sql varchar(200);--SQL
begin
    select ludt,timezone into v_lastupdate,v_timezone from tb_station where stationid = i_stationid;
    select nvl(sum(e_today),0) into v_e_total from tb_invdaily where stationid = i_stationid;
    select GetLocalCurrentDatetime(v_timezone) into v_curdate from dual;
    v_tablename:='tb_inv' || to_char(v_curdate,'yyyymmdd');
    v_sql:='select nvl(max(e_today),0) from '  || v_tablename ||' where stationid = :stationid_';
    execute immediate v_sql into v_e_today using i_stationid;
   open cur_result for select fn_get_val_kwh(v_e_today) e_today,fn_get_unit_kwh(v_e_today) e_today_u,
                              fn_get_val_kwh(v_e_total) e_total,fn_get_unit_kwh(v_e_total) e_total_u,
                              v_lastupdate ludt from dual;
end sp_get_stationinfo;
/

