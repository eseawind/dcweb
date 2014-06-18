create or replace procedure sp_web_getstationevent (
i_userid number,--用户编号,用来获取用户角色
i_stationid number,--电站编号
i_ssno varchar2 default null,
i_msgtype number default null,--消息类型1:提示,2,警告3:错误,NULL:全部(1,3)
i_dts varchar2 default null,--开始日期
i_dte varchar2 default null,--结束日期
i_eve_l number default null,--0:未读,1:已经读,NULL:全部
i_lan varchar2 default 'en_US',--语种:en_US,zh_CN,必须为其一
i_rowperpage number,--每页行数>3
i_pos number default 1,--当前页数
o_pages out number,--返回总页数
cur_result out sys_refcursor--输出结果集
) is
/*说明:
目前字典中只对错误类型进行了定义(msgtype=3)如果其他类型值可能导致数据不能完整显示*/
v_rownum  number;
v_rowperpage number;
v_roleid number;
v_pos number;
v_dts date;
v_dte date;
begin
  --insert into tb_sys_log(idd,occdt,val1,val2,context) values(seq_idd_log.nextval,sysdate,i_pos,i_rowperpage,'');
 -- commit;
  if i_dts is null then
     v_dts:=null;
  else
    v_dts:=to_date(i_dts||' 00:00:00','yyyy-mm-dd hh24:mi:ss');
  end if;
  if i_dte is null then
       v_dte:=null;
  else
      v_dte:=to_date(i_dte||' 23:59:59','yyyy-mm-dd hh24:mi:ss');
  end if;
  if i_userid = 0 then
     v_roleid:=1;
  else
      select roleid into v_roleid from tb_user where userid = i_userid;
  end if;
  --0,1,2,12,3,4
  ----1:信息，2:警告,3:错误
   select count(1) into v_rownum from tb_event_all where
              ((i_msgtype is null and (v_roleid in(3,4) or val1 <>2)) or val1 = i_msgtype)
              and (v_dts is null or occdt >= v_dts)
              and (v_dte is null or occdt <= v_dte)
              and (i_ssno is null or ssno = i_ssno)
              and (i_eve_l is null or l_tag =i_eve_l)
              and c_tag = 0 and stationid = i_stationid /*and ssno in (select isno from tb_inverter where stationid = i_stationid)*/;
  if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
  else v_rowperpage:=3;
  end if;
  --
  if v_rownum = 0 then
     v_rownum:=1;
  end if;
  o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
  v_pos := nvl(i_Pos,1);

  if v_pos>o_pages then
    v_pos:=o_pages;
  end if;
  if v_pos <1 then
     v_pos:=1;
  end if;
  execute immediate 'truncate table tmp_station_new_event';
  --1:信息，2:警告,3:错误
  insert into tmp_station_new_event(DID,SSNO,byname,msgtype,occdt,err_code,DESCRIBLE,haveread)
                       select c.did,c.ssno,nvl(d.byname,c.ssno) byname,c.msgtype,c.occdt,c.err_code,c.context,c.haveread from
                             (select did,ssno,msgtype,err_code,occdt,context,haveread from
                                   (select e.did did,e.ssno,e.val1 msgtype,e.val2 err_code,e.occdt,nvl(b.context,to_char(e.val2)) context,e.l_tag haveread from
                                         (select * from (select a.*,rownum rn from(select did,ssno,occdt,val1,val2,l_tag from tb_event_all
                                          where ((i_msgtype is null and (v_roleid in(3,4) or val1 <>2)) or val1 = i_msgtype)
                                                 and (v_dts is null or occdt >= v_dts)
                                                 and (v_dte is null or occdt <= v_dte)
                                                 and (i_ssno is null or ssno = i_ssno)
                                                 and (i_eve_l is null or l_tag =i_eve_l)
                                                 and c_tag = 0 and stationid = i_stationid /*and ssno in(select isno from tb_inverter where stationid = i_stationid)*/order by occdt/*did*/ desc)  a) where rn between (v_pos-1)*v_rowperpage +1 and v_pos*v_rowperpage) e,
                                         (select val1,val2,context from tb_dict_ssiis where subtag = 'pmuerrcode' and language=nvl(i_lan,'en_US')) b
                                     where e.val2=b.val2(+) and e.val1=b.val1(+))
                              ) c,
                              (select isno ssno,nvl(byname,isno) byname from tb_inverter where stationid = i_stationid union
                               select psno ssno,nvl(byname,psno) byname from tb_pmu where  stationid = i_stationid ) d
                           where c.ssno = d.ssno(+);
   update tb_event_all set l_tag = 1 where did in (select did from tmp_station_new_event);
   commit;
   open cur_result for select did,ssno,byname,msgtype,to_char(occdt,'yyyy-mm-dd hh24:mi:ss') occdt,err_code,DESCRIBLE context,haveread from tmp_station_new_event order by occdt desc;
end sp_web_getstationevent;
/

