---SportyGo_ver_0_2_0_create_1225------
--------------------------
------drop sequence-------
--------------------------
DROP SEQUENCE member_seq;
DROP SEQUENCE SPORT_SEQ;
DROP SEQUENCE VENUETYPE_SEQ;
DROP SEQUENCE VENUE_SEQ;
DROP SEQUENCE SG_INFO_SEQ;
DROP SEQUENCE SG_MSG_SEQ;
DROP SEQUENCE SG_REP_SEQ;
DROP SEQUENCE EVAOFMEM_SEQ;
DROP SEQUENCE club_seq;
DROP SEQUENCE club_member_seq;
DROP SEQUENCE club_member_LIST_seq;
DROP SEQUENCE MUTIMEDIA_SEQ;
DROP SEQUENCE MULTIMEDIA_SEQ;
DROP SEQUENCE post_info_seq;
DROP SEQUENCE post_seq;
DROP SEQUENCE post_like_seq;
DROP SEQUENCE respones_seq;
DROP SEQUENCE respones_like_seq;
DROP SEQUENCE ORD_SEQ;
DROP SEQUENCE PRODUCTCLASS_SEQ; 
DROP SEQUENCE PRODUCT_SEQ;
DROP SEQUENCE PROMOTION_SEQ; 
DROP SEQUENCE address_seq;
DROP SEQUENCE NEWSTYPE_SEQ; 
DROP SEQUENCE NEWS_SEQ;
DROP SEQUENCE EMP_SEQ;
DROP SEQUENCE COMPETITION_SEQ;
--------------------------------------
-----DROP TABLE-----------------------
--------------------------------------
DROP TABLE COMPETITION;
DROP TABLE EMP;
DROP TABLE NEWS;
DROP TABLE NEWSTYPE;
DROP TABLE ADDRESS;
---有表格改名字--第一個是舊的
DROP TABLE PRODUCT_DETAIL_PROMOTION;
DROP TABLE PRO_DETAIL_PROM;
---
DROP TABLE GYM;
DROP TABLE PROMOTION;
DROP TABLE SHOPPINGCART;
DROP TABLE PRODUCT_LIKE;
DROP TABLE ORDDETAILS;
DROP TABLE PRODUCT;
DROP TABLE PRODUCTCLASS;
DROP TABLE ORD;
DROP TABLE RESPONES_LIKE;
DROP TABLE RESPONES;
DROP TABLE POST;
DROP TABLE POST_LIKE;
DROP TABLE POST_INFO;
DROP TABLE MUTIMEDIA;
DROP TABLE MULTIMEDIA;
----FIRST IS OLDEER TABLE;
DROP TABLE CLUB_MEMBER;
DROP TABLE CLUB_MEMBERLIST;
----
DROP TABLE CLUB;
DROP table SG_LIKE;
DROP TABLE EVAOFMEM;
DROP table SG_REP;
DROP table SG_MEM;
DROP table SG_MSG;
DROP TABLE SG_INFO;
DROP TABLE V_EVALUATION;
DROP TABLE VENUE;
DROP TABLE REGION;
DROP TABLE VENUETYPE;
DROP table SPORT;
DROP TABLE FRIEND;
DROP TABLE MEMBERLIST;
------------01---------------------------
------------MEMBERLIST TABL-------------
---------------------------------20181208
CREATE TABLE MEMBERLIST(
    MEM_NO VARCHAR2(7),
    MEM_NAME VARCHAR2(45) NOT NULL,
    MEM_NICK VARCHAR2(45),
    MEM_ACCOUNT VARCHAR2(15) NOT NULL UNIQUE,
    MEM_PSWD VARCHAR2(12) NOT NULL,
    MEM_EMAIL VARCHAR2(60) NOT NULL,
    MEM_PHONE VARCHAR2(13) NOT NULL,
    MEM_EMGC VARCHAR2(15),
    MEM_EMGCPHONE VARCHAR2(13),
    MEM_STATUS VARCHAR2(15) DEFAULT '未驗證' NOT NULL,
    MEM_CARD NUMBER(16),
    MEM_EXPIRY VARCHAR2(7),
    MEM_PIC BLOB,
    MEM_PICKIND VARCHAR2(10),
    CONSTRAINT MEMBERLIST_PK PRIMARY KEY (MEM_NO)
);
CREATE SEQUENCE member_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;
------------02---------------------------
------------FRIEND-----------------------
---------------------------------20181208
CREATE TABLE FRIEND(
    MEM1_NO VARCHAR2(7),
    MEM2_NO VARCHAR2(7),
    RELATIONSHIP VARCHAR2(45),
    FRIEND_STATUS VARCHAR2(9) DEFAULT '申請中' NOT NULL,
    MEM_CHAT CLOB,
    CONSTRAINT FRIEND_PK PRIMARY KEY (MEM1_NO,MEM2_NO),
    CONSTRAINT PRIENDSHIP_FK1 FOREIGN KEY (MEM1_NO) REFERENCES MEMBERLIST (MEM_NO),
    CONSTRAINT PRIENDSHIP_FK2 FOREIGN KEY (MEM2_NO) REFERENCES MEMBERLIST (MEM_NO)
);
------------03---------------------------
------------SPORT------------------------
---------------------------------20181208
create table SPORT(
    SP_NO varchar2(7),
    SP_NAME varchar2(15) not null,
    
    constraint SPORT_PK primary key(SP_NO)
);
create sequence SPORT_SEQ
    increment by 1
    start with 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;
------------04---------------------------
------------VENUETYPE--------------------
---------------------------------20181208
CREATE TABLE VENUETYPE (
    VT_NO       VARCHAR2(7)     PRIMARY KEY, 
    VT_NAME     VARCHAR2(30)    NOT NULL
);  
CREATE SEQUENCE VENUETYPE_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;
------------05---------------------------
------------REGION-----------------------
---------------------------------20181208
CREATE TABLE REGION (
    REG_NO       NUMBER(5)      PRIMARY KEY, 
    REG_NAME     VARCHAR2(45)   NOT NULL,
	REG_DIST     VARCHAR2(45)   NOT NULL -----分開鄉鎮市區
);
------------06---------------------------
------------VENUE------------------------
---------------------------------20181224
Create table venue(
    v_no varchar2(7) PRIMARY KEY, --PK--V0000001
    v_name varchar2(500) NOT NULL,
    v_weburl varchar2(1500),
    v_parktype varchar2(500), -- 停車類型
    v_introduction   CLOB, ---場館簡介
    vt_no varchar2(7),
    v_inout varchar2(500), ---設施室內外類型
    reg_no NUMBER(5),
    v_address varchar2(500),
    v_phoneno varchar2(50),
    V_LAT       NUMBER(17,14),  ---- 修改欄位 (Number可存浮點數 17長度,小數點14位)
    V_LONG      NUMBER(17,14),  ---- 修改欄位 (Number可存浮點數 17長度,小數點14位)
    -----v_public_transport CLOB, ---交通資訊---因為部分有Array所以就這時放棄
    v_fitall varchar2(1) check( v_fitall in('Y','N')), ---適用對象-民眾
    v_fitinter varchar2(1) check (v_fitinter in('Y','N')),---適用對象-所屬單位人員(如校內師生)
    open_state varchar2(100), --開放情況
    open_time varchar2(500), --開放時間
    openday_mon varchar2(1) check (openday_mon in ('Y','N')),    
    openday_tue varchar2(1) check (openday_tue in ('Y','N')),
    openday_wed varchar2(1) check (openday_wed in ('Y','N')),
    openday_thu varchar2(1) check (openday_thu in ('Y','N')),
    openday_fri varchar2(1) check (openday_fri in ('Y','N')),
    openday_sat varchar2(1) check (openday_sat in ('Y','N')),
    openday_sun varchar2(1) check (openday_sun in ('Y','N')),
    v_photo1 BLOB,
    v_photo1_ext varchar2(10),
    v_photo2 BLOB,
    v_photo2_ext varchar2(10),        
    ----TEST_ING---
    CONSTRAINT VENUE_VENUETYPE_FK                    ----單字FK放後面
    FOREIGN KEY(VT_NO) REFERENCES VENUETYPE(VT_NO),  
    CONSTRAINT VENUE_REGION_FK                       ----單字FK放後面
    FOREIGN KEY(REG_NO) REFERENCES REGION(REG_NO)
);


CREATE SEQUENCE VENUE_SEQ
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE
    order;


------------07---------------------------
------------V_EVALUATION------------------------
---------------------------------20181208
CREATE TABLE V_EVALUATION (
    MEM_NO VARCHAR2(7),
    V_NO VARCHAR2(7), 
    SCORE NUMBER(1) ,
    CONSTRAINT V_EVALUATION_PK PRIMARY KEY(MEM_NO,V_NO),
    CONSTRAINT V_EVALUATION_MEMBER_FK FOREIGN KEY(MEM_NO) REFERENCES MEMBERLIST(MEM_NO),
    CONSTRAINT V_EVALUATION_VENUE_FK FOREIGN KEY(V_NO) REFERENCES VENUE(V_NO)
);  
------------08---------------------------
------------SG_INFO----------------------
---------------------------------20181208
CREATE TABLE SG_INFO(
    SG_NO varchar2(7),
    MEM_NO varchar2(7) not null,
    SG_NAME varchar2(50) not null,
    SG_DATE timestamp not null,
    APL_START timestamp not null,
    APL_END timestamp not null,
    SG_FEE number(6,0),
    SG_PIC blob,
    SG_PIC_EXT varchar2(10),
    SG_PER varchar2(10) not null,
    SP_NO varchar2(7) not null,
    V_NO varchar2(7),
    SG_MAXNO number(2,0),
    SG_MINNO number(2,0),
    SG_TTLAPL number(2,0),
    SG_CHKNO number(2,0),
    SG_EXTRAINFO clob,
    SG_STATUS varchar2(10) default '揪團中' not null,
    LOC_START_LAT DECIMAL(9,6),
    LOC_START_LNG DECIMAL(8,6),
    LOC_END_LAT DECIMAL(9,6),
    LOC_END_LNG DECIMAL(8,6),
    
    constraint SG_INFO_PK primary key (SG_NO),
    constraint FK1_SG_INFO_MEM foreign key (MEM_NO) references MEMBERLIST(MEM_NO),
    constraint FK2_SG_INFO_SPORT foreign key (SP_NO) references SPORT(SP_NO),
    constraint FK3_SG_INFO_VEMUE foreign key (V_NO) references VENUE(V_NO)
);
create sequence SG_INFO_SEQ
    start with 1
    increment by 1
    MAXVALUE 999
    nocycle
    nocache;
------------09---------------------------
------------SG_MSG-----------------------
---------------------------------20181208
create table SG_MSG(
    MSG_NO varchar2(7),
    SG_NO varchar2(7),
    MEM_NO varchar2(7),
    MSG_CONT clob,
    MSG_TIME timestamp,
    
    constraint SG_MSG_PK primary key(SG_NO,MEM_NO),
    constraint FK1_SG_MSG_INFO foreign key (SG_NO) references SG_INFO(SG_NO),
    constraint FK2_SG_MSG_MEM foreign key (MEM_NO) references MEMBERLIST(MEM_NO)
);
create sequence SG_MSG_SEQ
    increment by 1
    start with 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;



------------10---------------------------
------------SG_MEM----------------------
---------------------------------20181208
create table SG_MEM(
    SG_NO varchar2(7) not null,
    MEM_NO varchar2(7) not null,
    CH_STATUS varchar2(10) default '未報到' not null,
    
    constraint SG_MEM_PK primary key (SG_NO,MEM_NO),
    constraint FK1_SG_MEM_INFO foreign key (SG_NO) references SG_INFO(SG_NO),
    constraint FK2_SG_MEM_MEMLIST foreign key (MEM_NO) references MEMBERLIST(MEM_NO)
);

------------11---------------------------
------------SG_REP----------------------
---------------------------------20181208
create table SG_REP(
    REP_NO varchar2(7),
    SG_NO varchar2(7),
    MEM_NO varchar2(7),
    REP_TYPE varchar2(30) not null,
    REP_CONT clob,
    REP_STATUS varchar2(30) default '待審核' not null,
    
    constraint SG_REP_PK primary key(REP_NO),
    constraint FK1_SG_REP_INFO foreign key (SG_NO) references SG_INFO(SG_NO),
    constraint FK2_SG_REP_MEM foreign key (MEM_NO) references MEMBERLIST(MEM_NO)
);
create sequence SG_REP_SEQ
    increment by 1
    start with 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;

------------12---------------------------
------------EVAOFMEM----------------------
---------------------------------20181208
CREATE TABLE EVAOFMEM(
    SG_NO VARCHAR2(7),
    EVALUATE_NO VARCHAR2(7),
    EVALUATED_NO VARCHAR2(7),
    EVA_SCORE NUMBER(3),
    CONSTRAINT EVAOFMAM_PK PRIMARY KEY (SG_NO,EVALUATE_NO,EVALUATED_NO),
    CONSTRAINT EVAOFMEM_SGINFO_FK1 FOREIGN KEY (SG_NO) REFERENCES SG_INFO (SG_NO),
    CONSTRAINT EVAOFMAM_MEMBER_FK2 FOREIGN KEY (EVALUATE_NO) REFERENCES MEMBERLIST (MEM_NO),
    CONSTRAINT EVAOFMAM_MEMBER_FK3 FOREIGN KEY (EVALUATED_NO) REFERENCES MEMBERLIST (MEM_NO)
);
create sequence EVAOFMEM_SEQ
    increment by 1
    start with 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;

------------13---------------------------
------------SG_LIKE----------------------
---------------------------------20181208
create table SG_LIKE(
    SG_NO varchar2(7),
    MEM_NO varchar2(7),
    
    constraint SG_LIKE_PK primary key(SG_NO,MEM_NO),
    constraint SG_LIKE_FK1 foreign key (SG_NO) references SG_INFO(SG_NO),
    constraint SG_LIKE_FK2 foreign key (MEM_NO) references MEMBERLIST(MEM_NO)
);

------------14---------------------------
------------CLUB-------------------------
---------------------------------20181208
CREATE TABLE CLUB (
  CLUB_NO       VARCHAR2(7), 
  SP_NO         VARCHAR2(7)  NOT NULL, 
  PHOTO         BLOB,
  PHOTO_EXT     VARCHAR2(10),
  CLUB_STATUS   VARCHAR2(10) DEFAULT '正常' NOT NULL,
  CLUB_NAME     VARCHAR2(20) NOT NULL,
  CLUB_INTRO    CLOB,
  
  CONSTRAINT CLUB_PK PRIMARY KEY (CLUB_NO),
  CONSTRAINT CLUB_FK FOREIGN KEY (SP_NO) REFERENCES SPORT (SP_NO)
);
CREATE SEQUENCE club_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 9999
    NOCYCLE
    NOCACHE;

------------15---------------------------
------------CLUB_MEMBERLIST------------------
---------------------------------20181208
CREATE TABLE CLUB_MEMBERLIST (
    CLUB_NO       VARCHAR2(7)  NOT NULL, 
    MEM_NO        VARCHAR2(7)  NOT NULL, 
    CMEM_STATUS   VARCHAR2(20) DEFAULT '待審核' NOT NULL,
    CMEM_CLASS    VARCHAR2(15) DEFAULT '一般成員' NOT NULL,
    SILENCE_TIME  TIMESTAMP,

    CONSTRAINT CLUB_MEMBER_LIST_PK PRIMARY KEY(CLUB_NO,MEM_NO),
    CONSTRAINT CLUB_MEMBER_LIST_FK1 FOREIGN KEY (CLUB_NO) REFERENCES CLUB (CLUB_NO),
    CONSTRAINT CLUB_MEMBER_LIST_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);
---why need it, club_member_list_seq ?
CREATE SEQUENCE club_member_list_seq
   INCREMENT BY 1
   START WITH 1
   MAXVALUE 999
   NOCYCLE
   NOCACHE;

------------16---------------------------
------------MULTIMEDIA--------------------
---------------------------------20181208
CREATE TABLE MULTIMEDIA(
    MEDIA_NO VARCHAR2(7) PRIMARY KEY,
    FILE_EXTENSION VARCHAR2(10),
    MEDIA_CONTENT BLOB,
    CLUB_NO VARCHAR2(7),
    MEM_NO VARCHAR2(7),
    MEDIA_RELEASEDATE TIMESTAMP NOT NULL,
    MEDIA_TITLE VARCHAR2(30)
);
CREATE SEQUENCE MULTIMEDIA_SEQ
   INCREMENT BY 1
   START WITH 1
   MAXVALUE 99999
   NOCYCLE
   NOCACHE;

------------17---------------------------
------------POST_INFO------------------
---------------------------------20181208
CREATE TABLE POST_INFO (
    POST_NO       VARCHAR2(7)  NOT NULL, 
    CLUB_NO       VARCHAR2(7)  NOT NULL, 
    MEM_NO        VARCHAR2(7)  NOT NULL,
    POST_TOPIC    VARCHAR2(60),
    POST_CONTENT  CLOB  NOT NULL,
    POST_DATE		TIMESTAMP  NOT NULL,
  
    CONSTRAINT POST_INFO_PK PRIMARY KEY (POST_NO),
    CONSTRAINT POST_INFO_FK1 FOREIGN KEY (CLUB_NO) REFERENCES CLUB (CLUB_NO),
    CONSTRAINT POST_INFO_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);
CREATE SEQUENCE post_info_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 9999
    NOCYCLE
    NOCACHE;

------------18---------------------------
------------POST_LIKE-------------------------
---------------------------------20181208
CREATE TABLE POST_LIKE (
    POST_NO       VARCHAR2(7), 
    MEM_NO        VARCHAR2(7),
    LIKE_TYPE     VARCHAR2(10) default '讚',

    CONSTRAINT POST_LIKE_PK PRIMARY KEY(POST_NO,MEM_NO),
    CONSTRAINT POST_LIKE_FK1 FOREIGN KEY (POST_NO) REFERENCES POST_INFO(POST_NO),
    CONSTRAINT POST_LIKE_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);
-----THIS SEQUENCE DON'T NEEDED
CREATE SEQUENCE post_like_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;

------------19---------------------------
------------RESPONES---------------------
---------------------------------20181208
CREATE TABLE RESPONES (
    RES_NO        VARCHAR2(7), 
    POST_NO       VARCHAR2(7) NOT NULL, 
    MEM_NO        VARCHAR2(7) NOT NULL,
    RES_CONTENT   CLOB  NOT NULL,
    RES_DATE	  TIMESTAMP  NOT NULL,
  
    CONSTRAINT RESPONES_PK  PRIMARY KEY (RES_NO),
    CONSTRAINT RESPONES_FK1 FOREIGN KEY (POST_NO) REFERENCES POST_INFO (POST_NO),
    CONSTRAINT RESPONES_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);    
CREATE SEQUENCE respones_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 9999
    NOCYCLE
    NOCACHE;


------------20---------------------------
------------RESPONES_LIKE----------------
---------------------------------20181209
CREATE TABLE RESPONES_LIKE (
    RES_NO        VARCHAR2(7), 
    MEM_NO        VARCHAR2(7),
    LIKE_TYPE     VARCHAR2(10) DEFAULT '讚',
    CONSTRAINT RESPONES_LIKE_PK PRIMARY KEY (RES_NO,MEM_NO),
    CONSTRAINT FK1_RESPONES_LIKE_RES FOREIGN KEY (RES_NO) REFERENCES RESPONES (RES_NO),
    CONSTRAINT FK2_RESPONES_LIKE_MEM FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);  
---THIS SEQUENCE DON'T NEEDED
CREATE SEQUENCE respones_like_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;

------------21---------------------------
------------ORD--------------------------
---------------------------------20181209
CREATE TABLE ORD (
    ORD_NO	        	VARCHAR2(20),
    MEM_NO	        	VARCHAR2(7)     NOT NULL,   
    ORD_DATE	        TIMESTAMP       NOT NULL,	
    ORD_DELDATE	        TIMESTAMP,	
    ORD_STATUS	        VARCHAR2(10)    NOT NULL,
    ORD_BACKDELDATE	    TIMESTAMP,	
    ORD_AMOUNT	        NUMBER(7)       NOT NULL,
    ORD_BACKAMOUNT	    NUMBER(7),
    CONSTRAINT fk1_ord_memberlist FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST(MEM_NO),
    CONSTRAINT ORD_PK PRIMARY KEY (ORD_NO)
);
CREATE SEQUENCE ORD_SEQ 
    INCREMENT BY 1 
    START WITH 1
    NOMAXVALUE 
    NOCYCLE
    NOCACHE
    ORDER;

------------22---------------------------
------------PRODUCTCLASS-----------------
---------------------------------20181209
CREATE TABLE PRODUCTCLASS(
    PRO_CLASSID		    VARCHAR2(7),
    PRO_CLASSNAME		VARCHAR2(100) NOT NULL,
    CONSTRAINT PRODUCTCLASS_PK PRIMARY KEY (PRO_CLASSID)
);
CREATE SEQUENCE PRODUCTCLASS_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;

------------23---------------------------
------------PRODUCT----------------------
---------------------------------20181209
CREATE TABLE PRODUCT(
    PRO_NO		            VARCHAR2(7),
    PRO_CLASSID		        VARCHAR2(7)     NOT NULL,
    PRO_NAME		        VARCHAR2(100)   NOT NULL,
    PRO_PIC		            BLOB,
    PRO_PIC_EXT	        	VARCHAR2(10),
    PRO_FORMAT		        VARCHAR2(100)   NOT NULL,
    PRO_BONUS		        NUMBER(7)       NOT NULL,
    PRO_STOCK		        NUMBER(7)       NOT NULL,
    PRO_SAFESTOCK	        NUMBER(7)       NOT NULL,
    PRO_DETAILS		        VARCHAR2(1500),
    PRO_SHELVE		        VARCHAR2(10)    NOT NULL,
    PRO_ALL_ASSESS		    NUMBER(7),
    PRO_ALL_ASSESSMAN		NUMBER(7),
    CONSTRAINT FK1_PRODUCT_PRODUCTCLASS FOREIGN KEY (PRO_CLASSID) REFERENCES PRODUCTCLASS (PRO_CLASSID),
    CONSTRAINT PRODUCT_PK PRIMARY KEY (PRO_NO)
);

CREATE SEQUENCE PRODUCT_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;
------------24---------------------------
------------ORDDETAILS-------------------
---------------------------------20181209
CREATE TABLE ORDDETAILS(
    ORD_NO		        VARCHAR2(20) NOT NULL,
    PRO_NO		        VARCHAR2(7) NOT NULL,
    ORD_PROBONUNS		NUMBER(7) NOT NULL,
    PRO_COUNT		    NUMBER(7) NOT NULL,
    CONSTRAINT FK1_ORDDETAILS_ORD FOREIGN KEY (ORD_NO) REFERENCES ORD (ORD_NO),
    CONSTRAINT FK2_ORDDETAILS_PRO FOREIGN KEY (PRO_NO) REFERENCES PRODUCT (PRO_NO),
    CONSTRAINT ORDDETAILS_PK PRIMARY KEY (ORD_NO , PRO_NO)
);

------------25---------------------------
------------PRODUCTLIKE------------------
---------------------------------20181209
CREATE TABLE PRODUCT_LIKE(
    PRODUCT_NO  VARCHAR2(7),
    MEM_NO      VARCHAR2(7),
    CONSTRAINT PRODUCT_LIKE_PK PRIMARY KEY (PRODUCT_NO,MEM_NO),
    CONSTRAINT PRODUCT_LIKE_MEMBER_FK1 FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT (PRO_NO),
    CONSTRAINT PRODUCT_LIKE_MEMBER_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);
------------26---------------------------
------------SHOPPINGCART---Redis---------
---------------------------------20181209
CREATE TABLE SHOPPINGCART(
    MEM_NO		    VARCHAR2(7)     NOT NULL,
    PRO_NO		    VARCHAR2(7)     NOT NULL,
    PRO_COUNT		NUMBER(7)       NOT NULL,
    CONSTRAINT FK1_SHOPPINGCART_MEMBERLIST FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST(MEM_NO),
    CONSTRAINT SHOPPINGCART_PK PRIMARY KEY (MEM_NO , PRO_NO)
);



------------27---------------------------
------------PROMOTION--------------------
---------------------------------20181209
CREATE TABLE PROMOTION(
    PROM_PROJECT_ID		    VARCHAR2(7),
    PROM_PROJECT_NAME		VARCHAR2(100)   NOT NULL,
    PROM_PROJECT_SDATE		TIMESTAMP       NOT NULL,	
    PROM_PROJECT_EDATE		TIMESTAMP       NOT NULL,	
    CONSTRAINT PROMOTION_PK PRIMARY KEY (PROM_PROJECT_ID)
);

CREATE SEQUENCE PROMOTION_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;
------------28---------------------------
------------PRO_DETAIL_PROMO--------------
---------------------------------20181209
CREATE TABLE PRO_DETAIL_PROM(
    PROM_PROJECT_ID		VARCHAR2(7) NOT NULL,
    PRO_NO		        VARCHAR2(7) NOT NULL,
    PRO_SALE		    NUMBER(7)   NOT NULL,
    CONSTRAINT PRODUCT_DETAILPROMOTION_PK 
    PRIMARY KEY (PROM_PROJECT_ID , PRO_NO),
    CONSTRAINT FK1_PRO_DELTAIL_PROM_PROBUCT FOREIGN KEY (PRO_NO) REFERENCES PRODUCT(PRO_NO),
    CONSTRAINT FK2_PRO_DETAIL_PROM_PROMOTION FOREIGN KEY (PROM_PROJECT_ID) REFERENCES PROMOTION(PROM_PROJECT_ID)
);

------------29---------------------------
------------ADDRESS----------------------
---------------------------------20181209
CREATE TABLE ADDRESS(
    ADDR_NO         VARCHAR2(7),
    MEM_NO          VARCHAR2(7),
    RECEIVER         VARCHAR2(15)    NOT NULL,
    RECEIVER_PHONE   VARCHAR2(13)    NOT NULL,
    COUNTRY         VARCHAR2(45)    NOT NULL,
    CITY            VARCHAR2(45)    NOT NULL,
    ADDR_DETAIL     VARCHAR2(60)    NOT NULL,
    ADDR_ZIP        NUMBER(5)       NOT NULL,
    CONSTRAINT ADDRESS_PK PRIMARY KEY (ADDR_NO),
    CONSTRAINT ADDRESS_MEMBER_FK FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST(MEM_NO)    
);
CREATE SEQUENCE address_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;
------------30---------------------------
------------NEWSTYPE---------------------
---------------------------------20181209
CREATE TABLE NEWSTYPE
    (NEWSTYPE_NO    VARCHAR2(7)     PRIMARY KEY,
    NEWSTYPE_NAME   VARCHAR2(30)    NOT NULL
);
CREATE SEQUENCE NEWSTYPE_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCACHE
    NOCYCLE
    ORDER;
------------31---------------------------
------------NEWS-------------------------
---------------------------------20181209
CREATE TABLE NEWS
    (NEWS_NO        VARCHAR2(7)     PRIMARY KEY,
    NEWS_TYPENO     VARCHAR2(7),
    NEWS_SCRIPT     CLOB,
    PIC_EXTENSION   VARCHAR2(30),
    NEWS_PICTURE    BLOB,
    NEWS_STUTAS     VARCHAR2(12)    DEFAULT '未發布',
    NEWS_RELEASE_DATE TIMESTAMP,
    NEWS_LAST_DATE  TIMESTAMP,
    FOREIGN KEY (NEWS_TYPENO) REFERENCES NEWSTYPE(NEWSTYPE_NO)
);
CREATE SEQUENCE NEWS_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCACHE
    NOCYCLE
    ORDER;
------------32---------------------------
------------EMP--------------------------
---------------------------------20181209
CREATE TABLE EMP 
    (EMP_NO VARCHAR2(7) PRIMARY KEY, 
    EMP_NAME VARCHAR2(255) NOT NULL, 
    EMP_AUTH VARCHAR2(255) DEFAULT '一般管理員', 
    EMP_PHONE VARCHAR2(13), 
    EMP_EMAIL VARCHAR2(255) NOT NULL UNIQUE, 
    EMP_ACCOUNT VARCHAR2(50) NOT NULL UNIQUE, 
    EMP_PSW VARCHAR2(20), 
    HIREDATE DATE, 
    LEAVEDATE DATE
);
CREATE SEQUENCE EMP_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCACHE
    NOCYCLE
    ORDER;

------------33---------------------------
------------COMPETITION------------------
---------------------------------20181209
CREATE TABLE COMPETITION
    (COMP_NO        VARCHAR2(7)     PRIMARY KEY,
    COMP_NAME       VARCHAR2(255)   NOT NULL,
    COMP_STARTDATE  TIMESTAMP       NOT NULL,
    COMP_ENDDATE    TIMESTAMP       NOT NULL,
    COMP_CONT       CLOB            NOT NULL
);
CREATE SEQUENCE COMPETITION_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCACHE
    NOCYCLE
    ORDER;
------------33---------------------------
------------GYM--------------------------
---------------------------------20181224
---------------------為了抓場地的ID值使用
Create table gym(
	gym_id varchar2(500) primary key,
	gym_name varchar2(500),
	gym_funclist varchar2(1500)
);
-------



COMMIT;