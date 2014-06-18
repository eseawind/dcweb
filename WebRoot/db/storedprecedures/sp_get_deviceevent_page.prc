create or replace procedure sp_get_deviceevent_page(
i_sno in varchar2,--�豸���к�
i_lan varchar2 default 'en_US',--����:en_US,zh_CN
i_rowperpage number,--ÿҳ����
i_pos number default 1,--��ǰ����
o_pages out number,--������ҳ��
cur_result out sys_refcursor) is
--����ҳ���豸�¼���ѯ
--���÷�Χ:wap,web,�ֻ��ͻ���
v_rownum  number;
v_rowperpage number;
v_stationid number;
begin
   v_stationid:=null;
   select count(1) into v_rownum from tb_inverter where isno = upper(i_sno);
   if v_rownum >0 then
      select stationid into v_stationid from tb_inverter where isno = upper(i_sno);
   else
      select count(1) into v_rownum from tb_pmu where psno = upper(i_sno);
      if v_rownum >0 then
          select stationid into v_stationid from tb_pmu where psno = upper(i_sno);
      else
        v_stationid:=null;
      end if;
   end if;
  --1:��Ϣ,2:����,3:����
   select count(1) into v_rownum from tb_event_all where ssno =i_sno and val1 <>2  and c_tag = 0 and l_tag = 0 and (v_stationid is null or v_stationid = stationid) ;
  if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
  else v_rowperpage:=3;
  end if;
  o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
      execute immediate 'truncate table tmp_station_new_event';
      insert into tmp_station_new_event(dID,msgtype,err_code,occdt,DESCRIBLE,haveread)
      select did,a.val1 msgtype,a.val2 err_code,a.occdt,nvl(b.context,to_char(a.val2)) context,a.l_tag haveread
           from
               (select * from (select c.*,rownum rn from (select did,occdt,val1,val2,l_tag from tb_event_all where  val1 <>2 and c_tag = 0 and l_tag = 0 and (v_stationid is null or v_stationid = stationid) and ssno= i_sno  order by l_tag,did desc) c)d where d.rn between ((i_pos-1)*v_rowperpage +1) and  (i_pos*v_rowperpage)) a,
               (select val1,val2,context from tb_dict_ssiis where subtag = 'pmuerrcode' and language=i_lan) b
               where a.val2 =b.val2(+) and  a.val1=b.val1;
      update tb_event_all set l_tag = 1 where did in(select did from tmp_station_new_event) and l_tag = 0;
      commit;
open cur_result for select did,msgtype,err_code,occdt,DESCRIBLE context,haveread from tmp_station_new_event;
end sp_get_deviceevent_page;
/

