create or replace procedure sp_getstationinfoex(
i_stationid in number,--��վ���
i_lan in varchar2 default 'zh_CN',--��ѯ����
cur_station out sys_refcursor,--��վ��Ϣ�����
cur_master out sys_refcursor--��վ����Ա��Ϣ
) is
--ԭ����sp_getstationinfoû�д�����������Σ�������������Ҫ���������Ե�֧��
--��õ�վ����ϸ���
--��Ӧ��:�ֻ�,wap
v_sharet number;
v_userid number;
begin
   select masterid,sharet into v_userid,v_sharet from tb_station where stationid = i_stationid;
   --��������޸Ĵ洢���̺󣬴�
   open cur_station for select a.stationname,a.startdt,a.totalpower||'KW' totalpower,a.companyname,a.city,b.context country,a.zip,a.jd,a.wd,a.height,a.timezone,a.bgurl from
                                (select stationname,nvl(to_char(startdt,'yyyy-mm-dd'),'2000-01-01') startdt,totalpower,nvl(companyname,'') companyname,city,country,nvl(zip,'') zip,nvl(fn_real_dms(jd),'') jd,nvl(fn_real_dms(wd),'') wd,h||'(m)' height,fn_timezone_string(timezone) timezone,bgurl from tb_station where stationid = i_stationid)a,
                                (select context,val1 country from tb_dict_ssiis where subtag= 'webcountrylist' and language=i_lan)b where a.country = b.country ;
   open cur_master for select a.firstname,a.secondname,a.company,a.street,a.city,b.context country,account e_mail,tel from tb_user a,
                             (select context,val1 country from tb_dict_ssiis where subtag= 'webcountrylist' and language=i_lan) b where a.country=b.country and userid = v_userid;
end sp_getstationinfoex;
/

