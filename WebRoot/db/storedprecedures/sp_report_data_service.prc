create or replace procedure sp_report_data_service(
i_stationid number,--��վ���
i_reportid number,--������,1:ÿ�ձ���,2:ÿ�±���,3:�¼�����
i_itemstr varchar2,--���������ַ���

/*
a,b,c,d,e,f,g,h,i,j,k
1:=========================ÿ�ձ���
a:���շ�����
b:���շ������PAC_MAX
c:��������
d:����Co2����
e:�ܷ�����
f:������
g:��C02������
2:========================ÿ�±���
a:���·�����
b:���·�������ֵ
c:��������
d:����c02
e:�ܷ�����
f:������
g:��c02����
3:========================�¼�����
a:û���¼����Ƿ��ͱ���,1:���ͣ�0:������
b:���ʼ�������¼�����,Ϊ�¼���ֵ
c:��Ϣ�Ƿ���,1�����ͣ�0:������
d:�����Ƿ���,1:���ͣ�0:������
e:��ʼʱ��
f:����ʱ��
g:��������
example:1,1,100,1,2012-06-27 00:00:00,2012-06-27 23:59:59,en_US


*/
cur_main out sys_refcursor,
cur_slaver out sys_refcursor
) is
/*================================================================
����˵��:�ʼ����淢�����ݷ���
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:�գ���,�¼��������ݷ���
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_sql varchar2(1000);
v_tablename varchar2(32);--����������ڵı�����
/*-------------�ձ������---------�±������-------------�¼�����*/
v_val1 number;/*�ۼƷ�����--------�ۼƷ�����-------------masterid*/
v_val2 number;/*ʱ��--------------ʱ��-------------------��Ϣ�Ƿ���*/
v_val3 number;/*���շ�����--------���·�����-------------�����Ƿ���*/
v_val4 number;/*����ϵ��----------����ϵ��----------------�¼�����-------*/
v_val5 number;/*Co2ϵ��-----------Co2ϵ��------------------------*/
v_val6 number;/*max pac-----------��󷢵���ֵ-------------------*/
v_val7 number;/*pac ת��ϵ��------��������ʾϵ��-----------------*/
v_val8 number;/*masterid----------��ѯ������---------------------*/
v_val9 number;/*------------------masterid-----------------------*/
v_str1 varchar2(30);/*���ҷ���----���ҷ���---------------��������*/
v_str2 varchar2(60);/*PAC��λ-----��������λ-------------�û�����*/
v_str3 varchar2(60);/*�û�����----�·�-------------------�û�����*/
v_str4 varchar2(60);/*�û�����----�û�����---------------��վ����*/
v_str5 varchar2(60);/*��վ����----�û�����-----------------------*/
v_str6 varchar2(60);/*------------��վ����-----------------------*/
v_date1 date;/*��������-----------���¿�ʼ����---�¼���ʼ����----*/
v_date2 date;/*-------------------���½�������---�¼���������----*/
v_temp number;
v_etotaloffset number;
begin
   if i_reportid = 1 then
     --�ձ���ֻ���͵���ı���
     select nvl(sum(e_today),0) into v_val1 from tb_invdaily where stationid = i_stationid;
     select timezone,nvl(money,'$'),co2xs,gainxs,masterid,stationname,etotaloffset  into v_val2,v_str1,v_val5,v_val4,v_val8,v_str5,v_etotaloffset from tb_station where stationid = i_stationid;
     select firstname,secondname into v_str3,v_str4 from tb_user where userid = v_val8;
     select GetLocalCurrentDatetime(v_val2) into v_date1 from dual;
     --v_date1 :=to_date('2013-03-05 18:30:30','yyyy-mm-dd hh24:mi:ss');
     v_temp := (v_date1-trunc(v_date1))*24;
     --���ݵ�ǰ�û�����ʱ���ж�,��06:30֮ǰ��ʱ��Ϊ������ձ�,֮��Ϊ�����ձ�
     if v_temp <6.5 then
        v_date1:=v_date1 -1;
     end if;
     v_tablename:='tb_inv' || to_char(v_date1,'yyyymmdd');
     execute immediate 'select nvl(sum(e_today),0) from (select isno,max(e_today) e_today from '||v_tablename ||' where stationid = :stationid group by isno)'
             into v_val3 using i_stationid;
     v_val1:=v_val1+v_val3 + v_etotaloffset;
     execute immediate 'truncate table tmp_info';
     v_sql := 'insert into tmp_info(sv1,nv1,nv2)
               select fn_gettimebyfen10(a.idd) rtime,a.idd fen10,nvl(b.pac,0) pac from
                           tb_serial a,
                           ( select  fen10,sum(pac) pac from
                                     ( select isno,fen10,round(avg(pac),1) pac from  ' || v_tablename||'
                                             where stationid = :stationid__ group by isno,fen10 )
                                     group by fen10 order by fen10) b
                 where a.idd = b.fen10(+) order by fen10 asc';
       execute immediate v_sql using i_stationid;
       commit;
       select max(nv2) into v_val6 from tmp_info;
      open cur_main for select  v_str3 firstname,v_str4 secondname,v_str5 stationname,to_char(fn_get_val_kwh(v_val3),'fm9999999990.00')||fn_get_unit_kwh(v_val3) e_today,
                               to_char(fn_get_val_w(v_val6),'fm9999999990.00')||fn_get_unit_w(v_val6) power_max,
                               to_char(v_val3 * v_val4,'fm9999999990.00')||v_str1 in_today,
                               to_char(fn_get_val_weight(v_val3*v_val5),'fm9999999990.00')||fn_get_unit_weight(v_val3*v_val5) Co2_today,
                               to_char(fn_get_val_kwh(v_val1),'fm9999999990.00')||fn_get_unit_kwh(v_val1) e_total,
                               to_char(v_val1*v_val4,'fm9999999990.00')||v_str1 in_Total,
                               to_char(fn_get_val_weight(v_val1*v_val5),'fm9999999990.00')||fn_get_unit_weight(v_val1*v_val5) co2_total,
                               to_char(v_date1,'yyyy-mm-dd') startdt,
                               to_char(v_date1,'yyyy-mm-dd') enddt
                        from dual;
      v_val7:=fn_get_rate_power(v_val6,v_str2);
      open cur_slaver for select sv1 rtime,nv1 fen10,round(nv2/v_val7,3) pac,v_str2 unit from tmp_info;
--===============================================================================================================================
   elsif i_reportid=2 then
   --��ǰ������������������С��3��������һ���µı��棬���>3�죬�򷢵��µ��±�
   select timezone,nvl(money,'$'),co2xs,gainxs,masterid,stationname,etotaloffset  into v_val2,v_str1,v_val5,v_val4,v_val9,v_str6,v_etotaloffset from tb_station where stationid = i_stationid;
   select firstname,secondname into v_str4,v_str5 from tb_user where userid = v_val9;
     select nvl(sum(e_today),0) into v_val1 from tb_invdaily where stationid = i_stationid;
     v_val1:= v_val1 + v_etotaloffset;
     --�ж�ȡ���µĻ������µ�����
     select GetLocalCurrentDatetime(v_val2) into v_date1 from dual;
     if to_number(to_char(v_date1,'dd'))<3 then
         v_date1:=add_months(v_date1,-1);
     end if;
     v_date1:=to_date(to_char(v_date1,'yyyy-mm')||'-01','yyyy-mm-dd');
     v_date2:=last_day(v_date1);
     v_val8 :=to_number(to_char(last_day(v_date1),'dd'));
     execute immediate 'truncate table tmp_info';
     insert into tmp_info(sv1,idd,nv1) select nvl(recvdate,to_char(v_date1,'yyyy-mm')||'-'|| to_char(a.idd,'fm00')) recvdate,a.idd,nvl(b.e_total,0) e_total from tb_serial a,(
                               select recvdate,to_number(substr(recvdate,9,2)) idd,e_total from(
                                     select to_char(recvdate,'yyyy-mm-dd') recvdate,sum(e_today) e_total from  tb_invdaily where (recvdate between v_date1 and v_date2) and stationid = i_stationid  group by to_char(recvdate,'yyyy-mm-dd')
                                     )
                               )b where a.idd = b.idd(+) and a.idd between 1 and v_val8 order by idd;
     commit;
     select max(nv1) into v_val6 from tmp_info;
     v_str3:=to_char(v_date1,'yyyy-mm');
     select nvl(sum(e_today),0) into v_val3 from tb_invdaily where stationid = i_stationid and to_char(recvdate,'yyyy-mm') = v_str3;
     open cur_main for select
                       v_str4 firstname,v_str5 secondname,v_str6 stationname,
                       fn_get_val_kwh(v_val3)||fn_get_unit_kwh(v_val3) e_month,
                       fn_get_val_kwh(v_val6)||fn_get_unit_kwh(v_val6) pac_max,
                       trunc(v_val3 * v_val4,2)||v_str1 in_month,
                       fn_get_val_weight(v_val3*v_val5)||fn_get_unit_weight(v_val3*v_val5) co2_month,
                       fn_get_val_kwh(v_val1)||fn_get_unit_kwh(v_val1) e_total,
                       trunc(v_val1*v_val4,2)||v_str1 in_Total,
                       fn_get_val_weight(v_val1*v_val5)||fn_get_unit_weight(v_val1*v_val5) co2_total,
                       to_char(v_date1,'mm/yyyy')  startdt,
                       to_char(v_date2,'mm/yyyy')  enddt
                       from dual;
     v_val7:=fn_get_rate_kwh(v_val6,v_str2);
     open cur_slaver for select sv1 recvdate,idd,round(nv1 /v_val7,3) e_total,v_str2 e_total_unit from tmp_info;
--===============================================================================================================================
   elsif i_reportid =3 then
   --�����¼������ʱ�䷶Χȡ���ڲ�����ָ��������ʱ�䷶Χ
     v_date1:=to_date(fn_getmidstr(i_itemstr,5,','),'yyyy-mm-dd hh24:mi:ss');
     v_date2:=to_date(fn_getmidstr(i_itemstr,6,','),'yyyy-mm-dd hh24:mi:ss');
     v_val4:=to_number(fn_getmidstr(i_itemstr,2,','));
     if to_number(fn_getmidstr(i_itemstr,3,','))= 1 then
        v_val2:=1;
     else
        v_val2:=0;
     end if;
     if to_number(fn_getmidstr(i_itemstr,4,','))=1 then
        v_val3:=3;
     else
       v_val3:=0;
     end if;
     v_str1:=fn_getmidstr(i_itemstr,7,',');
     select masterid,stationname  into v_val1,v_str4 from tb_station where stationid = i_stationid;
     select firstname,secondname into v_str2,v_str3 from tb_user where userid = v_val1;
     open cur_main for select v_str2 firstname,v_str3 secondname,v_str4 stationname,to_char(v_date1,'dd/mm/yyyy') startdt,to_char(v_date2,'dd/mm/yyyy') enddt from dual;
     open cur_slaver for select a.did,a.ssno,decode(v_str1,'zh_CN',decode(a.val1,1,'��Ϣ',2,'����',3,'����',to_char(a.val1)),decode(a.val1,1,'info',2,'warring',3,'error',to_char(a.val1))) msgtype,a.occdt,nvl(b.context,to_char(a.val2)) context
       from  (select did,ssno,val1,val2,occdt from tb_event_all where (occdt between v_date1 and v_date2)and ssno in (select isno ssno from tb_inverter where stationid = i_stationid) and stationid=i_stationid and c_tag = 0 and val1 in(v_val2,v_val3) and rownum < v_val4 order by did desc)a,
             (select val1,val2,context from tb_dict_ssiis where language=v_str1 and subtag = 'pmuerrcode')b
       where (a.val2 =b.val2(+)) and a.val1=b.val1 order by  occdt;
   else
     open cur_main for select 1,1,1 from dual;
   end if;

end sp_report_data_service;
/

