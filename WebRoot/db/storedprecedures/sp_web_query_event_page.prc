create or replace procedure sp_web_query_event_page(
i_msgtype number,-- -1:ȫ��,1:��Ϣ,2:����,3:����
i_state number,-- -1:ȫ��,0:δ����1:�Ѿ���
i_desc varchar2,--null:ȫ��
i_ssno varchar2,--null:ȫ��
i_startdt varchar2,--Ĭ��Ϊ���ռ�ȥ7��
i_enddt varchar2,--Ĭ�ϵ���
i_stationname varchar2,--null:ȫ��
i_country number,-- -1:ȫ��
i_devtype number,-- -1:ȫ��,1:�����,2:�����
i_rowperpage number ,--ÿҳ����
i_pos number default 1,--��ǰ����,Ϊ0:��ʾ����ҳ��ѯ���з��������ļ�¼
o_pages out number,--������ҳ��
cur_result out sys_refcursor
) is
v_startdt varchar2(30);
v_enddt varchar2(30);
v_rownum  number;
v_rowperpage number;
begin
  v_startdt :=substr(i_startdt,1,10);
  v_enddt:=substr(i_enddt,1,10);
  if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
  else v_rowperpage:=3;
  end if;
  select count(1) into v_rownum from (select 1 from
      (select stationid,val1,val2 from tb_event_all where
          (val1 = i_msgtype or i_msgtype =-1 ) and
          (l_tag = i_state or i_state =-1) and
          (ssno =upper(i_ssno) or i_ssno is null) and
          ( devt = i_devtype or i_devtype =-1)  and
          (occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss'))
      ) a,
      (select stationid from tb_station where
          (i_stationname is null or stationname like '%'||i_stationname||'%') and
          (i_country =-1 or country = i_country)
       ) b,
      (select val1,val2 from tb_dict_ssiis where subtag = 'pmuerrcode' and language = 'zh_CN' and
          (i_desc is null or context like '%'||i_desc||'%')
       ) c
       where a.stationid=b.stationid and a.val1 = c.val1 and a.val2= c.val2);
    o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
    if o_pages<=0  then o_pages:=1;end if;
    --
    open cur_result for select * from(select rownum rn,x.* from(select b.stationname,a.ssno,decode(a.val1,1,'��Ϣ',2,'����',3,'����','����') msgtype,a.occdt,c.context msg_desc,b.country,b.city,a.devt  from
      (
      select stationid,ssno,to_char(occdt,'yyyy-mm-dd hh24:mi:ss') occdt,val1,val2,devt from tb_event_all where
          (i_msgtype =-1 or val1 = i_msgtype) and
          (i_state =-1 or l_tag = i_state) and
          (i_ssno is null or ssno =upper(i_ssno)) and
          (occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss')) and
          (i_devtype =-1 or devt = i_devtype) order by occdt desc
      ) a,
      (
         select u.stationid,u.stationname,v.context country,u.city from (select stationid,stationname,country,city from tb_station where
             (i_stationname is null or stationname like '%'||i_stationname||'%') and
             (i_country =-1 or country = i_country)) u,
             (select val1,context from tb_dict_ssiis where subtag = 'webcountrylist' and language ='zh_CN') v where u.country = v.val1(+)

      ) b,
      (select context,val1,val2 from tb_dict_ssiis where subtag = 'pmuerrcode' and language = 'zh_CN' and
          (i_desc is null or context like '%'||i_desc||'%')
       ) c
       where a.stationid=b.stationid and a.val1 = c.val1 and a.val2= c.val2)x) where i_pos=0 or (rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage);
end sp_web_query_event_page;
/

