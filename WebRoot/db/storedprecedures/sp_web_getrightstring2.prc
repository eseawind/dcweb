create or replace procedure sp_web_getrightstring2(
i_userid number,
i_stationid number,
cur_result  out sys_refcursor
) is
/*tb_user rolestring=a,b,c,d,e
a:��������
b:��վ����
c:�ʺŹ���
d:�豸����
e:�¼���ѯ----�¼�
*/
/*tb_userstation rolestring=a,b,c
�༭��վ��Ϣ
�豸����
���ñ���
*/
/*��վ�б�˵����� a,b,c,d,e
a:��վ��ѯ
b:����Ա����
c:���������
d:���������
e:�û��ʺŹ���
f:�¼���ѯ----�¼�
*/
/*out string:
a,b,c,d,e,f,g,h,i,j
1,2,3,4,5,6,7,8,9,0
1234567890123456789
a:��վ��ѯ
b:�������ѯ
c:���������ѯ
d:�û��ʺŲ�ѯ
e:����Ա����
f:�¼���ѯ----�¼�
------------------------------
g:�豸����----���¼�λ�õ���
h:��������----���¼�λ�õ���
i:��վ����----���¼�λ�õ���
j:��������----���¼�λ�õ���
*/
v_rolestr varchar2(32);
v_rightstr varchar2(32);
v_roleid number;
v_rightid number;
v_listconfig number;
v_deflisturl number;
v_stationconfig number;
v_defurlstation number;
o_result varchar2(100);
begin
  if i_userid = 0 then
     o_result:='0,0,0,0,0,0,0,0,0,0';
  else
    select nvl(roleid,0),nvl(rolestring,'0,0,0,0,0') into v_roleid,v_rolestr from tb_user where userid = i_userid;
    if length(v_rolestr)=9 then
       v_rolestr:=v_rolestr||',0';
    end if;
    if v_roleid = 4 then--��������Ա
         if i_stationid = 0 then
            v_rolestr:='1,1,1,1,1,1';
         else
            v_rolestr:='0,0,0,0,0,0';
        end if;
    elsif v_roleid=3 then--ϵͳ����Ա
       if i_stationid = 0 then
         v_rolestr:=substr(v_rolestr,3,1)|| ',' ||substr(v_rolestr,7,1)|| ',' ||substr(v_rolestr,7,1)|| ','|| substr(v_rolestr,5,1)||',0,'||substr(v_rolestr,9,1);
       else
         v_rolestr:='0,0,0,0,0,0';
       end if;
    else
         v_rolestr:='0,0,0,0,0,0';
    end if;
    if v_rolestr = '0,0,0,0,0,0' then
       v_listconfig:=0;
       v_deflisturl:=0;
    else
      v_listconfig:=1;
      v_deflisturl:=instr(v_rolestr,'1');
    end if;
    if i_stationid >0 then
        if v_roleid in(3,4) then
           v_rightstr:='1,1,1,1';
        else
          select nvl(rightstr,'0,0,0'),nvl(roleid,0) into v_rightstr,v_rightid from tb_userstation where userid = i_userid and stationid  = i_stationid;
          --����������ʺŵ����;���
          if v_rightid = 2 then
            --��վ����Ա
            v_rightstr:='1,1,1,1';
          else
             v_rightstr:=v_rightstr||',0';
          end if;
        end if;
    else
        v_rightstr:='0,0,0,0';
    end if;
    if v_rightstr='0,0,0,0' then
      v_defurlstation:=0;
       v_stationconfig:=0;
    else
       v_stationconfig:=1;
       v_defurlstation:=instr(v_rightstr,'1');
    end if;
    --
    o_result:=v_rolestr||','||v_rightstr;
  end if;
  open cur_result for select decode(i_stationid,0,v_listconfig,v_stationconfig) config,
                             o_result menulist,
                             decode(i_stationid,0,
                                  /*�б�˵�*/decode(v_deflisturl,1,'plantmanager.action',3,'confPmuList.action',5,'confInvList.action',7,'accountManager.action',9,'accountList.action',11,'sysqueryevent.action','none'),
                                  /*��վ�˵�*/decode(v_defurlstation,1,'showStationModify.action',3,'equip_view.action',5,'reportDayShow.action',7,'shareAccountList.action','none'))defurl from dual;
end sp_web_getrightstring2;
/

