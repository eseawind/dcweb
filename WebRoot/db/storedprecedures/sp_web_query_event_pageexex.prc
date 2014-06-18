create or replace procedure sp_web_query_event_pageexex(
i_msgtype number,-- -1:ȫ��,1:��Ϣ,2:����,3:����
i_state number,-- -1:ȫ��,0:δ����1:�Ѿ���
i_desc varchar2,--null:ȫ��
i_ssno varchar2,--null:ȫ��
i_startdt varchar2,--Ĭ��Ϊ���ռ�ȥ7��
i_enddt varchar2,--Ĭ�ϵ���
i_stationname varchar2,--null:ȫ��
i_country number,-- -1:ȫ��
i_devtype number,-- -1:ȫ��,1:�����,2:�����
i_mode varchar2,--�豸�ͺ�,null:ȫ��,
i_eventcode number,--�¼�����,Ϊ-1ʱ,��ʾȫ��,��������
i_rowperpage number ,--ÿҳ����
i_pos number default 1,--��ǰ����,Ϊ0:��ʾ����ҳ��ѯ���з��������ļ�¼
o_pages out number,--������ҳ��
cur_result out sys_refcursor
) is
v_startdt varchar2(30);
v_enddt varchar2(30);
v_rownum  number;
v_rowperpage number;
v_stationname varchar2(100);
v_ssno  varchar2(100);
begin
  v_startdt :=substr(i_startdt,1,10);
  v_enddt:=substr(i_enddt,1,10);
  if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
  else v_rowperpage:=3;
  end if;
  if i_ssno is null then
     v_ssno :='%';
  else
     v_ssno:='%'||upper(i_ssno)||'%';
  end if;
  if i_stationname is null then
      v_stationname:='%';
      else
         v_stationname:='%'||i_stationname||'%';
      end if;
  if i_mode is null then
      select count(1) into v_rownum from
      tb_station b,
      (select val1,val2,context from tb_dict_ssiis where subtag = 'pmuerrcode' and language = 'zh_CN') c,
      (select did,stationid,ssno,occdt,val1,val2,l_tag,devt from tb_event_all 
         where (i_eventcode =-1 or val2=i_eventcode) and 
              (i_state =-1 or l_tag = i_state) and 
              (i_msgtype =-1 or val1 = i_msgtype) and 
              ssno like v_ssno and 
              occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') 
              and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss')) a
         where a.stationid=b.stationid and a.val1 = c.val1 and a.val2= c.val2 and
          (i_devtype =-1 or a.devt = i_devtype) and
          (i_country =-1 or b.country = i_country) and
          ( b.stationname like v_stationname) and
          (c.context like '%'||i_desc||'%' or i_desc is null )
          ;
    o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
  else
     if i_devtype = 1 then--���Ҽ����--����Ż�
       select count(1) into v_rownum
       from (   select did,stationid,ssno,occdt,val1,val2,l_tag,devt from tb_event_all
                where (val2=i_eventcode or i_eventcode =-1 )and occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss')
                      and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss')) a,
                tb_pmu b,tb_station c,(select val1,val2,context from tb_dict_ssiis where subtag = 'pmuerrcode' and language = 'zh_CN') d
           where a.ssno=b.psno and a.stationid = c.stationid and a.val1 = d.val1 and a.val2 = d.val2 and --������
                 --A�¼���
                (i_msgtype =-1 or a.val1 = i_msgtype) and
                (i_state =-1 or a.l_tag = i_state) and
                (a.ssno like v_ssno) and
                --(a.occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss')) and
                (i_devtype =-1 or a.devt = i_devtype) and
                --B�������
                (b.pmutype like '%'|| i_mode||'%') and --�������������
                --C��վ��
                (c.stationname like v_stationname) and
                (i_country =-1 or c.country = i_country) and
                --��������
                --(d.subtag = 'pmuerrcode') and (d.language = 'zh_CN') and
                (i_desc is null or d.context like '%'||i_desc||'%')
           ;
     elsif i_devtype = 2then--���������,�Ż����
           select count(1) into v_rownum from (select did,stationid,ssno,occdt,val1,val2,l_tag,devt from tb_event_all where (val2=i_eventcode or i_eventcode =-1) and occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss')) a,tb_inverter b,tb_station c,(select val1,val2,context from tb_dict_ssiis where subtag = 'pmuerrcode' and language = 'zh_CN') d
           where a.ssno=b.isno and a.stationid = c.stationid and a.val1 = d.val1 and a.val2 = d.val2 and --������
                 --A�¼���
                (i_msgtype =-1 or a.val1 = i_msgtype) and
                (i_state =-1 or a.l_tag = i_state) and
                (a.ssno like v_ssno) and
                --(a.occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss')) and
                (i_devtype =-1 or a.devt = i_devtype) and
                --B�������
                (b.devtypename like '%'|| i_mode||'%') and --�������������
                --C��վ��
                (/*i_stationname is null or */c.stationname like v_stationname/*'%'||i_stationname||'%'*/) and
                (i_country =-1 or c.country = i_country) and
                --��������
                --(d.subtag = 'pmuerrcode') and (d.language = 'zh_CN') and
                (i_desc is null or d.context like '%'||i_desc||'%')
           ;
     end if;
  end if;
    o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
    if o_pages<=0  then o_pages:=1;end if;
    --
    if i_mode is null then
        open cur_result for
        select * from(select rownum rn,x.* from(select b.stationname,a.ssno,decode(a.val1,1,'��Ϣ',2,'����',3,'����','����') msgtype,a.occdt,nvl(c.context,to_char(a.val2)) msg_desc,b.country,b.city,a.devt  from
          (
          select stationid,ssno,to_char(occdt,'yyyy-mm-dd hh24:mi:ss') occdt,val1,val2,devt from tb_event_all where
              (i_msgtype =-1 or val1 = i_msgtype) and
              (i_state =-1 or l_tag = i_state) and
              (val2=i_eventcode or i_eventcode =-1) and
              (ssno like v_ssno) and
              (occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss')) and
              (i_devtype =-1 or devt = i_devtype) order by occdt desc
          ) a,
          (
             select u.stationid,u.stationname,v.context country,u.city from (select stationid,stationname,country,city from tb_station where
                 (/*i_stationname is null or */stationname like v_stationname) and
                 (i_country =-1 or country = i_country)) u,
                 (select val1,context from tb_dict_ssiis where subtag = 'webcountrylist' and language ='zh_CN') v where u.country = v.val1

          ) b,
          (select context,val1,val2 from tb_dict_ssiis where subtag = 'pmuerrcode' and language = 'zh_CN' and
              (i_desc is null or context like '%'||i_desc||'%')
           ) c
           where a.stationid=b.stationid and a.val1 = c.val1 and a.val2= c.val2)x) where i_pos=0 or (rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage);
    else
       if i_devtype = 1 then--���Ҽ����
        open cur_result for
        select * from
        (
             select rownum rn,x.* from
             (
                  select a.stationid,a.ssno,decode(a.val1,1,'��Ϣ',2,'����',3,'����','����') msgtype,to_char(a.occdt,'yyyy-mm-dd hh24:mi:ss') occdt,nvl(d.context,to_char(a.val2)) msg_desc,e.context country,a.devt
                  from (select did,stationid,ssno,occdt,val1,val2,l_tag,devt from tb_event_all where (val2 = i_eventcode or i_eventcode =-1) and occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss') order by occdt desc) a,
                  tb_station b,tb_pmu c,
                  (select val1,val2,context from tb_dict_ssiis where subtag = 'pmuerrcode' and language = 'zh_CN') d,
                  (select val1,val2,context from tb_dict_ssiis where subtag = 'webcountrylist' and language = 'zh_CN') e
                  where a.stationid=b.stationid and a.ssno=c.psno and  a.val1 = d.val1 and a.val2= d.val2 and b.country = e.val1(+) and --������ֵ
                        --A������
                        (i_msgtype =-1 or a.val1 = i_msgtype) and
                        (i_state =-1 or a.l_tag = i_state) and
                        (a.ssno like v_ssno) and
                        --(a.occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss')) and
                        (i_devtype =-1 or a.devt = i_devtype) and
                        --B������tb_station
                        (/*i_stationname is null or */b.stationname like v_stationname/*'%'||i_stationname||'%'*/) and
                        (i_country =-1 or b.country = i_country) and
                        --C������tb_pmu
                        (c.pmutype like '%'||i_mode||'%') and
                        --D��tb_dict_ssiis�������ͱ�
                        --d.subtag = 'pmuerrcode' and d.language = 'zh_CN' and
                        (i_desc is null or d.context like '%'||i_desc||'%')-- and
                        --E��tb_dict_ssiis���Ҵ����
                        --e.subtag = 'webcountrylist' and e.language ='zh_CN'
                        --order by occdt desc
           ) x) where i_pos=0 or (rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage);
     elsif i_devtype = 2then--���������
           open cur_result for
           select * from
           (
               select rownum rn,x.* from
              (
                  select b.stationname,a.ssno,decode(a.val1,1,'��Ϣ',2,'����',3,'����','����') msgtype,to_char(a.occdt,'yyyy-mm-dd hh24:mi:ss') occdt,nvl(c.context,to_char(a.val2)) msg_desc,nvl(e.context,'δ֪') country,b.city,a.devt
                  from (select did,stationid,ssno,occdt,val1,val2,l_tag,devt from tb_event_all where (val2=i_eventcode or i_eventcode =-1) and occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss') order by occdt desc) a,tb_station b,(select val1,val2,context from tb_dict_ssiis where subtag = 'pmuerrcode' and language = 'zh_CN') c,tb_inverter d,(select val1,context from tb_dict_ssiis where subtag = 'webcountrylist' and language = 'zh_CN') e
                  where a.stationid=b.stationid and a.val1 = c.val1 and a.val2= c.val2 and a.ssno = d.isno and b.country = e.val1(+) and --������
                      --A�¼���
                        (i_msgtype =-1 or a.val1 = i_msgtype) and
                        (i_state =-1 or a.l_tag = i_state) and
                        (a.ssno like v_ssno) and
                        (a.occdt between to_date(v_startdt||' 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date(v_enddt||' 23:59:59','yyyy-mm-dd hh24:mi:ss')) and
                        (i_devtype =-1 or a.devt = i_devtype) and
                        --B��վ��
                        (/*i_stationname is null or */B.stationname like v_stationname/*'%'||i_stationname||'%'*/) and
                        (i_country =-1 or B.country = i_country) and
                        --C��������
                         --(c.subtag = 'pmuerrcode' and c.language ='zh_CN') and
                         (i_desc is null or c.context like '%'||i_desc||'%') and
                         --D�������
                        (d.devtypename like '%'||i_mode||'%' ) --and
                        --���Ҵ����
--                        (e.subtag = 'webcountrylist' and e.language ='zh_CN')
               )x
           ) where i_pos=0 or (rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage);
     end if;
    end if;
end sp_web_query_event_pageexex;
/

