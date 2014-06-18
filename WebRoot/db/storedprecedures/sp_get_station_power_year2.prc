create or replace procedure sp_get_station_power_year2(
i_stationid number,--Ҫ��ѯ�ĵ�վ���
i_year varchar2,--Ҫ��ѯ�����
o_startdt out varchar2,--�����ѯ��Χ�Ŀ�ʼ����
o_enddt out varchar2,--�����ѯ��Χ�Ľ�������
o_sumstr out varchar2,--���ܽ�����
cur_power out sys_refcursor--��ѯ��������
) is
--��ȡһ���ڸ��·�������Ϣ
v_rangdts date;
v_rangdte date;
v_year number;
v_max number;
v_unit varchar2(10);
v_rate number;
v_years number;
v_today number;--���շ�����
v_curdate date;--��վ����ʱ����ǰʱ��
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   --
   if i_year = to_char(v_curdate,'yyyy') then
      v_today:=fn_get_station_e_today(i_stationid);
   else
      v_today:=0;
   end if;
   v_year:=to_number(i_year);
   if v_year > 2000  and v_year < 2050 then
      v_rangdts:=to_date(i_year||'-01-01','yyyy-mm-dd');
      v_rangdte :=to_date(i_year||'-12-31','yyyy-mm-dd');
      o_startdt :=to_char(v_rangdts,'yyyy-mm-dd');
      o_enddt:=to_char(v_rangdte,'yyyy-mm-dd');
      insert into tmp_info(sv1,idd,nv1) select nvl(b.recvdate,v_year||'-'||to_char(a.idd,'fm00')) recvdate,a.idd,nvl(b.e_total,0) e_total from tb_serial a,(
           select recvdate,to_number(substr(recvdate,6,2)) idd,e_total from(
                 select to_char(recvdate,'yyyy-mm') recvdate,sum(e_today) e_total from  tb_invdaily where (recvdate between v_rangdts and v_rangdte) and stationid = i_stationid  group by to_char(recvdate,'yyyy-mm')
                 )
           )b where a.idd = b.idd(+) and a.idd between 1 and 12 order by idd;

      select nvl(sum(e_today),0) into v_years from tb_invdaily where to_char(recvdate,'yyyy') = to_char(v_rangdts,'yyyy') and stationid = i_stationid;
      --�������շ�����
      if v_today > 0 then
          update tmp_info set nv1 = nv1+v_today where sv1 = to_char(v_curdate,'yyyy-mm');
          commit;
          v_years:=v_years+v_today;
      end if;
/*-----�˶�����--����ƽ--����-----2012-08-09---------
      update tmp_info set nv1 = 100 where sv1 = '2012-01';
      update tmp_info set nv1 = 100 where sv1 = '2012-02';
      update tmp_info set nv1 = 100 where sv1 = '2012-09';
      update tmp_info set nv1 = 100 where sv1 = '2012-10';
      update tmp_info set nv1 = 100 where sv1 = '2012-11';
      update tmp_info set nv1 = 100 where sv1 = '2012-12';
--------------------------------2012-08-09-----------
      commit;*/
      commit;
      select max(nv1) into v_max from tmp_info;
      v_rate:=fn_get_rate_kwh(v_max,v_unit);
      o_sumstr:=to_char(fn_get_val_kwh(v_years),'fm9999990.099')||fn_get_unit_kwh(v_years);
      open cur_power for select sv1 recvdate,idd,round(nv1/v_rate,3) e_total,v_unit e_total_unit from tmp_info;
   end if;
end sp_get_station_power_year2;
/

