Insert into TB_USER_INFO
   (ID, EMP_CODE, NAME, PASSWORD, STATUS, 
    EMAIL, TYPE, LAST_LOGIN_IP, CURRENT_LOGIN_IP, LAST_LOGIN_TIME, 
    LOGIN_ATTEMPT_TIMES, LOGIN_FAILD_TIME, PASSWORD_FIRST_MODIFIED_FLAG, PASSWORD_EXPIRE_TIME, GMT_CREATE, 
    GMT_MODIFIED, CREATE_BY, LAST_MODIFIED_BY, ENCODE, EXPIRED_TIME, 
    LANGUAGE_ID, LANGUAGE_CODE, TIMEZONE_ID, TIMEZONE_CODE, DELETED_FLAG, 
    USING_FLAG, MEMBER_ID)
 Values
   (1, 'admin', '管理员', '96e79218965eb72c92a549dd5a330112', 1, 
    'admin@haier.com', 1, '0:0:0:0:0:0:0:1', '10.129.13.221', DATE_FORMAT('2014/2/11 14:40:56.844000','%Y-%m-%d %T'), 
    0, NULL, 1, DATE_FORMAT('2013/12/24 9:43:58.958000','%Y-%m-%d %T'), DATE_FORMAT('2011/9/12 12:30:39.000000','%Y-%m-%d %T'), 
    DATE_FORMAT('2014/2/11 14:41:01.000000','%Y-%m-%d %T'), 'Kevin', '管理员', NULL, DATE_FORMAT('2016/2/23 0:00:00.000000','%Y-%m-%d %T'), 
    10000, 'zh_CN', 10000, 'CN', '0', 
    '0', 1);
COMMIT;
