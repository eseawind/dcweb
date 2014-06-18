create or replace procedure sp_create_stationex(
i_userid number,--�û�ID��
i_stationname varchar2,--��վ����
i_picurl varchar2 default '/res/def/icon/plant01.jpg',--��վͼƬURL
i_startdt varchar2,--������������--
i_installcap number,--װ������
i_company varchar2,
i_country varchar2,--��������--
i_city     varchar2,--��������--
i_street   varchar2,--���ڽֵ�--
i_province varchar2,--ʡ��
i_zip      varchar2,--�ʱ�
i_jd       varchar2 default 137,--����:(����23�ȣ�37�֣�30�룬��ʽΪ:e:23-27-30,����Ϊ:w:23-27-30)
i_wd       varchar2 default 37,--γ��:(��γ132��,30�֣�27�룬��ʽΪ:n:132-30-27,��γΪ:s:132-30-37)
i_height   number,--���ε�λ���ף�
i_insangle number,--��װ�����
i_co2rate  number default 0.7,--������̼����ϵ��
i_incomerate number default 0.8,--��վ����ϵ��
i_currency  varchar2 default '$',--���ҵ�λ
i_timezone number default 8,--��վ����ʱ��������,����
i_timezonex number,--ʱ����¼���
o_stationid out number,
i_customerflag NUMBER DEFAULT 1) is
/*================================================================
����˵��:��ҳ������վ,����0����δ�ɹ�
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:��վ�б��д�����վ����
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_startdate date;
v_jd number;
v_wd number;
v_rownum number;
begin
   select count(1) into v_rownum from tb_user where userid = i_userid;
   if v_rownum >0 then
      v_wd:=fn_dms_real(i_wd);
      v_jd:=fn_dms_real(i_jd);
      v_startdate:=to_date(i_startdt,'yyyy-mm-dd');
      insert into tb_station(stationid,stationname,createdt,masterid,startdt,totalpower,companyname,country,province,city,street,zip,jd,wd,h,comangle,co2xs,gainxs,money,timezone,w_keyval,pmutnum,pmu1num,inv1num,sharet,iconindex,bgurl,customerflag) values (seq_stationid.nextval,i_stationname,sysdate,i_userid,v_startdate,i_installcap,i_company,to_number(i_country),to_number(i_province),i_city,i_street,i_zip,v_jd,v_wd,i_height,i_insangle,i_co2rate,i_incomerate,i_currency,i_timezone,i_timezonex,0,0,0,0,nvl(i_picurl,'/res/def/icon/plant01.jpg'),'/upload/station/defultBg.jpg',i_customerflag);
      select seq_stationid.currval into o_stationid from dual;
      update tb_user set roleid = 12 where userid = i_userid and roleid = 0; --=3,4��ϵͳ����Ա��ɫ����
      insert into tb_userstation(userid,stationid,createdt,roleid,state,mailactive) values(i_userid,o_stationid,sysdate,2,1,1);
      commit;
      --�����վ�������ü�¼
      sp_create_stationreportconfig(o_stationid);
  else
     o_stationid:=0;
  end if;
end sp_create_stationex;
/

