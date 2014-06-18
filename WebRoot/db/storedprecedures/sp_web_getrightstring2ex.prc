create or replace procedure sp_web_getrightstring2ex(
i_userid number,
i_stationid number,
o_result out varchar2
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
begin
  if i_userid = 0 then
     o_result:='0,0,0,0,0,0,0,0,0,0';
  else
    select nvl(roleid,0),nvl(rolestring,'0,0,0,0,0') into v_roleid,v_rolestr from tb_user where userid = i_userid;
    if length(v_rolestr)=9 then
       v_rolestr:=v_rolestr||',0';
    end if;
    if v_roleid = 4 then--��������Ա
       v_rolestr:='1,1,1,1,1,1';
    elsif v_roleid=3 then--ϵͳ����Ա
         v_rolestr:=substr(v_rolestr,3,1)|| ',' ||substr(v_rolestr,7,1)|| ',' ||substr(v_rolestr,7,1)|| ','|| substr(v_rolestr,5,1)||',0,'||substr(v_rolestr,9,1);
    else
         v_rolestr:='0,0,0,0,0,0';
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
    --
    o_result:=v_rolestr||','||v_rightstr;
  end if;
end sp_web_getrightstring2ex;
/

