create or replace procedure SP_GET_INV_VAC_7DAYex(
i_stationid number,
i_isnolist in varchar2,
i_date varchar2,
curmain out sys_refcursor
) is
/*================================================================
����˵��:��ѯָ����վ��ָ��������б���ָ������ǰ����(��������ĵ���)��Χ�ڵĵ�10���ӽ�����ѹֵ����
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Graphs/Vac/7 Days
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
   v_sql varchar2(1000);
begin
   v_querydate := to_date(i_date,'yyyy-mm-dd')-7;
   --
   execute immediate 'truncate table tmp_info';
   for daynum in 1 .. 7 loop
      v_querydate:=v_querydate+1;
      v_tablename:='tb_inv' || to_char(v_querydate,'yyyymmdd');
      for curt in (select nvl(byname,isno)byname ,isno from tb_inverter where stationid = i_stationid) loop
         if instr(i_isnolist,curt.isno,1,1)>0  or (SUBSTR (i_isnolist,1,7)='23Q0001' and SUBSTR (curt.isno,1,7)='23Q0001' ) then
            v_sql:='insert into tmp_info(idd,sv1,sv2,sv3,sv4,nv1,nv2,nv3)
                select a.idd,:isno_ ,:byname__,:date_,fn_gettimebyfen10(a.idd),nvl(b.vac1,0),nvl(b.vac2,0),nvl(b.vac3,0) from tb_serial a left join
                (select recvdate,fen10,vac1,vac2,vac3 from '||v_tablename||' where isno = :isno__) b on a.idd =b.fen10';
            execute immediate v_sql using curt.isno,curt.byname,to_char(v_querydate,'yyyy-mm-dd'),curt.isno;
         end if;
      end loop;
   end loop;
   commit;
   open curmain for select sv1 isno,sv2 byname,sv3 recvdt,sv4 rtime,idd fen10,nv1 data1/*vac1*/,nv2 data2/*vac2*/,nv3 data3/*vac3*/,'V' unit,3 res_num from tmp_info order by isno,recvdt,fen10;
end SP_GET_INV_VAC_7DAYex;
/
