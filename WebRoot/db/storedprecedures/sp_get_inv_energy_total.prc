create or replace procedure sp_get_inv_energy_total(
i_stationid number,--��վ���
i_isnolist varchar2,--���к��б�
cur_result out sys_refcursor--��������
) is
/*================================================================
����˵��:��ѯָ����վ,ָ��������б����귢�������
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Graphs/Energy&Power/Total
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_r number;--��¼����
v_u varchar2(10);
v_m number;
v_t number;--���շ�����
v_curdate date;--��վ����ʱ����ǰʱ��
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   --
   for curt in (select nvl(byname,isno) byname,isno from tb_inverter where stationid =i_stationid) loop
      if instr(i_isnolist,curt.isno,1,1)>0  or (SUBSTR (i_isnolist,1,7)='23Q0001' and SUBSTR (curt.isno,1,7)='23Q0001' )  then
         v_t:=fn_get_inv_e_today(curt.isno,i_stationid);--�����������շ�����
         select count(1) into v_r from tb_invdaily where isno =curt.isno ;
         if v_r >0 then
            insert into tmp_info(sv1,sv2,sv3,nv1,nv2)
               select curt.isno,curt.byname,year,e_total,1 from (
                  select to_char(recvdate,'yyyy') year,isno,sum(e_today) as e_total
                     from tb_invdaily
                     where  isno = curt.isno  and stationid = i_stationid
                     group by to_char(recvdate,'yyyy'));
         else
             insert into tmp_info(sv1,sv2,sv3,nv1) select curt.isno,curt.byname,a.year, b.e_val from (select distinct to_char(recvdate,'yyyy') year from tb_invdaily where stationid = i_stationid) a,(select to_char(v_curdate,'yyyy') year,v_t e_val from dual) b where a.year = b.year(+);
         end if;
         if v_t > 0 then
            update tmp_info set nv1 = nv1+v_t where sv3 = to_char(v_curdate,'yyyy') and sv1= curt.isno;
         end if;
      end if;
   end loop;
   commit;
   select max(nv1) into v_m from tmp_info;
   v_r:=fn_get_rate_kwh(v_m,v_u);
   open cur_result for select sv2 isno,sv3 year,round(nv1/v_r,3) data1/*e_total*/,v_u e_total_unit,nv2 res_num from tmp_info order by sv2,sv3;
end sp_get_inv_energy_total;
/

