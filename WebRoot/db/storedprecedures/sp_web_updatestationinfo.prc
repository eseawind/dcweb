create or replace procedure sp_web_updatestationinfo(
i_stationid number,--��վ���
i_stationname varchar2,--��վ����
i_picurl varchar2 default 'res/def/icon/plant01.jpg',--��վͼƬURL
i_startdt varchar2,--������������--
i_installcap number,--װ������--
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
i_timezonex number--,--ʱ����¼���
) is
v_rownum number;
v_startdate date;
v_jd number;
v_wd number;
begin
   select count(1) into v_rownum from tb_station where stationid = i_stationid;
   if v_rownum >0 then
      v_wd:=fn_dms_real(i_wd);
      v_jd:=fn_dms_real(i_jd);
      v_startdate:=to_date(i_startdt,'yyyy-mm-dd');
      update tb_station set stationname=i_stationname,startdt=v_startdate,totalpower=i_installcap,
                      country=nvl(to_number(i_country),country),province=nvl(to_number(i_province),province),city=i_city,street=i_street,zip=i_zip,
                      jd=v_jd,wd=v_wd,h=i_height,comangle=i_insangle,co2xs=i_co2rate,gainxs=i_incomerate,
                      money=i_currency,timezone=i_timezone,w_keyval=i_timezonex,iconindex=i_picurl 
               where stationid = i_stationid;
      commit;
   end if;
   
end sp_web_updatestationinfo;
/

