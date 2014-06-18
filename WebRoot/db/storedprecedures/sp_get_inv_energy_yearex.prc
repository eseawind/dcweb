create or replace procedure sp_get_inv_energy_yearex(
i_stationid number,
i_isnolist varchar2,
i_year varchar2,--�����ѯ����
o_startdt out varchar2,
o_enddt out varchar2,
cur_result out sys_refcursor--��������
) is
/*================================================================
����˵��:��ѯָ����վ,ָ��������б�ָ����ݸ��µķ��������
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Graphs/Energy&Power/Year
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_rangdts date;
v_rangdte date;
v_year number;
v_max number;
v_unit varchar2(10);
v_rate number;
v_today number;--��������շ�����
v_curdate date;--��վ����ʱ����ǰʱ��
begin
  execute immediate 'truncate table tmp_info';
  v_curdate:=fn_get_station_local_date(i_stationid);
  --
  v_year:=to_number(i_year);
  if v_year > 2000  and v_year < 2050 then
     v_rangdts:=to_date(i_year||'-01-01','yyyy-mm-dd');
     v_rangdte :=last_day(to_date(i_year||'-12-01','yyyy-mm-dd'));
     o_startdt :=to_char(v_rangdts,'yyyy-mm-dd');
     o_enddt:=to_char(v_rangdte,'yyyy-mm-dd');
     for curt in (select nvl(byname,isno) byname,isno from tb_inverter where stationid = i_stationid) loop
        if instr(i_isnolist,curt.isno,1,1)>0  or (SUBSTR (i_isnolist,1,7)='23Q0001' and SUBSTR (curt.isno,1,7)='23Q0001' )  then
        insert into tmp_info(sv1,sv2,sv3,idd,nv1)
           select curt.isno,curt.byname,nvl(b.recvdate,v_year||'-'||to_char(a.idd,'fm00')) recvdate,a.idd,nvl(b.e_total,0) e_total from
              (select idd from tb_serial where idd between 1 and 12)a,
              (select recvdate,to_number(substr(recvdate,6,2)) idd,e_total from(
                  select to_char(recvdate,'yyyy-mm') recvdate,sum(e_today) e_total from  tb_invdaily
                       where (recvdate between v_rangdts and v_rangdte) and isno = curt.isno and stationid = i_stationid
                       group by to_char(recvdate,'yyyy-mm')
                 )
           )b where a.idd = b.idd(+) order by idd;
           if i_year = to_char(v_curdate,'yyyy')then
              v_today:=fn_get_inv_e_today(curt.isno,i_stationid);
              if v_today >0 then
                 update tmp_info set nv1 = nv1+v_today where sv3 = to_char(v_curdate,'yyyy-mm') and sv1 = curt.isno;
              end if;
           end if;
       end if;
     end loop;
     commit;
     select max(nv1) into v_max from tmp_info;
     v_rate:=fn_get_rate_kwh(v_max,v_unit);
     open cur_result for select sv1 isno,sv2 byname,sv3 recvdate,idd,round(nv1/v_rate,3) data1/*e_total*/,v_unit e_total_unit,1 res_num from tmp_info order by sv1,sv3;
  end if;
end sp_get_inv_energy_yearex;
/

