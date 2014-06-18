CREATE OR REPLACE PROCEDURE PROCSENDEMAIL(P_TXT       VARCHAR2,
                                          P_SUB       VARCHAR2,
                                          P_SENDOR    VARCHAR2,
                                          P_RECEIVER  VARCHAR2,
                                          P_SERVER    VARCHAR2,
                                          P_PORT      NUMBER DEFAULT 25,
                                          P_NEED_SMTP INT DEFAULT 0,
                                          P_USER      VARCHAR2 DEFAULT NULL,
                                          P_PASS      VARCHAR2 DEFAULT NULL,
                                          P_FILENAME  VARCHAR2 DEFAULT NULL,
                                          P_ENCODE    VARCHAR2 DEFAULT 'bit 7')
  AUTHID CURRENT_USER IS
  /*
  作用：用oracle发送邮件
  主要功能：1、支持多收件人。
            2、支持中文
            3、支持抄送人
            4、支持大于32K的附件
            5、支持多行正文
            6、支持多附件
            7、支持文本附件和二进制附件
            8、支持HTML格式
            8、支持
  作者：suk
  参数说明：
            p_txt :邮件正文
            p_sub: 邮件标题
            p_SendorAddress : 发送人邮件地址
            p_ReceiverAddress : 接收地址，可以同时发送到多个地址上，地址之间用","或者";"隔开
            p_EmailServer : 邮件服务器地址，可以是域名或者IP
            p_Port ：邮件服务器端口
            p_need_smtp：是否需要smtp认证，0表示不需要，1表示需要
            p_user：smtp验证需要的用户名
            p_pass：smtp验证需要的密码
            p_filename：附件名称，必须包含完整的路径，如"d:\temp\a.txt"。
                        可以有多个附件，附件名称只见用逗号或者分号分隔
            p_encode：附件编码转换格式，其中 p_encode='bit 7' 表示文本类型附件
                                             p_encode='base64' 表示二进制类型附件
  注意：
        1、对于文本类型的附件，不能用base64的方式发送，否则出错
        2、对于多个附件只能用同一种格式发送
  */

  L_CRLF VARCHAR2(2) := UTL_TCP.CRLF;
  L_SENDORADDRESS VARCHAR2(4000);
  L_SPLITE        VARCHAR2(10) := '++';
  BOUNDARY            CONSTANT VARCHAR2(256) := '-----BYSUK';
  FIRST_BOUNDARY      CONSTANT VARCHAR2(256) := '--' || BOUNDARY || L_CRLF;
  LAST_BOUNDARY       CONSTANT VARCHAR2(256) := '--' || BOUNDARY || '--' ||
                                                L_CRLF;
  MULTIPART_MIME_TYPE CONSTANT VARCHAR2(256) := 'multipart/mixed; boundary="' ||
                                                BOUNDARY || '"';
  /* 以下部分是发送大二进制附件时用到的变量 */
  L_FIL                 BFILE;
  L_FILE_LEN            NUMBER;
  L_MODULO              NUMBER;
  L_PIECES              NUMBER;
  L_FILE_HANDLE         UTL_FILE.FILE_TYPE;
  L_AMT                 BINARY_INTEGER := 672 * 3; /* ensures proper format;  2016 */
  L_FILEPOS             PLS_INTEGER := 1; /* pointer for the file */
  L_CHUNKS              NUMBER;
  L_BUF                 RAW(2100);
  L_DATA                RAW(2100);
  L_MAX_LINE_WIDTH      NUMBER := 54;
  L_DIRECTORY_BASE_NAME VARCHAR2(100) := 'DIR_FOR_SEND_MAIL';
  L_LINE                VARCHAR2(1000);
  L_MESG                VARCHAR2(32767);
  /* 以上部分是发送大二进制附件时用到的变量 */

  TYPE ADDRESS_LIST IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
  MY_ADDRESS_LIST ADDRESS_LIST;
  TYPE ACCT_LIST IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
  MY_ACCT_LIST ACCT_LIST;
  -------------------------------------返回附件源文件所在目录或者名称--------------------------------------
  FUNCTION GET_FILE(P_FILE VARCHAR2,
                    P_GET  INT) RETURN VARCHAR2 IS
    --p_get=1 表示返回目录
    --p_get=2 表示返回文件名
    L_FILE VARCHAR2(1000);
  BEGIN
    IF INSTR(P_FILE, '\') > 0 THEN
      --windows
      IF P_GET = 1 THEN
        L_FILE := SUBSTR(P_FILE, 1, INSTR(P_FILE, '\', -1) - 1);
      ELSIF P_GET = 2 THEN
        L_FILE := SUBSTR(P_FILE, - (LENGTH(P_FILE) - INSTR(P_FILE, '\', -1)));
      END IF;
    ELSIF INSTR(P_FILE, '/') > 0 THEN
      --linux/unix
      IF P_GET = 1 THEN
        L_FILE := SUBSTR(P_FILE, 1, INSTR(P_FILE, '/', -1) - 1);
      ELSIF P_GET = 2 THEN
        L_FILE := SUBSTR(P_FILE, - (LENGTH(P_FILE) - INSTR(P_FILE, '/', -1)));
      END IF;
    END IF;
    RETURN L_FILE;
  END;
  ---------------------------------------------删除directory------------------------------------
  PROCEDURE DROP_DIRECTORY(P_DIRECTORY_NAME VARCHAR2) IS
  BEGIN
    EXECUTE IMMEDIATE 'drop directory ' || P_DIRECTORY_NAME;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
  --------------------------------------------------创建directory-----------------------------------------
  PROCEDURE CREATE_DIRECTORY(P_DIRECTORY_NAME VARCHAR2,
                             P_DIR            VARCHAR2) IS
  BEGIN
    EXECUTE IMMEDIATE 'create directory ' || P_DIRECTORY_NAME || ' as ''' ||
                      P_DIR || '''';
    EXECUTE IMMEDIATE 'grant read,write on directory ' || P_DIRECTORY_NAME ||
                      ' to public';
    EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END;
  --------------------------------------------分割邮件地址或者附件地址-----------------------------------
  PROCEDURE P_SPLITE_STR(P_STR         VARCHAR2,
                         P_SPLITE_FLAG INT DEFAULT 1) IS
    L_ADDR VARCHAR2(254) := '';
    L_LEN  INT;
    L_STR  VARCHAR2(4000);
    J      INT := 0; --表示邮件地址或者附件的个数
  BEGIN
    /*处理接收邮件地址列表，包括去空格、将;转换为,等*/
    L_STR := TRIM(RTRIM(REPLACE(REPLACE(P_STR, ';', ','), ' ', ''), ','));
    L_LEN := LENGTH(L_STR);
    FOR I IN 1 .. L_LEN LOOP
      IF SUBSTR(L_STR, I, 1) <> ',' THEN
        L_ADDR := L_ADDR || SUBSTR(L_STR, I, 1);
      ELSE
        J := J + 1;
        IF P_SPLITE_FLAG = 1 THEN --表示处理邮件地址
          --前后需要加上'<>'，否则很多邮箱将不能发送邮件
          L_ADDR := '<' || L_ADDR || '>';
          --调用邮件发送过程
          MY_ADDRESS_LIST(J) := L_ADDR;
        ELSIF P_SPLITE_FLAG = 2 THEN --表示处理附件名称
          MY_ACCT_LIST(J) := L_ADDR;
        END IF;
        L_ADDR := '';
      END IF;
      IF I = L_LEN THEN
        J := J + 1;
        IF P_SPLITE_FLAG = 1 THEN
          --调用邮件发送过程
          L_ADDR := '<' || L_ADDR || '>';
          MY_ADDRESS_LIST(J) := L_ADDR;
        ELSIF P_SPLITE_FLAG = 2 THEN
          MY_ACCT_LIST(J) := L_ADDR;
        END IF;
      END IF;
    END LOOP;
  END;
  ------------------------------------------------写邮件头和邮件内容------------------------------------------
  PROCEDURE WRITE_DATA(P_CONN   IN OUT NOCOPY UTL_SMTP.CONNECTION,
                       P_NAME   IN VARCHAR2,
                       P_VALUE  IN VARCHAR2,
                       P_SPLITE VARCHAR2 DEFAULT ':',
                       P_CRLF   VARCHAR2 DEFAULT L_CRLF) IS
  BEGIN
    /* utl_raw.cast_to_raw 对解决中文乱码问题很重要*/
    UTL_SMTP.WRITE_RAW_DATA(P_CONN, UTL_RAW.CAST_TO_RAW(CONVERT(P_NAME ||
                                                         P_SPLITE ||
                                                         P_VALUE ||
                                                         P_CRLF, 'ZHS16GBK')));
  END;
  ----------------------------------------写MIME邮件尾部-----------------------------------------------------

  PROCEDURE END_BOUNDARY(CONN IN OUT NOCOPY UTL_SMTP.CONNECTION,
                         LAST IN BOOLEAN DEFAULT FALSE) IS
  BEGIN
    UTL_SMTP.WRITE_DATA(CONN, UTL_TCP.CRLF);
    IF (LAST) THEN
      UTL_SMTP.WRITE_DATA(CONN, LAST_BOUNDARY);
    END IF;
  END;

  ----------------------------------------------发送附件----------------------------------------------------

  PROCEDURE ATTACHMENT(CONN         IN OUT NOCOPY UTL_SMTP.CONNECTION,
                       MIME_TYPE    IN VARCHAR2 DEFAULT 'text/plain',
                       INLINE       IN BOOLEAN DEFAULT TRUE,
                       FILENAME     IN VARCHAR2 DEFAULT 't.txt',
                       TRANSFER_ENC IN VARCHAR2 DEFAULT '7 bit',
                       DT_NAME      IN VARCHAR2 DEFAULT '0') IS
    L_FILENAME VARCHAR2(1000);
  BEGIN
    --写附件头
    UTL_SMTP.WRITE_DATA(CONN, FIRST_BOUNDARY);
    --设置附件格式
    WRITE_DATA(CONN, 'Content-Type', MIME_TYPE);
    --如果文件名称非空，表示有附件
    DROP_DIRECTORY(DT_NAME);
    --创建directory
    CREATE_DIRECTORY(DT_NAME, GET_FILE(FILENAME, 1));
    --得到附件文件名称
    L_FILENAME := GET_FILE(FILENAME, 2);
    IF (INLINE) THEN
      WRITE_DATA(CONN, 'Content-Disposition', 'inline; filename="' ||
                  L_FILENAME || '"');
    ELSE
      WRITE_DATA(CONN, 'Content-Disposition', 'attachment; filename="' ||
                  L_FILENAME || '"');
    END IF;

    --设置附件的转换格式
    IF (TRANSFER_ENC IS NOT NULL) THEN
      WRITE_DATA(CONN, 'Content-Transfer-Encoding', TRANSFER_ENC);
    END IF;
    UTL_SMTP.WRITE_DATA(CONN, UTL_TCP.CRLF);
    --begin 贴附件内容
    IF TRANSFER_ENC = 'bit 7' THEN
      --如果是文本类型的附件
      BEGIN
        L_FILE_HANDLE := UTL_FILE.FOPEN(DT_NAME, L_FILENAME, 'r'); --打开文件
        --把附件分成多份，这样可以发送超过32K的附件
        LOOP
          UTL_FILE.GET_LINE(L_FILE_HANDLE, L_LINE);
          L_MESG := L_LINE || L_CRLF;
          WRITE_DATA(CONN, '', L_MESG, '', '');
        END LOOP;
        UTL_FILE.FCLOSE(L_FILE_HANDLE);
        END_BOUNDARY(CONN);
      EXCEPTION
        WHEN OTHERS THEN
          UTL_FILE.FCLOSE(L_FILE_HANDLE);
          END_BOUNDARY(CONN);
          NULL;
      END; --结束文本类型附件的处理

    ELSIF TRANSFER_ENC = 'base64' THEN
      --如果是二进制类型的附件
      BEGIN
        --把附件分成多份，这样可以发送超过32K的附件
        L_FILEPOS  := 1;--重置offset，在发送多个附件时，必须重置
        L_FIL      := BFILENAME(DT_NAME, L_FILENAME);
        L_FILE_LEN := DBMS_LOB.GETLENGTH(L_FIL);
        L_MODULO   := MOD(L_FILE_LEN, L_AMT);
        L_PIECES   := TRUNC(L_FILE_LEN / L_AMT);
        IF (L_MODULO <> 0) THEN
          L_PIECES := L_PIECES + 1;
        END IF;
        DBMS_LOB.FILEOPEN(L_FIL, DBMS_LOB.FILE_READONLY);
        DBMS_LOB.READ(L_FIL, L_AMT, L_FILEPOS, L_BUF);
        L_DATA := NULL;
        FOR I IN 1 .. L_PIECES LOOP
          L_FILEPOS  := I * L_AMT + 1;
          L_FILE_LEN := L_FILE_LEN - L_AMT;
          L_DATA     := UTL_RAW.CONCAT(L_DATA, L_BUF);
          L_CHUNKS   := TRUNC(UTL_RAW.LENGTH(L_DATA) / L_MAX_LINE_WIDTH);
          IF (I <> L_PIECES) THEN
            L_CHUNKS := L_CHUNKS - 1;
          END IF;
          UTL_SMTP.WRITE_RAW_DATA(CONN, UTL_ENCODE.BASE64_ENCODE(L_DATA));
          L_DATA := NULL;
          IF (L_FILE_LEN < L_AMT AND L_FILE_LEN > 0) THEN
            L_AMT := L_FILE_LEN;
          END IF;
          DBMS_LOB.READ(L_FIL, L_AMT, L_FILEPOS, L_BUF);
        END LOOP;
        DBMS_LOB.FILECLOSE(L_FIL);
        END_BOUNDARY(CONN);
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_LOB.FILECLOSE(L_FIL);
          END_BOUNDARY(CONN);
          RAISE;
      END; --结束处理二进制附件

    END IF; --结束处理附件内容
    DROP_DIRECTORY(DT_NAME);
  END; --结束过程ATTACHMENT

  ---------------------------------------------真正发送邮件的过程--------------------------------------------
  PROCEDURE P_EMAIL(P_SENDORADDRESS2   VARCHAR2, --发送地址
                    P_RECEIVERADDRESS2 VARCHAR2) --接受地址
   IS
    L_CONN UTL_SMTP.CONNECTION; --定义连接
  BEGIN
    /*初始化邮件服务器信息，连接邮件服务器*/
    L_CONN := UTL_SMTP.OPEN_CONNECTION(P_SERVER, P_PORT);
    UTL_SMTP.HELO(L_CONN, P_SERVER);
    /* smtp服务器登录校验 */
    IF P_NEED_SMTP = 1 THEN
      UTL_SMTP.COMMAND(L_CONN, 'AUTH LOGIN', '');
      UTL_SMTP.COMMAND(L_CONN, UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(P_USER))));
      UTL_SMTP.COMMAND(L_CONN, UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(P_PASS))));
    END IF;
    /*设置发送地址和接收地址*/
    UTL_SMTP.MAIL(L_CONN, P_SENDORADDRESS2);
    UTL_SMTP.RCPT(L_CONN, P_RECEIVERADDRESS2);
    /*设置邮件头*/
    UTL_SMTP.OPEN_DATA(L_CONN);
    WRITE_DATA(L_CONN, 'Date', TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss'));
    /*设置发送人*/
    WRITE_DATA(L_CONN, 'From', P_SENDOR);
    /*设置接收人*/
    WRITE_DATA(L_CONN, 'To', P_RECEIVER);
    /*设置邮件主题*/
    WRITE_DATA(L_CONN, 'Subject', P_SUB);
    WRITE_DATA(L_CONN, 'Content-Type', MULTIPART_MIME_TYPE);
    UTL_SMTP.WRITE_DATA(L_CONN, UTL_TCP.CRLF);
    UTL_SMTP.WRITE_DATA(L_CONN, FIRST_BOUNDARY);
    WRITE_DATA(L_CONN, 'Content-Type', 'text/html;charset=gb2312');
    --单独空一行，否则，正文内容不显示
    UTL_SMTP.WRITE_DATA(L_CONN, UTL_TCP.CRLF);
    /* 设置邮件正文
      把分隔符还原成chr(10)。这主要是为了shell中调用该过程，如果有多行，则先把多行的内容合并成一行，并用 l_splite分隔
      然后用 l_crlf替换chr(10)。这一步是必须的，否则将不能发送邮件正文有多行的邮件
    */
    WRITE_DATA(L_CONN, '', REPLACE(REPLACE(P_TXT, L_SPLITE, CHR(10)), CHR(10), L_CRLF), '', '');
    END_BOUNDARY(L_CONN);
  --如果文件名称不为空，则发送附件
    IF (P_FILENAME IS NOT NULL) THEN
      --根据逗号或者分号拆分附件地址
      P_SPLITE_STR(P_FILENAME, 2);
      --循环发送附件(在同一个邮件中)
      FOR K IN 1 .. MY_ACCT_LIST.COUNT LOOP
        ATTACHMENT(CONN => L_CONN, FILENAME => MY_ACCT_LIST(K), TRANSFER_ENC => P_ENCODE, DT_NAME => L_DIRECTORY_BASE_NAME ||
                               TO_CHAR(K));
      END LOOP;
    END IF;
    /*关闭数据写入*/
    UTL_SMTP.CLOSE_DATA(L_CONN);
    /*关闭连接*/
    UTL_SMTP.QUIT(L_CONN);
    /*异常处理*/
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
      RAISE;

  END;

  ---------------------------------------------------主过程-----------------------------------------------------

BEGIN
  L_SENDORADDRESS := '<' || P_SENDOR || '>';
  P_SPLITE_STR(P_RECEIVER);--处理邮件地址
  FOR K IN 1 .. MY_ADDRESS_LIST.COUNT LOOP
    P_EMAIL(L_SENDORADDRESS, MY_ADDRESS_LIST(K));
  END LOOP;
  /*处理邮件地址，根据逗号分割邮件*/

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/

