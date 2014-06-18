create or replace procedure sp_web_inv_downloadex(
--下载逆变器日数据
i_isno varchar2,--逆变器序列号
i_dts varchar2,--开始日期
i_dte varchar2,--结束日期
o_pvnum out number,--直流有效端子数
--o_fieldsstr out varchar2,--列名
cur_result out  sys_refcursor--结果集
) is
/*================================================================
功能说明:逆变器日明细数据下载
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Config/Device management,系统管理员之逆变器管理
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
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
  select nvl(pvnum,3) into o_pvnum from tb_inverter where isno=i_isno;
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
  open cur_result for select idid,isno,to_char(recvdate,'yyyy-mm-dd')||' ' || fn_gettimebyfen10(fen10) recvdate,to_char(Vpv1,'fm9999999990.00') Vpv1,
 to_char(vpv2,'fm9999999990.00') vpv2,
 to_char(vpv3,'fm9999999990.00') vpv3,
 to_char(vpv4,'fm9999999990.00') vpv4,
 to_char(vpv5,'fm9999999990.00') vpv5,
 to_char(vpv6,'fm9999999990.00') vpv6,
 to_char(vpv7,'fm9999999990.00') vpv7,
 to_char(vpv8,'fm9999999990.00') vpv8,
 to_char(vpv9,'fm9999999990.00') vpv9,
 to_char(vpv10,'fm9999999990.00') vpv10,
 to_char(vpv11,'fm9999999990.00') vpv11,
 to_char(vpv12,'fm9999999990.00') vpv12,
 to_char(vpv13,'fm9999999990.00') vpv13,
 to_char(vpv14,'fm9999999990.00') vpv14,
 to_char(vpv15,'fm9999999990.00') vpv15,
 to_char(vpv16,'fm9999999990.00') vpv16,
 to_char(vpv17,'fm9999999990.00') vpv17,
 to_char(vpv18,'fm9999999990.00') vpv18,
 to_char(vpv19,'fm9999999990.00') vpv19,
 to_char(vpv20,'fm9999999990.00') vpv20,
 to_char(ipv1,'fm9999999990.00') ipv1,
 to_char(ipv2,'fm9999999990.00') ipv2,
 to_char(ipv3,'fm9999999990.00') ipv3,
 to_char(ipv4,'fm9999999990.00') ipv4,
 to_char(ipv5,'fm9999999990.00') ipv5,
 to_char(ipv6,'fm9999999990.00') ipv6,
 to_char(ipv7,'fm9999999990.00') ipv7,
 to_char(ipv8,'fm9999999990.00') ipv8,
 to_char(ipv9,'fm9999999990.00') ipv9,
 to_char(ipv10,'fm9999999990.00') ipv10,
 to_char(ipv11,'fm9999999990.00') ipv11,
 to_char(ipv12,'fm9999999990.00') ipv12,
 to_char(ipv13,'fm9999999990.00') ipv13,
 to_char(ipv14,'fm9999999990.00') ipv14,
 to_char(ipv15,'fm9999999990.00') ipv15,
 to_char(ipv16,'fm9999999990.00') ipv16,
 to_char(ipv17,'fm9999999990.00') ipv17,
 to_char(ipv18,'fm9999999990.00') ipv18,
 to_char(ipv19,'fm9999999990.00') ipv19,
 to_char(ipv20,'fm9999999990.00') ipv20,
 to_char(ppv1,'fm9999999990.00') ppv1,
 to_char(ppv2,'fm9999999990.00') ppv2,
 to_char(ppv3,'fm9999999990.00') ppv3,
 to_char(ppv4,'fm9999999990.00') ppv4,
 to_char(ppv5,'fm9999999990.00') ppv5,
 to_char(ppv6,'fm9999999990.00') ppv6,
 to_char(ppv7,'fm9999999990.00') ppv7,
 to_char(ppv8,'fm9999999990.00') ppv8,
 to_char(ppv9,'fm9999999990.00') ppv9,
 to_char(ppv10,'fm9999999990.00') ppv10,
 to_char(ppv11,'fm9999999990.00') ppv11,
 to_char(ppv12,'fm9999999990.00') ppv12,
 to_char(ppv13,'fm9999999990.00') ppv13,
 to_char(ppv14,'fm9999999990.00') ppv14,
 to_char(ppv15,'fm9999999990.00') ppv15,
 to_char(ppv16,'fm9999999990.00') ppv16,
 to_char(ppv17,'fm9999999990.00') ppv17,
 to_char(ppv18,'fm9999999990.00') ppv18,
 to_char(ppv19,'fm9999999990.00') ppv19,
 to_char(ppv20,'fm9999999990.00') ppv20,
 to_char(vac1,'fm9999999990.00') vac1,
 to_char(vac2,'fm9999999990.00') vac2,
 to_char(vac3,'fm9999999990.00') vac3,
 to_char(iac1,'fm9999999990.00') iac1,
 to_char(iac2,'fm9999999990.00') iac2,
 to_char(iac3,'fm9999999990.00') iac3,
 status,
 to_char(cos_phi,'fm9999999990.00') cos_phi,
 to_char(under_excited,'fm9999999990.00') under_excited,
 to_char(pac,'fm9999999990.00') pac,
 to_char(sac,'fm9999999990.00') sac,
 to_char(qac,'fm9999999990.00') qac,
 to_char(fac,'fm9999999990.00') fac,
 to_char(e_total,'fm9999999990.00') e_total,
 to_char(h_total,'fm9999999990.00') h_total,
 to_char(e_today,'fm9999999990.00') e_today,
 to_char(tempval,'fm9999999990.00') tempval
  from TMP_INV_DOWNLOAD;
end sp_web_inv_downloadex;
/

