create or replace procedure sp_web_inv_download(
--下载逆变器日数据
--受v_sql
i_isno varchar2,--逆变器序列号
i_dts varchar2,--开始日期
i_dte varchar2,--结束日期
cur_result out  sys_refcursor--结果集
) is
v_dts date;
v_dte date;
v_daynum number;
v_table varchar2(32);
v_sql varchar2(2000);
begin
  execute immediate 'truncate table TMP_INV_DOWNLOAD';
  v_dts:=to_date(i_dts,'yyyy-mm-dd');
  v_dte:=to_date(i_dte,'yyyy-mm-dd');
  v_daynum :=v_dte-v_dts+1;
  for v_r  in 1..v_daynum loop
     v_table :='tb_inv'||to_char(v_dts,'yyyymmdd');
     if fn_check_table_exists(v_table) = 1 then
       v_sql:='insert into TMP_INV_DOWNLOAD(idid,isno,recvdate,fen10,vpv1,vpv2,vpv3,vpv4,vpv5,vpv6,vpv7,vpv8,vpv9,vpv10,vpv11,vpv12,vpv13,vpv14,vpv15,vpv16,vpv17,vpv18,vpv19,vpv20,ipv1,ipv2,ipv3,ipv4,ipv5,ipv6,ipv7,ipv8,ipv9,ipv10,ipv11,ipv12,ipv13,ipv14,ipv15,ipv16,ipv17,ipv18,ipv19,ipv20,ppv1,ppv2,ppv3,ppv4,ppv5,ppv6,ppv7,ppv8,ppv9,ppv10,ppv11,ppv12,ppv13,ppv14,ppv15,ppv16,ppv17,ppv18,ppv19,ppv20,vac1,vac2,vac3,iac1,iac2,iac3,status,cos_phi,under_excited,pac,sac,qac,fac,e_total,h_total,e_today,tempval)
                     select idid,isno,recvdate,fen10,vpv1,vpv2,vpv3,vpv4,vpv5,vpv6,vpv7,vpv8,vpv9,vpv10,vpv11,vpv12,vpv13,vpv14,vpv15,vpv16,vpv17,vpv18,vpv19,vpv20,ipv1,ipv2,ipv3,ipv4,ipv5,ipv6,ipv7,ipv8,ipv9,ipv10,ipv11,ipv12,ipv13,ipv14,ipv15,ipv16,ipv17,ipv18,ipv19,ipv20,ppv1,ppv2,ppv3,ppv4,ppv5,ppv6,ppv7,ppv8,ppv9,ppv10,ppv11,ppv12,ppv13,ppv14,ppv15,ppv16,ppv17,ppv18,ppv19,ppv20,vac1,vac2,vac3,iac1,iac2,iac3,status,cos_phi,under_excited,pac,sac,qac,fac,e_total,h_total,e_today,tempval from '||v_table|| ' where isno=:isno__ order by fen10 ' ;
        execute immediate v_sql using i_isno;
     end if;
     v_dts:=v_dts+1;
  end loop;
  commit;
  open cur_result for select idid,isno,to_char(recvdate,'yyyy-mm-dd')||' ' || fn_gettimebyfen10(fen10) recvdate,Vpv1,vpv2,vpv3,vpv4,vpv5,vpv6,vpv7,vpv8,vpv9,vpv10,vpv11,vpv12,vpv13,vpv14,vpv15,vpv16,vpv17,vpv18,vpv19,vpv20,ipv1,ipv2,ipv3,ipv4,ipv5,ipv6,ipv7,ipv8,ipv9,ipv10,ipv11,ipv12,ipv13,ipv14,ipv15,ipv16,ipv17,ipv18,ipv19,ipv20,ppv1,ppv2,ppv3,ppv4,ppv5,ppv6,ppv7,ppv8,ppv9,ppv10,ppv11,ppv12,ppv13,ppv14,ppv15,ppv16,ppv17,ppv18,ppv19,ppv20,vac1,vac2,vac3,iac1,iac2,iac3,status,cos_phi,under_excited,pac,sac,qac,fac,e_total,h_total,e_today,tempval from TMP_INV_DOWNLOAD;
end sp_web_inv_download;
/

