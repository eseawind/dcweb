create or replace procedure sp_web_getstationdynamic(
i_stationid in number,--��վ���
cur_result out sys_refcursor--���ؽ����
) is
/*================================================================
����˵��:��ȡ��վ��̬��Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:�û���¼�󣬽������ĵ�վ����ֵĸ�ͼ��ҳ���Ϸ�����վͼ����ϵ�ͳ����Ϣ
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_curdate date;--��վ����ʱ����ǰʱ��
v_timezone number;
v_total number;
v_today number;
v_month number;--���·�����
v_eventtnum number;
v_event0num number;
v_pmutnum number;
v_pmu1num number;
v_invtnum number;
v_inv1num number;
v_currency varchar2(16);
v_rownum number;
begin
    select count(1) into v_rownum from tb_station where stationid = i_stationid;
    if v_rownum >0 then
    select nvl(sum(e_today),0) into v_total from tb_invdaily where stationid = i_stationid;
    select timezone,nvl(money,'$')  into v_timezone,v_currency from tb_station where stationid = i_stationid;
    select GetLocalCurrentDatetime(v_timezone) into v_curdate from dual;
    select nvl(sum(e_today),0) into v_month from tb_invdaily where stationid = i_stationid and to_char(recvdate,'yyyy-mm') = to_char(v_curdate,'yyyy-mm');
    vp_get_station_info(i_stationid,v_pmutnum,v_pmu1num,v_invtnum,v_inv1num,v_eventtnum,v_event0num);
    v_today:=fn_get_station_e_today(i_stationid);
    v_month:=v_month+v_today;
    v_total:=v_total+v_today;
    open cur_result for
        select stationname,iconindex,fn_get_val_kwh(v_today) e_today,fn_get_unit_kwh(v_today) e_today_unit,fn_get_val_kwh(v_month) e_month,fn_get_unit_kwh(v_month) e_month_unit,fn_get_val_kwh(v_total) e_total,fn_get_unit_kwh(v_total) e_total_unit,fn_get_val_weight(v_total*co2xs) co2val,fn_get_unit_weight(v_total*co2xs) co2val_unit,trunc(v_total * gainxs,2) inval,v_currency inval_unit,v_pmu1num pmu1num,v_pmutnum pmutnum,v_inv1num inv1num,v_invtnum invtnum,v_event0num eve0num,v_eventtnum evetnum,bgurl,nvl(to_char(ludt,'yyyy-mm-dd hh24:mi:ss'),'2001-01-01 00:00:00') ludt,nvl(b.firstname,'') firstname,nvl(b.secondname,'') secondname,to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') curdt,account
        from tb_station a,tb_user b
        where a.stationid = i_stationid and a.masterid=b.userid(+);
    end if;
end sp_web_getstationdynamic;
/

