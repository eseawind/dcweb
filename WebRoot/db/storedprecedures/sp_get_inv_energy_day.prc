create or replace procedure sp_get_inv_energy_day(
i_stationid number,--��վ���
i_isnolist varchar2,--���кű��
i_yearmonthday in varchar2,--�����ѯ����
cur_result out sys_refcursor--��������
) is
/*================================================================
����˵��:��ѯָ����վ,ָ���������ָ�����ڵ�10���ӷ�����(PAC)����
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Graphs/Energy&Power/Day
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_tablename varchar2(32);
v_querydate date;
v_maxpac number;
v_unit varchar2(16);
v_rate number;
v_sql varchar2(1000);
begin
   execute immediate 'truncate table tmp_info';
   v_querydate := to_date(i_yearmonthday,'yyyy-mm-dd');
   v_tablename:='tb_inv' || to_char(v_querydate,'yyyymmdd');
   --
   for curt in (select nvl(byname,isno)byname ,isno from tb_inverter where stationid = i_stationid) loop
      if instr(i_isnolist,curt.isno,1,1)>0 or (SUBSTR (i_isnolist,1,7)='23Q0001' and SUBSTR (curt.isno,1,7)='23Q0001' ) then
         v_sql := 'insert into tmp_info(sv1,sv2,nv1,nv2,nv3)
         select :isno__ isno,fn_gettimebyfen10(a.idd) rtime,a.idd fen10,nvl(b.pac,0) pac,nvl(b.pdc,0) pdc from
            tb_serial a,
            (
               select fen10,avg(pac) pac,avg(ppv1+ppv2+ppv3) pdc from  ' || v_tablename||'
               where isno = :isno_ and stationid=:stationid_ group by fen10
               ) b
          where a.idd = b.fen10(+) order by fen10 asc';
          execute immediate v_sql using curt.byname,curt.isno,i_stationid;
      end if;
   end loop;
  -- select nvl(max(nv2),0) into v_maxpac from tmp_info ;
   execute immediate 'select max(pac) from '||v_tablename ||' where stationid=:stationid_' into v_maxpac  using i_stationid ;
   v_rate:=fn_get_rate_power(v_maxpac,v_unit);
   commit;
   open cur_result for select sv1 isno,sv2 rtime,nv1 fen10,round(nv2/v_rate,3) data1/*pac*/,round(nv3/v_rate,3) data2,v_unit unit,1 res_num from tmp_info order by isno,fen10;
end sp_get_inv_energy_day;
/

