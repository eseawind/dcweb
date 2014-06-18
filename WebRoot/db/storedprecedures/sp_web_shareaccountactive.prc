create or replace procedure sp_web_shareaccountactive(
i_stationid number,--������ĵ�վ���
i_userid number,--������շ����û�ID
i_verifycode varchar2,--����У����
o_result  out varchar2--������
) is
--�����վ�û��ʺż���,����ֹͣʹ��20120926
v_rownum number;
v_verifycode varchar2(60);
begin
  select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid = i_userid;
  if v_rownum >0 then
     select nvl(verifycode,'') into v_verifycode from tb_userstation where stationid = i_stationid and userid = i_userid;
     if length(v_verifycode)>3 and v_verifycode = i_verifycode then
        update tb_userstation set mailactive = 1,verifycode = null where stationid = i_stationid and userid = i_userid;
        commit;
     else
        o_result:='err_verifycode';
     end if;
  else
     o_result:='err_account';
  end if;
end sp_web_shareaccountactive;
/

