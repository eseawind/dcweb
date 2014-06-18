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
  ���ã���oracle�����ʼ�
  ��Ҫ���ܣ�1��֧�ֶ��ռ��ˡ�
            2��֧������
            3��֧�ֳ�����
            4��֧�ִ���32K�ĸ���
            5��֧�ֶ�������
            6��֧�ֶ฽��
            7��֧���ı������Ͷ����Ƹ���
            8��֧��HTML��ʽ
            8��֧��
  ���ߣ�suk
  ����˵����
            p_txt :�ʼ�����
            p_sub: �ʼ�����
            p_SendorAddress : �������ʼ���ַ
            p_ReceiverAddress : ���յ�ַ������ͬʱ���͵������ַ�ϣ���ַ֮����","����";"����
            p_EmailServer : �ʼ���������ַ����������������IP
            p_Port ���ʼ��������˿�
            p_need_smtp���Ƿ���Ҫsmtp��֤��0��ʾ����Ҫ��1��ʾ��Ҫ
            p_user��smtp��֤��Ҫ���û���
            p_pass��smtp��֤��Ҫ������
            p_filename���������ƣ��������������·������"d:\temp\a.txt"��
                        �����ж����������������ֻ���ö��Ż��߷ֺŷָ�
            p_encode����������ת����ʽ������ p_encode='bit 7' ��ʾ�ı����͸���
                                             p_encode='base64' ��ʾ���������͸���
  ע�⣺
        1�������ı����͵ĸ�����������base64�ķ�ʽ���ͣ��������
        2�����ڶ������ֻ����ͬһ�ָ�ʽ����
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
  /* ���²����Ƿ��ʹ�����Ƹ���ʱ�õ��ı��� */
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
  /* ���ϲ����Ƿ��ʹ�����Ƹ���ʱ�õ��ı��� */

  TYPE ADDRESS_LIST IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
  MY_ADDRESS_LIST ADDRESS_LIST;
  TYPE ACCT_LIST IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
  MY_ACCT_LIST ACCT_LIST;
  -------------------------------------���ظ���Դ�ļ�����Ŀ¼��������--------------------------------------
  FUNCTION GET_FILE(P_FILE VARCHAR2,
                    P_GET  INT) RETURN VARCHAR2 IS
    --p_get=1 ��ʾ����Ŀ¼
    --p_get=2 ��ʾ�����ļ���
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
  ---------------------------------------------ɾ��directory------------------------------------
  PROCEDURE DROP_DIRECTORY(P_DIRECTORY_NAME VARCHAR2) IS
  BEGIN
    EXECUTE IMMEDIATE 'drop directory ' || P_DIRECTORY_NAME;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
  --------------------------------------------------����directory-----------------------------------------
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
  --------------------------------------------�ָ��ʼ���ַ���߸�����ַ-----------------------------------
  PROCEDURE P_SPLITE_STR(P_STR         VARCHAR2,
                         P_SPLITE_FLAG INT DEFAULT 1) IS
    L_ADDR VARCHAR2(254) := '';
    L_LEN  INT;
    L_STR  VARCHAR2(4000);
    J      INT := 0; --��ʾ�ʼ���ַ���߸����ĸ���
  BEGIN
    /*��������ʼ���ַ�б�����ȥ�ո񡢽�;ת��Ϊ,��*/
    L_STR := TRIM(RTRIM(REPLACE(REPLACE(P_STR, ';', ','), ' ', ''), ','));
    L_LEN := LENGTH(L_STR);
    FOR I IN 1 .. L_LEN LOOP
      IF SUBSTR(L_STR, I, 1) <> ',' THEN
        L_ADDR := L_ADDR || SUBSTR(L_STR, I, 1);
      ELSE
        J := J + 1;
        IF P_SPLITE_FLAG = 1 THEN --��ʾ�����ʼ���ַ
          --ǰ����Ҫ����'<>'������ܶ����佫���ܷ����ʼ�
          L_ADDR := '<' || L_ADDR || '>';
          --�����ʼ����͹���
          MY_ADDRESS_LIST(J) := L_ADDR;
        ELSIF P_SPLITE_FLAG = 2 THEN --��ʾ����������
          MY_ACCT_LIST(J) := L_ADDR;
        END IF;
        L_ADDR := '';
      END IF;
      IF I = L_LEN THEN
        J := J + 1;
        IF P_SPLITE_FLAG = 1 THEN
          --�����ʼ����͹���
          L_ADDR := '<' || L_ADDR || '>';
          MY_ADDRESS_LIST(J) := L_ADDR;
        ELSIF P_SPLITE_FLAG = 2 THEN
          MY_ACCT_LIST(J) := L_ADDR;
        END IF;
      END IF;
    END LOOP;
  END;
  ------------------------------------------------д�ʼ�ͷ���ʼ�����------------------------------------------
  PROCEDURE WRITE_DATA(P_CONN   IN OUT NOCOPY UTL_SMTP.CONNECTION,
                       P_NAME   IN VARCHAR2,
                       P_VALUE  IN VARCHAR2,
                       P_SPLITE VARCHAR2 DEFAULT ':',
                       P_CRLF   VARCHAR2 DEFAULT L_CRLF) IS
  BEGIN
    /* utl_raw.cast_to_raw �Խ�����������������Ҫ*/
    UTL_SMTP.WRITE_RAW_DATA(P_CONN, UTL_RAW.CAST_TO_RAW(CONVERT(P_NAME ||
                                                         P_SPLITE ||
                                                         P_VALUE ||
                                                         P_CRLF, 'ZHS16GBK')));
  END;
  ----------------------------------------дMIME�ʼ�β��-----------------------------------------------------

  PROCEDURE END_BOUNDARY(CONN IN OUT NOCOPY UTL_SMTP.CONNECTION,
                         LAST IN BOOLEAN DEFAULT FALSE) IS
  BEGIN
    UTL_SMTP.WRITE_DATA(CONN, UTL_TCP.CRLF);
    IF (LAST) THEN
      UTL_SMTP.WRITE_DATA(CONN, LAST_BOUNDARY);
    END IF;
  END;

  ----------------------------------------------���͸���----------------------------------------------------

  PROCEDURE ATTACHMENT(CONN         IN OUT NOCOPY UTL_SMTP.CONNECTION,
                       MIME_TYPE    IN VARCHAR2 DEFAULT 'text/plain',
                       INLINE       IN BOOLEAN DEFAULT TRUE,
                       FILENAME     IN VARCHAR2 DEFAULT 't.txt',
                       TRANSFER_ENC IN VARCHAR2 DEFAULT '7 bit',
                       DT_NAME      IN VARCHAR2 DEFAULT '0') IS
    L_FILENAME VARCHAR2(1000);
  BEGIN
    --д����ͷ
    UTL_SMTP.WRITE_DATA(CONN, FIRST_BOUNDARY);
    --���ø�����ʽ
    WRITE_DATA(CONN, 'Content-Type', MIME_TYPE);
    --����ļ����Ʒǿգ���ʾ�и���
    DROP_DIRECTORY(DT_NAME);
    --����directory
    CREATE_DIRECTORY(DT_NAME, GET_FILE(FILENAME, 1));
    --�õ������ļ�����
    L_FILENAME := GET_FILE(FILENAME, 2);
    IF (INLINE) THEN
      WRITE_DATA(CONN, 'Content-Disposition', 'inline; filename="' ||
                  L_FILENAME || '"');
    ELSE
      WRITE_DATA(CONN, 'Content-Disposition', 'attachment; filename="' ||
                  L_FILENAME || '"');
    END IF;

    --���ø�����ת����ʽ
    IF (TRANSFER_ENC IS NOT NULL) THEN
      WRITE_DATA(CONN, 'Content-Transfer-Encoding', TRANSFER_ENC);
    END IF;
    UTL_SMTP.WRITE_DATA(CONN, UTL_TCP.CRLF);
    --begin ����������
    IF TRANSFER_ENC = 'bit 7' THEN
      --������ı����͵ĸ���
      BEGIN
        L_FILE_HANDLE := UTL_FILE.FOPEN(DT_NAME, L_FILENAME, 'r'); --���ļ�
        --�Ѹ����ֳɶ�ݣ��������Է��ͳ���32K�ĸ���
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
      END; --�����ı����͸����Ĵ���

    ELSIF TRANSFER_ENC = 'base64' THEN
      --����Ƕ��������͵ĸ���
      BEGIN
        --�Ѹ����ֳɶ�ݣ��������Է��ͳ���32K�ĸ���
        L_FILEPOS  := 1;--����offset���ڷ��Ͷ������ʱ����������
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
      END; --������������Ƹ���

    END IF; --��������������
    DROP_DIRECTORY(DT_NAME);
  END; --��������ATTACHMENT

  ---------------------------------------------���������ʼ��Ĺ���--------------------------------------------
  PROCEDURE P_EMAIL(P_SENDORADDRESS2   VARCHAR2, --���͵�ַ
                    P_RECEIVERADDRESS2 VARCHAR2) --���ܵ�ַ
   IS
    L_CONN UTL_SMTP.CONNECTION; --��������
  BEGIN
    /*��ʼ���ʼ���������Ϣ�������ʼ�������*/
    L_CONN := UTL_SMTP.OPEN_CONNECTION(P_SERVER, P_PORT);
    UTL_SMTP.HELO(L_CONN, P_SERVER);
    /* smtp��������¼У�� */
    IF P_NEED_SMTP = 1 THEN
      UTL_SMTP.COMMAND(L_CONN, 'AUTH LOGIN', '');
      UTL_SMTP.COMMAND(L_CONN, UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(P_USER))));
      UTL_SMTP.COMMAND(L_CONN, UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(P_PASS))));
    END IF;
    /*���÷��͵�ַ�ͽ��յ�ַ*/
    UTL_SMTP.MAIL(L_CONN, P_SENDORADDRESS2);
    UTL_SMTP.RCPT(L_CONN, P_RECEIVERADDRESS2);
    /*�����ʼ�ͷ*/
    UTL_SMTP.OPEN_DATA(L_CONN);
    WRITE_DATA(L_CONN, 'Date', TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss'));
    /*���÷�����*/
    WRITE_DATA(L_CONN, 'From', P_SENDOR);
    /*���ý�����*/
    WRITE_DATA(L_CONN, 'To', P_RECEIVER);
    /*�����ʼ�����*/
    WRITE_DATA(L_CONN, 'Subject', P_SUB);
    WRITE_DATA(L_CONN, 'Content-Type', MULTIPART_MIME_TYPE);
    UTL_SMTP.WRITE_DATA(L_CONN, UTL_TCP.CRLF);
    UTL_SMTP.WRITE_DATA(L_CONN, FIRST_BOUNDARY);
    WRITE_DATA(L_CONN, 'Content-Type', 'text/html;charset=gb2312');
    --������һ�У������������ݲ���ʾ
    UTL_SMTP.WRITE_DATA(L_CONN, UTL_TCP.CRLF);
    /* �����ʼ�����
      �ѷָ�����ԭ��chr(10)������Ҫ��Ϊ��shell�е��øù��̣�����ж��У����ȰѶ��е����ݺϲ���һ�У����� l_splite�ָ�
      Ȼ���� l_crlf�滻chr(10)����һ���Ǳ���ģ����򽫲��ܷ����ʼ������ж��е��ʼ�
    */
    WRITE_DATA(L_CONN, '', REPLACE(REPLACE(P_TXT, L_SPLITE, CHR(10)), CHR(10), L_CRLF), '', '');
    END_BOUNDARY(L_CONN);
  --����ļ����Ʋ�Ϊ�գ����͸���
    IF (P_FILENAME IS NOT NULL) THEN
      --���ݶ��Ż��߷ֺŲ�ָ�����ַ
      P_SPLITE_STR(P_FILENAME, 2);
      --ѭ�����͸���(��ͬһ���ʼ���)
      FOR K IN 1 .. MY_ACCT_LIST.COUNT LOOP
        ATTACHMENT(CONN => L_CONN, FILENAME => MY_ACCT_LIST(K), TRANSFER_ENC => P_ENCODE, DT_NAME => L_DIRECTORY_BASE_NAME ||
                               TO_CHAR(K));
      END LOOP;
    END IF;
    /*�ر�����д��*/
    UTL_SMTP.CLOSE_DATA(L_CONN);
    /*�ر�����*/
    UTL_SMTP.QUIT(L_CONN);
    /*�쳣����*/
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
      RAISE;

  END;

  ---------------------------------------------------������-----------------------------------------------------

BEGIN
  L_SENDORADDRESS := '<' || P_SENDOR || '>';
  P_SPLITE_STR(P_RECEIVER);--�����ʼ���ַ
  FOR K IN 1 .. MY_ADDRESS_LIST.COUNT LOOP
    P_EMAIL(L_SENDORADDRESS, MY_ADDRESS_LIST(K));
  END LOOP;
  /*�����ʼ���ַ�����ݶ��ŷָ��ʼ�*/

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/

