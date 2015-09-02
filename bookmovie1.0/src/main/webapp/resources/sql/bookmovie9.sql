-- 8월 27일
-- 요한이 예약에 이어서 ,  민규형 꺼 추가, 통계, 시어터 까지
--아래 3줄은 DB 계정까지 생성하라고 할 경우만 실행하세요.
CREATE USER bookmovie IDENTIFIED BY bookmovie ACCOUNT UNLOCK;
GRANT CONNECT, RESOURCE TO bookmovie;
CONN bookmovie/bookmovie;



drop table movie_avg_grade;  
drop table movie_view_stat;
drop table movie_stat_meta;
drop table movie_stat_type;
drop table book_avg_grade;
drop table book_read_stat;
drop table book_stat_meta;
drop table book_stat_type;
drop table reservation;
drop table board_meta;
drop table board;
drop table book;
drop table book_cat;
drop table th_reservation;
drop table theater;
drop table movie;
drop table genre;
drop table multiplex;
drop table member;


drop sequence th_res_seq;
drop sequence book_seq;
drop sequence th_code;
drop sequence brd_no;
drop sequence res_seq;
drop sequence grades_seq;
drop sequence book_stat_seq;
drop sequence movie_stat_seq;    


CREATE SEQUENCE RES_SEQ
increment by 1
start with 1001
nocycle;

CREATE SEQUENCE book_SEQ
increment by 1
start with 1001
nocycle;

CREATE SEQUENCE TH_CODE
START WITH 1
INCREMENT BY 1 ;

CREATE SEQUENCE BRD_NO 
START WITH 1
INCREMENT BY 1 ;

CREATE SEQUENCE GRADES_SEQ
START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE TH_RES_SEQ
increment by 1
start with 1001
nocycle;
CREATE SEQUENCE BOOK_STAT_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE MOVIE_STAT_SEQ
START WITH 1
INCREMENT BY 1;




create table MEMBER (
    USER_ID       varchar2(15 ) default 'NULL' ,
    USER_PW       varchar2 ( 15 ) default 'NULL' ,
    NAME     varchar2(20 ) default 'NULL' ,
    EMAIL      varchar2 ( 30 ) default 'NULL' ,
    PHONE_NUM      varchar2(15)       default 'NULL' ,
    GENDER     varchar2(5) default 'NULL',
    BIRTHDAY      date           default sysdate,      
    admin    number       default 0,
    reg_date date   default sysdate,
    constraint mem_id_pk primary key(USER_ID)
);


CREATE TABLE BOARD (
       BRD_NO NUMBER DEFAULT 0 ,   --게시판 글번호(시퀸스)
       USER_ID VARCHAR2 (15 ) DEFAULT 'NULL',   --유저아이디 (멤버테이블의 아이디를 외래키로받음)
       BRD_TYPE NUMBER, --게시글타입(리뷰,공지)    
       BRD_CATEGORY VARCHAR2 (20) DEFAULT 'NULL', --게시글 카테고리
       BRD_TITLE VARCHAR2 (100) DEFAULT 'NULL', --게시판 글제목
       BRD_CONTENT VARCHAR2 (2000) DEFAULT 'NULL', --게시판 글내용
       BRD_DATE date default sysdate,    --게시글 등록날짜
       BRD_VIEWS NUMBER DEFAULT 0,     --게시글 조회수
       CONSTRAINT BOARD_PK PRIMARY KEY( BRD_NO),
       CONSTRAINT FK_USER_ID FOREIGN KEY( USER_ID)  REFERENCES MEMBER( USER_ID)
);


create table BOOK_CAT (
    book_cat_big        varchar2 ( 45 ) default 'NULL' ,
    book_cat_medium        varchar2 ( 45 ) default 'NULL' ,
    book_cat_small        varchar2 ( 45 ) default 'NULL' ,
    constraint book_cat_pk primary key ( book_cat_small)
);

create table BOOK (
   book_serial_no     number default 0 ,
    book_title         varchar2( 100) default 'NULL' ,
    author             varchar2( 100) default 'NULL' ,
    img_addr           varchar2( 255) default 'NULL' ,
    press_day          date,
    publisher         varchar2( 30) default 'NULL' ,
    book_category    varchar2( 100) default 'NULL' ,
    detail            varchar2(2000) default 'NULL',
    constraint book_serial_no_pk primary key( book_serial_no),
    constraint book_category_fk foreign key( book_category)
        references BOOK_CAT ( book_cat_small ) on delete cascade
);



CREATE TABLE GENRE(
    GENRE VARCHAR2 ( 30),
    CONSTRAINT GENRE_PK PRIMARY KEY(GENRE )
);


CREATE TABLE MOVIE (
    MOVIE_CODE VARCHAR2 (10),
    GENRE VARCHAR2 (30),
    TITLE VARCHAR2 (50),
    VIEW_TIME DATE DEFAULT SYSDATE,
    POSTER VARCHAR2 (100),
    REG_DATE DATE DEFAULT SYSDATE,
    BACKGROUND VARCHAR2 (200) DEFAULT 'NULL',
    IFRAME VARCHAR2 (1000) DEFAULT 'NULL',
    MOVIE_INFO VARCHAR2 (4000) DEFAULT 'NULL',
    CONSTRAINT MOVIE_PK PRIMARY KEY(MOVIE_CODE ),
    CONSTRAINT MOVIE_FK_GENRE FOREIGN KEY(GENRE)REFERENCES GENRE (GENRE)
);
CREATE TABLE MULTIPLEX ( 
   MP_NAME VARCHAR2 (20) DEFAULT 'NULL',   --PRIMARY KEY 설정
   CONSTRAINT MULTIPLEX_PK PRIMARY KEY(MP_NAME)
);


CREATE TABLE THEATER ( 
   TH_CODE VARCHAR2 (20) DEFAULT 'NULL' , --PRIMARY KEY 설정
   MOVIE_CODE VARCHAR (20) DEFAULT 'NULL',
   TH_NAME VARCHAR2 (25) DEFAULT 'NULL',
   TH_DATE DATE DEFAULT SYSDATE ,
   MP_NAME VARCHAR2 (25) DEFAULT 'NULL',   --FK
   FIRST_TIME VARCHAR2 (20) DEFAULT 'NULL' ,
   SECOND_TIME VARCHAR2 (20) DEFAULT 'NULL',
   THIRD_TIME VARCHAR2 (20) DEFAULT 'NULL',
   FOURTH_TIME VARCHAR2 (20) DEFAULT 'NULL',
   FIFTH_TIME VARCHAR2 (20) DEFAULT 'NULL',
   CONSTRAINT THEATER_PK PRIMARY KEY(TH_CODE),
   CONSTRAINT TH_FK_MOVIE FOREIGN KEY(MOVIE_CODE)REFERENCES MOVIE( MOVIE_CODE ),
   CONSTRAINT TH_FK_MP FOREIGN KEY(MP_NAME )REFERENCES MULTIPLEX (MP_NAME )
);



CREATE TABLE BOARD_META(
   BRD_NO NUMBER,
   USER_ID varchar2(15),
   BOOK_SERIAL_NO number,
   MOVIE_CODE VARCHAR2(10),
   GPOINT NUMBER,
   CONSTRAINT BOARD_META_FK_BRD_NO FOREIGN KEY(BRD_NO) REFERENCES BOARD(BRD_NO) on delete cascade,
   CONSTRAINT BOARD_META_FK_USER_ID FOREIGN KEY(USER_ID) REFERENCES MEMBER(USER_ID),
   CONSTRAINT BOARD_META_FK_BOOK_NO FOREIGN KEY(BOOK_SERIAL_NO) REFERENCES BOOK(BOOK_SERIAL_NO),
   CONSTRAINT BOARD_META_FK_MOVIE_NO FOREIGN KEY(MOVIE_CODE) REFERENCES MOVIE(MOVIE_CODE) on delete cascade
);

create table reservation (
    RES_NO NUMBER default 0 ,
    USER_ID VARCHAR2( 15 ) default 'NULL' ,
    book_serial_no NUMBER default 0,
    constraint RES_NO_pk primary key( RES_NO),
    constraint book_serial_no_fk foreign key( book_serial_no)
    references book( book_serial_no ) on delete cascade,
    constraint USER_ID_fk foreign key(USER_ID)
    references MEMBER(USER_ID) on delete cascade
);
CREATE TABLE TH_RESERVATION(
  TH_RES_NO NUMBER DEFAULT 0,
  RSV_DATE DATE DEFAULT SYSDATE,
  USER_ID VARCHAR2(15) DEFAULT 'NULL',
  TH_CODE VARCHAR2(100) DEFAULT 'NULL',
  TH_TIME VARCHAR2(100) DEFAULT 'NULL',
  CONSTRAINT TH_RESERVATION_PK PRIMARY KEY(TH_RES_NO),
  CONSTRAINT TH_RESERVATION_FK_USER_ID FOREIGN KEY(USER_ID) REFERENCES MEMBER(USER_ID),
  CONSTRAINT TH_RESERVATION_FK_TH_CODE FOREIGN KEY(TH_CODE) REFERENCES THEATER(TH_CODE)
);




CREATE TABLE BOOK_STAT_TYPE(
  STAT_TYPE_CODE NUMBER DEFAULT 0,
  STAT_TYPE_NAME VARCHAR2(50) DEFAULT 'NULL',
  CONSTRAINT BOOK_STAT_TYPE_PK PRIMARY KEY(STAT_TYPE_CODE)
);



CREATE TABLE BOOK_STAT_META(
  STAT_ID NUMBER DEFAULT 0,
  REG_DATE DATE DEFAULT SYSDATE,
  STAT_TYPE_CODE NUMBER DEFAULT 0,
  CONSTRAINT BOOK_STAT_META_PK PRIMARY KEY(STAT_ID),
  CONSTRAINT BOOK_STAT_META_FK_STAT_TYPE FOREIGN KEY(STAT_TYPE_CODE) REFERENCES BOOK_STAT_TYPE(STAT_TYPE_CODE) on delete cascade
);

CREATE TABLE BOOK_READ_STAT(
  STAT_ID NUMBER DEFAULT 0,
  USER_ID VARCHAR2(15),
  READ_CNT NUMBER DEFAULT 0,
  STAT_DATE VARCHAR2(7) DEFAULT 'NULL', -- 'YYYY-MM' 형식입니다.
  CONSTRAINT BOOK_READ_STAT_FK_STAT_ID FOREIGN KEY(STAT_ID) REFERENCES BOOK_STAT_META(STAT_ID) on delete cascade,
  CONSTRAINT BOOK_READ_STAT_FK_USER_ID FOREIGN KEY(USER_ID) REFERENCES MEMBER(USER_ID) on delete cascade
);

CREATE TABLE BOOK_AVG_GRADE(
    STAT_ID NUMBER DEFAULT 0,
    BOOK_SERIAL_NO NUMBER DEFAULT 0,
    AVG_POINT NUMBER DEFAULT 0,
    CONSTRAINT BOOK_GRADE_AVG_PK FOREIGN KEY(STAT_ID) REFERENCES BOOK_STAT_META(STAT_ID)
);


CREATE TABLE MOVIE_STAT_TYPE(
  STAT_TYPE_CODE NUMBER DEFAULT 0,
  STAT_TYPE_NAME VARCHAR2(50) DEFAULT 'NULL',
  CONSTRAINT MOVIE_STAT_TYPE_PK PRIMARY KEY(STAT_TYPE_CODE)
);



CREATE TABLE MOVIE_STAT_META(
  STAT_ID NUMBER DEFAULT 0,
  REG_DATE DATE DEFAULT SYSDATE,
  STAT_TYPE_CODE NUMBER DEFAULT 0,
  CONSTRAINT MOVIE_STAT_META_PK PRIMARY KEY(STAT_ID),
  CONSTRAINT MOVIE_STAT_META_FK_STAT_TYPE FOREIGN KEY(STAT_TYPE_CODE) REFERENCES MOVIE_STAT_TYPE(STAT_TYPE_CODE) on delete cascade
);

CREATE TABLE MOVIE_VIEW_STAT(
  STAT_ID NUMBER DEFAULT 0,
  USER_ID VARCHAR2(15),
  VIEW_CNT NUMBER DEFAULT 0,
  STAT_DATE VARCHAR2(7) DEFAULT 'NULL', -- 'YYYY-MM' 형식입니다.
  CONSTRAINT MOVIE_VIEW_STAT_FK_STAT_ID FOREIGN KEY(STAT_ID) REFERENCES MOVIE_STAT_META(STAT_ID) on delete cascade,
  CONSTRAINT MOVIE_VIEW_STAT_FK_USER_ID FOREIGN KEY(USER_ID) REFERENCES MEMBER(USER_ID) on delete cascade
);

CREATE TABLE MOVIE_AVG_GRADE(
    STAT_ID NUMBER DEFAULT 0,
    MOVIE_CODE VARCHAR2 (10),
    AVG_POINT NUMBER DEFAULT 0,
    CONSTRAINT MOVIE_GRADE_AVG_PK FOREIGN KEY(STAT_ID) REFERENCES MOVIE_STAT_META(STAT_ID),
    CONSTRAINT MOVIE_GRADE_AVG_FK_MOVIE FOREIGN KEY(MOVIE_CODE) REFERENCES MOVIE(MOVIE_CODE)
);






-- 테이블 생성부분  끝
-- 테이블 값 입력부분



--멤버 입력
insert into member ( USER_ID, USER_PW, NAME, EMAIL, PHONE_NUM, GENDER, BIRTHDAY, admin, reg_date)
values('abc110', 'abc110' , '에이씨' , 'abc110@naver.com' , '01042342412' , '남' , '1990-01-20' , 0, sysdate);

insert into member
values('abc111', 'abc111' , '심영순' , 'abc111@naver.com' ,  '01089594890' , '여' , '1980-02-02' , 0, sysdate );

insert into member
values('abc112', 'abc112' , '김길동' , 'abc112@naver.com' ,  '01034535434' , '남' , '1960-05-05' , 0, sysdate );

insert into member
values('abc113', 'abc113' , '박길동' , 'abc113@naver.com' , '01045234235' , '남' , '1990-01-20' ,  0, sysdate );

insert into member
values('abc114', 'abc114' , '뭐길동' , 'abc114@naver.com' , '01078664584' , '남' , '1990-01-20' ,  0, sysdate );

insert into member
values('abc115', 'abc115' , '김탱구' , 'abc115@naver.com' , '01042342410' , '남' ,'1970-01-20' , 0, sysdate );

insert into member
values('abc116', 'abc116' , '장동건' , 'abc116@naver.com'  ,'01042342412' , '남' ,'1980-01-20' , 0, sysdate );

insert into member
values('abc117', 'abc117' , '김태희' , 'abc117@naver.com'  ,'01042342412' , '여' ,'1990-01-20' , 0, sysdate );

insert into member
values('abc118', 'abc118' , '원빈' , 'abc118@naver.com'  , '01042342412' , '남' , '1990-01-20' ,  0, sysdate );

insert into member
values('abc119', 'abc119' , '홍길동' , 'abc119@naver.com'  ,'01045342412' , '여' ,'1990-01-20' ,0, sysdate );

insert into member
values('abc120', 'abc120' , '송혜교' , 'abc120@naver.com'  ,'01012442412' , '여' ,'1990-01-20' , 0, sysdate );

insert into member
values('abc121', 'abc121' , '박보영' , 'abc121@naver.com'  ,'01012323412' , '여' ,'1990-01-20' , 0, sysdate );

insert into member
values('admin', 'admin' , '관리자' , 'admin@naver.com'  ,'01015151515' , '여' ,'1990-01-20' ,1, sysdate );




-- 도서 분류 입력
insert into book_cat values('소설','나라별소설','한국소설');
insert into book_cat values('소설','나라별소설','영미소설');
insert into book_cat values('소설','나라별소설','일본소설');
insert into book_cat values('소설','나라별소설','중국소설');
insert into book_cat values('소설','나라별소설','기타나라소설');
insert into book_cat values('소설','고전문학','한국고전소설');
insert into book_cat values('소설','고전문학','세계고전');
insert into book_cat values('소설','고전문학','세계문학');
insert into book_cat values('소설','장르소설','공포-스릴러');
insert into book_cat values('소설','장르소설','로맨스');
insert into book_cat values('소설','장르소설','무협');
insert into book_cat values('소설','장르소설','전쟁-역사');
insert into book_cat values('소설','장르소설','추리');
insert into book_cat values('소설','장르소설','S-F판타지');
insert into book_cat values('소설','테마소설','가족-성장소설');
insert into book_cat values('소설','테마소설','라이트노벨');
insert into book_cat values('소설','테마소설','어른동화');
insert into book_cat values('소설','테마소설','영화-드라마소설');
insert into book_cat values('소설','테마소설','인터넷소설');

insert into book_cat values('경제-경영','경제','경제사상-이론');
insert into book_cat values('경제-경영','경제','경제전망');
insert into book_cat values('경제-경영','경제','국제경제');
insert into book_cat values('경제-경영','경제','금융-재정-화폐');
insert into book_cat values('경제-경영','경제','쉽게읽는경제');
insert into book_cat values('경제-경영','경제','한국경제');
insert into book_cat values('경제-경영','경영','경영일반-이론');
insert into book_cat values('경제-경영','경영','경영전략-혁신');
insert into book_cat values('경제-경영','경영','기업-경영자스토리');
insert into book_cat values('경제-경영','경영','경영실무');
insert into book_cat values('경제-경영','마케팅-세일즈','광고-홍보');
insert into book_cat values('경제-경영','마케팅-세일즈','마케팅일반');
insert into book_cat values('경제-경영','마케팅-세일즈','마케팅전략');
insert into book_cat values('경제-경영','마케팅-세일즈','영업-세일즈');
insert into book_cat values('경제-경영','마케팅-세일즈','트렌트-미래예측');
insert into book_cat values('경제-경영','재테크-투자','부동산-경매');
insert into book_cat values('경제-경영','재테크-투자','재테크일반');
insert into book_cat values('경제-경영','재테크-투자','주식-증권');

insert into book_cat values('역사-문화','역사-문화일반','역사의이해');
insert into book_cat values('역사-문화','역사-문화일반','역사학이론-비평');
insert into book_cat values('역사-문화','역사-문화일반','주제별역사');
insert into book_cat values('역사-문화','역사-문화일반','문화사일반');
insert into book_cat values('역사-문화','세계사','문화일반');
insert into book_cat values('역사-문화','세계사','시대별역사');
insert into book_cat values('역사-문화','세계사','국가별역사');
insert into book_cat values('역사-문화','세계사','국가별문화');
insert into book_cat values('역사-문화','한국사','고중세사');
insert into book_cat values('역사-문화','한국사','근현대사');
insert into book_cat values('역사-문화','한국사','한국문화');
insert into book_cat values('역사-문화','한국사','한국사일반');
insert into book_cat values('역사-문화','한국사','한국역사인물');

insert into book_cat values('유아','0~3세','0~3세-놀이책');
insert into book_cat values('유아','0~3세','0~3세-한국그림책');
insert into book_cat values('유아','0~3세','0~3세-외국그림책');
insert into book_cat values('유아','0~3세','0~3세-생활습관');
insert into book_cat values('유아','0~3세','0~3세-학습그림책');
insert into book_cat values('유아','4~7세','4~7세-놀이책');
insert into book_cat values('유아','4~7세','4~7세-한국그림책');
insert into book_cat values('유아','4~7세','4~7세-외국그림책');
insert into book_cat values('유아','4~7세','4~7세-생활습관');
insert into book_cat values('유아','4~7세','4~7세-학습그림책');
insert into book_cat values('유아','유아놀이책','입체-팝업북');
insert into book_cat values('유아','유아놀이책','스티커북-색칠놀이');
insert into book_cat values('유아','유아놀이책','퍼즐-플래시카드');
insert into book_cat values('유아','유아놀이책','기타-놀이책');
insert into book_cat values('유아','유아그림책','국내창작동화');
insert into book_cat values('유아','유아그림책','한국전래동화');
insert into book_cat values('유아','유아그림책','세계명작동화');
insert into book_cat values('유아','유아그림책','다른나라그림책');
insert into book_cat values('유아','유아학습','동요-동시');
insert into book_cat values('유아','유아학습','한글-말배우기');
insert into book_cat values('유아','유아학습','영어-숫자배우기');
insert into book_cat values('유아','유아학습','자연-과학');
insert into book_cat values('유아','유아학습','기타-학습책');

insert into book_cat values('컴퓨터-IT','웹-컴퓨터입문-활용','웹-홈페이지');
insert into book_cat values('컴퓨터-IT','웹-컴퓨터입문-활용','컴퓨터게임');
insert into book_cat values('컴퓨터-IT','웹-컴퓨터입문-활용','컴퓨터입문');
insert into book_cat values('컴퓨터-IT','웹-컴퓨터입문-활용','컴퓨터활용');
insert into book_cat values('컴퓨터-IT','IT전문서적','OS');
insert into book_cat values('컴퓨터-IT','IT전문서적','데이터베이스');
insert into book_cat values('컴퓨터-IT','IT전문서적','네트워크보안');
insert into book_cat values('컴퓨터-IT','IT전문서적','컴퓨터공학');
insert into book_cat values('컴퓨터-IT','IT전문서적','프로그래밍언어');
insert into book_cat values('컴퓨터-IT','IT전문서적','그래픽일반');
insert into book_cat values('컴퓨터-IT','IT전문서적','그래픽툴');
insert into book_cat values('컴퓨터-IT','오피스활용','Excel');
insert into book_cat values('컴퓨터-IT','오피스활용','PowerPoint');
insert into book_cat values('컴퓨터-IT','오피스활용','Word');
insert into book_cat values('컴퓨터-IT','컴퓨터수험서적','워드프로세스');
insert into book_cat values('컴퓨터-IT','컴퓨터수험서적','정보처리');
insert into book_cat values('컴퓨터-IT','컴퓨터수험서적','컴퓨터활용능력');
insert into book_cat values('컴퓨터-IT','컴퓨터수험서적','기타-수험서적');

insert into book_cat values('취업-수험서','취업-상식-적성검사','LEET');
insert into book_cat values('취업-수험서','취업-상식-적성검사','MEET-DEET');
insert into book_cat values('취업-수험서','취업-상식-적성검사','PSAT');
insert into book_cat values('취업-수험서','취업-상식-적성검사','일반상식');
insert into book_cat values('취업-수험서','취업-상식-적성검사','적성검사-SSAT');
insert into book_cat values('취업-수험서','취업-상식-적성검사','취업전략-면접');
insert into book_cat values('취업-수험서','취업-상식-적성검사','기타-적성검사');
insert into book_cat values('취업-수험서','공무원','10급기능직');
insert into book_cat values('취업-수험서','공무원','9급공무원');
insert into book_cat values('취업-수험서','공무원','7급공무원');
insert into book_cat values('취업-수험서','공무원','경찰직');
insert into book_cat values('취업-수험서','공무원','군무원');
insert into book_cat values('취업-수험서','공무원','기술직');
insert into book_cat values('취업-수험서','공무원','법원직');
insert into book_cat values('취업-수험서','공무원','세무직');
insert into book_cat values('취업-수험서','공무원','소방직');
insert into book_cat values('취업-수험서','공무원','지하철-철도청');
insert into book_cat values('취업-수험서','공무원','기타-공무원');
insert into book_cat values('취업-수험서','고시','교원임용고시');
insert into book_cat values('취업-수험서','고시','기술고시');
insert into book_cat values('취업-수험서','고시','사법고시');
insert into book_cat values('취업-수험서','고시','의사고시');
insert into book_cat values('취업-수험서','고시','행정-외무고시');
insert into book_cat values('취업-수험서','고시','기타-고시');
insert into book_cat values('취업-수험서','전문직','감정평가사');
insert into book_cat values('취업-수험서','전문직','공인중개사');
insert into book_cat values('취업-수험서','전문직','세무사');
insert into book_cat values('취업-수험서','전문직','노무사');
insert into book_cat values('취업-수험서','전문직','물류-유통-품질관리사');
insert into book_cat values('취업-수험서','전문직','법부사');
insert into book_cat values('취업-수험서','전문직','변리사');
insert into book_cat values('취업-수험서','전문직','사회복지사');
insert into book_cat values('취업-수험서','전문직','주택관리사');
insert into book_cat values('취업-수험서','전문직','투자상담사');
insert into book_cat values('취업-수험서','전문직','기타-전문직');


-- 도서 정보 입력
-- 1001 부터 시작 
-- 1011 부터 시퀀스값 시작
insert into book values(book_SEQ.nextval, '글자전쟁', '김진명', 'war.jpg', to_date('2015-08-01','yyyy-mm-dd'), '새움', '한국소설','5천 년간 잠들어 있던 거대한 진실 게임이 시작된다!소설이라는 장치를 넘어 근본적인 질문을 던지는 김진명의 대작 『글자전쟁』.<br/> 천년 제국 고구려를 되살린 대하소설 《고구려》와 미국과 중국이라는 거대한 충돌의 그림자에 드리운 한반도의 운명을 그린 《싸드》에 이어 ‘한자(漢字)’ 속에 숨겨진 우리의 역사와  치열한 정치적 메커니즘을 가지고 돌아왔다.<br/> 스탠퍼드 출신의 명망 있는 국제무기중개상 이태민은 명예보다는 오로지 500억의 커미션을 챙겨 안락한 인생을 살고픈 욕망으로 가득 찬 남자다.<br/> 무기제조업체 ‘록히드마틴’에 입사한 지 2년도 안 되어 헤비급 사원이 된 그는 특유의 비상한 머리와 국제정세를 꿰뚫는 날카로운 식견으로 나날이 탄탄대로를 걷는다.<br/>하지만 무기중개 과정에서 뜻하지 않은 법의 그물에 갇히게 되고, 궁지에 몰린 그는 검찰 출석 하루 전날 중국으로 도피한다.<br/> 그곳에서 비밀에 싸인 남자 ‘킬리만자로’에게 USB 하나를 받게 된 태민은 머지않아 그날 밤 ‘킬리만자로’가 살해당한 사실을 알게 된다.<br/> 의문의 죽음 앞에 남겨진 USB. ‘중국의 치명적 약점’이라던 킬리만자로의 말을 떠올리며 태민은 정체불명의 파일을 열게 되고, 역사에 숨겨진 거대한 비밀과 마주하게 되는데…….<br/>[인터넷 교보문고 제공]');
insert into book values(book_SEQ.nextval, '가짜 팔로 하는 포옹', '김중혁', 'arm.jpg', to_date('2015-07-27','yyyy-mm-dd'), '문학동네', '한국소설','가짜 팔로 뒤지게 안아주는 내용');
insert into book values(book_SEQ.nextval, '거짓말', '한은형', 'lie.jpg', to_date('2015-07-10','yyyy-mm-dd'), '한겨레출판사', '한국소설','존나 뻥치는 내용');
insert into book values(book_SEQ.nextval, '싸나희 순정', '류근', 'ssanahee.jpg', to_date('2015-07-05','yyyy-mm-dd'), '문학세계사',  '한국소설','사나이로 태어나서 할일도 많다만~~ 너와 난 나라 지키는 영광에 살았다~~ 뚠뚠~');
insert into book values(book_SEQ.nextval, '뱀파이어의 키스 2/완결', '신지은', 'vam.jpg', to_date('2015-06-17','yyyy-mm-dd'), '테라스북', '한국소설','아 ~ 몰라 끝나쪙~');
insert into book values(book_SEQ.nextval, '선의 법칙', '편혜영', 'seon.jpg', to_date('2015-06-15','yyyy-mm-dd'), '문학동네', '한국소설','착한일 하고 살아야지요~~');
insert into book values(book_SEQ.nextval, '트렁크', '김려령', 'trunc.jpg', to_date('2015-05-29','yyyy-mm-dd'), '창비', '한국소설','트렁크 빤쓰 입고 돌아다니는 내용인가?? 아몰랑~');
insert into book values(book_SEQ.nextval, '발원1', '김선우', 'balwon1.jpg', to_date('2015-05-25','yyyy-mm-dd'), '민음사', '한국소설','발원하는 내용 1권');
insert into book values(book_SEQ.nextval, '발원2', '김선우', 'balwon2.jpg', to_date('2015-05-25','yyyy-mm-dd'), '믿음사', '한국소설','발원하는 내용 2권');
insert into book values(book_SEQ.nextval, '정령왕 엘퀴네스 7', '장현도', 'elque.jpg', to_date('2015-05-20','yyyy-mm-dd'), '드림북스', '한국소설','내가 바로 정령왕이다~~');
insert into book values(book_SEQ.nextval, '새의 선물', '은희경', 'presentOfBird.jpg', to_date('2015-05-21','yyyy-mm-dd'), '문학동네', '한국소설','『새의 선물』은 때로는 웃음이 터져나오는 귀여운 간교함으로, 때로는 경쾌한 상상력으로 삶의 금기와 규범체계, 사회의 지식 메커니즘 따위의 고정된 인식틀을 해체하는 삶의 모험적, 도전적 통찰이 곳곳에서 빛을 발한다. 인생에 대한 냉소로부터 비롯된 시니컬한 시선이 갖가지 희극적인 삽화들 속에서 리얼하게 펼쳐지는 이 소설은, 그럼에도 불구하고 삶의 진실이란 무엇인가, 진실한 사랑이란 무엇인가를 끊임없이 되묻게 한다.');
insert into book values(book_SEQ.nextval, '7년의 밤', '정유정', 'nightOf7years.jpg', to_date('2015-05-23','yyyy-mm-dd'), '은행나무', '한국소설','제1회 세계청소년문학상 수상작 <내 인생의 스프링 캠프>, 제5회 세계문학상 수상작 <내 심장을 쏴라> 작가 정유정의 장편소설. 수상 이후 오랜 시간 준비하여 야심 차게 내놓는 소설로, 치밀한 사전 조사와 압도적인 상상력으로 무장한 작품이다. 7년의 밤 동안 아버지와 아들에게 일어난 슬프고 신비로우며 통렬한 이야기가 펼쳐진다.');
insert into book values(book_SEQ.nextval, '나는 나를 파괴할 권리가 있다', '김영하', 'elibileToDestroyMyself.jpg', to_date('2015-05-22','yyyy-mm-dd'), '은행나무', '한국소설','제1회 세계청소년문학상 수상작 <내 인생의 스프링 캠프>, 제5회 세계문학상 수상작 <내 심장을 쏴라> 작가 정유정의 장편소설. 수상 이후 오랜 시간 준비하여 야심 차게 내놓는 소설로, 치밀한 사전 조사와 압도적인 상상력으로 무장한 작품이다. 7년의 밤 동안 아버지와 아들에게 일어난 슬프고 신비로우며 통렬한 이야기가 펼쳐진다.');
insert into book values(book_SEQ.nextval, '엄마의 말뚝', '박완서', 'momsStake.jpg', to_date('2015-05-25','yyyy-mm-dd'), '맑은소리', '한국소설','어릴적 영웅이었던 오빠를 앗아간 전쟁의 악의를 모티브로 쓴 박완서의 자전적 연작 소설 『엄마의 말뚝』. 민족 전체의 비극을 대표하는 한 청년의 죽음과 가족의 아픔, 고난을 그린 작품이다.');
insert into book values(book_SEQ.nextval, '어디선가 나를 찾는 전화벨이 울리고', '신경숙', 'callForMe.jpg', to_date('2015-05-26','yyyy-mm-dd'), '문학동네', '한국소설','신경숙 장편소설 『어디선가 나를 찾는 전화벨이 울리고』. 이 소설은 사람이 사람을 어떻게 사랑하는가를 추적해가는 작품으로, 작가 특유의 섬세한 문체와 묘사로 자연스럽게 이야기의 흐름을 이끌어간다. 그때에는 오늘 같은 시간이 우리에게 다가오리라는 것을 어찌 짐작할 수가 있었을까. 초여름 아름드리 연둣빛 나뭇잎보다 더 밝게 빛나던 우리, 그 청춘의 한 시절의 이야기가 시작된다.');
insert into book values(book_SEQ.nextval, '덕혜옹주', '권비용', 'duckhyae.jpg', to_date('2015-05-25','yyyy-mm-dd'), '다산책방', '한국소설','가장 고귀한 신분으로 태어났지만 가장 외롭게 생을 마감했던 덕혜옹주에 대한 소설『덕혜옹주』. 어린 나이에 고종황제의 죽음을 목격한 후, 일본으로 끌려가 냉대와 감시로 점철된 십대 시절을 보낸 덕혜옹주는 일본 남자와의 강제결혼, 10년간의 정신병원 감금생활, 딸의 자살 등을 겪으면서 정서적으로, 신체적으로 쇠약해진다. 치욕스러운 시간 속에서 그녀를 붙들었던 건 조국에 대한 그리움과 삶의 터전을 되찾겠다는 결연한 의지뿐이었다. 그러나 그녀가 그토록 사랑했던 조국은 해방 후에 그녀를 찾지 않는데….');
insert into book values(book_SEQ.nextval, '우아한 거짓말', '김려령', 'elegantLie.jpg', to_date('2015-05-23','yyyy-mm-dd'), '창비', '한국소설','<완득이>의 작가 김려령이 선보이는 새로운 장편소설『우아한 거짓말』. 이 작품은 평범해 보이던 열네 살 소녀의 죽음에서 시작된다. 동생의 죽음을 이해할 수 없었던 언니는 동생이 남긴 흔적을 살펴보고, 숨겨져 있던 진실이 그 모습을 드러낸다. <완득이>와는 전혀 다른 분위기의 작품이지만, 한층 깊고 넓어진 작가의 문학세계를 엿볼 수 있다.');
insert into book values(book_SEQ.nextval, '죽은 왕녀를 위한 파반느', '박민규', 'pavanne.jpg', to_date('2015-05-24','yyyy-mm-dd'), '예담', '한국소설','새로운 상상력과 실험정신으로 주목받아온 작가 박민규의 독특한 연애소설『죽은 왕녀를 위한 파반느』. 20대 성장소설의 형식을 빌려, 못생긴 여자와 그녀를 사랑했던 한 남자의 이야기를 그리고 있다. 작가 스스로 ''80년대 빈티지 신파''라고 말할 만큼, 자본주의가 시작된 80년대 중반의 서울을 무대로 아련한 첫사랑의 기억을 풀어놓는다.');
insert into book values(book_SEQ.nextval, '내 심장을 쏴라', '정유정', 'shootToMyHeart.jpg', to_date('2015-05-21','yyyy-mm-dd'), '은행나무', '한국소설','2009년 제5회 세계문학상 수상작 《내 심장을 쏴라》가 은행나무에서 출간되었다. 《내 심장을 쏴라》는 자신을 옥죄는 운명에 맞서 새로운 인생을 향해 끝없이 탈출을 꿈꾸고 시도하는 두 젊은이의 치열한 분투기를 그린 작품이다. 현장의 리얼리티가 생생하게 살아 있고, 한 번 빠져들면 끝까지 읽지 않고서는 책을 놓을 수 없는 흡인력을 자랑한다. 김화영, 황석영, 박범신, 구효서, 은희경, 김형경, 하응백, 서영채, 김미현 등 9명의 심사위원으로부터 “뜨거운 감동과 생에 대한 각성이 꿈틀대며, 희망에 대한 끈을 다시 움켜잡게 만드는 마력이 깃든 작품”이라는 평을 받았다.');
insert into book values(book_SEQ.nextval, '위저드 베이커리', '구병모', 'wizardBakery.jpg', to_date('2015-05-15','yyyy-mm-dd'), '창비', '한국소설','제2회 창비청소년문학상을 수상한 구병모의 장편소설『위저드 베이커리』. 2008년의 <완득이>를 잇는, 2009년 창비청소년문학상 수상작이다. 억울한 누명을 쓰고 집에서 뛰쳐나온 열여섯 살 소년이 우연히 머물게 된 신비한 빵집에서 겪게 되는 사건들을 그리고 있다. 미스터리와 호러와 판타지를 넘나드는 작가의 독특한 상상력과 서사적 역량이 돋보인다.');




--예약 입력
-- 1011부터 
insert into reservation values(res_seq.nextval, 'abc111', 1001);
insert into reservation values(res_seq.nextval, 'abc111', 1002);
insert into reservation values(res_seq.nextval, 'abc111', 1003);
insert into reservation values(res_seq.nextval, 'abc111', 1004);
insert into reservation values(res_seq.nextval, 'abc111', 1005);
insert into reservation values(res_seq.nextval, 'abc111', 1006);
insert into reservation values(res_seq.nextval, 'abc111', 1007);
insert into reservation values(res_seq.nextval, 'abc111', 1008);
insert into reservation values(res_seq.nextval, 'abc111', 1009);
insert into reservation values(res_seq.nextval, 'abc111', 1010);


-- 게시판 입력
-- 책 리뷰(1001), 영화 리뷰(1002)
-- 책 리뷰 입력

--INSERT INTO BOARD (BRD_NO, USER_ID, BRD_TYPE, BRD_CATEGORY, BRD_TITLE, BRD_CONTENT, BRD_DATE, BRD_VIEWS)
--VALUES( BRD_NO.NEXTVAL, 'abc111', 1001 , '한국소설' ,'글자전쟁 재미없당' ,'이거 사지마셈' , sysdate, 152);

INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '글자전쟁 재미있네요 ㅎㅎ' ,'꼭 보세요' , to_date('2015-04-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '가짜 팔로 하는 포옹 너무 재미있어요' ,'이거 사면 안되요..' , to_date('2015-04-27', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '거짓말 너무 재미있어요' ,'이 책은 살면서 꼭 봐야할 필수 권장도서' , to_date('2015-05-04', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '싸나희 순정 너무 재미있어요 ㅋ' ,'머릿말만 보다 지루해서 접음' , to_date('2015-05-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '뱀파이어의 키스 너무 재미있어요 !' ,'완전 재미있어요.' , to_date('2015-06-05', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '선의 법칙 너무 재미있네요 ㅎㅎ' ,'어른아이 할 것 없이 전부봐야 합니다.' , to_date('2015-06-15', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '트렁크 너무 재미있네요 !!' ,'너무 재미있어요' , to_date('2015-06-15', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '발원1 너무 재미있습니다.' ,'중독되는 책입니다.' , to_date('2015-06-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '발원2 너무 재미있군요 ㅎ' ,'역시 발원 시리즈죠.' , to_date('2015-06-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '엘퀴네스 너무 재미있어요 ㅎㅎ' ,'제 점수는요' , to_date('2015-07-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '새의 선물 너무 재미있습니다 !!' ,'너무 좋은 책이라 제가 운영하는 북카페에도 넣어놨습니다.' , to_date('2015-07-30', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1001 ,'한국소설', '7년의 밤 너무 재미있어요 ㅎㅎ' ,'너무 재미있어요.' , to_date('2015-08-02', 'yyyy-mm-dd'), 152 );

-- 영화 리뷰(게시판성격)입력
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'어드벤처,SF', '쥬라기월드 너무 재미있어요' ,'꼭 보세요~' , to_date('2015-03-27', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'호러', '인사이드아웃 재미있음' ,'너무 재미있다 !!' , to_date('2015-04-21', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'코미디', '픽셀 재미있어요 ㅋㅋ' ,'소재가 너무 독특해서 좋았어요.' , to_date('2015-04-23', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'호러', '인시디어스3 재미있어요~' ,'재미있었다 ㅎㅎ' , to_date('2015-05-25', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'미스터리', '손님 굳굳' ,'또 보고 싶다 ㅎㅎ' , to_date('2015-06-07', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'액션', '베테랑 꼭 보세요' ,'이거 진짜 재미있어요 꼭 보세요 ㅎ' , to_date('2015-06-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'액션', '암살 굳!' ,'너무 재미있어요 ㅎㅎㅎ' , to_date('2015-06-24', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'로맨스', '뷰티 인사이드 넘 재밌다' ,'재미있었다 크 ' , to_date('2015-06-30', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'액션', '판타스틱4 대박' ,'너무 재미있당 ㅋㅋㅋ' , to_date('2015-07-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'호러', '퇴마: 무녀굴 보고 왔어요 ㅎㅎ' ,'이거 꼭 보세요 ㅎㅎ' , to_date('2015-07-10', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc117', 1002 ,'코미디', '미쓰 와이프 너무 재밌어요' ,'너무 재미있어요 ㅎㅎ' , to_date('2015-08-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc116', 1002 ,'어드벤처,SF', '쥬라기월드 진짜 재미있어요' ,'너무 재미있어요 ㅋ' , to_date('2015-04-10', 'yyyy-mm-dd'), 152 );

-- 더미값 추가 (북, 영화 따로따로 추가해야 하지만 그러면 시퀀스 문제로 board_meta 전체 재수정해야 해서 여기서 추가합니다.)
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc116', 1001 ,'한국소설', '글자전쟁 재미있네요 ㅎㅎ' ,'꼭 보세요' , to_date('2015-04-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc116', 1001 ,'한국소설', '싸나희 순정 너무 재미있어요 ㅋ' ,'머릿말만 보다 지루해서 접음' , to_date('2015-05-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc116', 1001 ,'한국소설', '선의 법칙 너무 재미있네요 ㅎㅎ' ,'어른아이 할 것 없이 전부봐야 합니다.' , to_date('2015-06-15', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc116', 1001 ,'한국소설', '발원1 너무 재미있습니다.' ,'중독되는 책입니다.' , to_date('2015-06-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc116', 1001 ,'한국소설', '엘퀴네스 너무 재미있어요 ㅎㅎ' ,'제 점수는요' , to_date('2015-07-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc116', 1001 ,'한국소설', '7년의 밤 너무 재미있어요 ㅎㅎ' ,'너무 재미있어요.' , to_date('2015-08-02', 'yyyy-mm-dd'), 152 );

INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1001 ,'한국소설', '거짓말 너무 재미있어요' ,'이 책은 살면서 꼭 봐야할 필수 권장도서' , to_date('2015-05-04', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1001 ,'한국소설', '싸나희 순정 너무 재미있어요 ㅋ' ,'머릿말만 보다 지루해서 접음' , to_date('2015-05-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1001 ,'한국소설', '뱀파이어의 키스 너무 재미있어요 !' ,'완전 재미있어요.' , to_date('2015-06-05', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1001 ,'한국소설', '선의 법칙 너무 재미있네요 ㅎㅎ' ,'어른아이 할 것 없이 전부봐야 합니다.' , to_date('2015-06-15', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1001 ,'한국소설', '트렁크 너무 재미있네요 !!' ,'너무 재미있어요' , to_date('2015-06-15', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1001 ,'한국소설', '발원2 너무 재미있군요 ㅎ' ,'역시 발원 시리즈죠.' , to_date('2015-06-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1001 ,'한국소설', '7년의 밤 너무 재미있어요 ㅎㅎ' ,'너무 재미있어요.' , to_date('2015-08-02', 'yyyy-mm-dd'), 152 );

INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1001 ,'한국소설', '글자전쟁 재미있네요 ㅎㅎ' ,'꼭 보세요' , to_date('2015-04-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1001 ,'한국소설', '가짜 팔로 하는 포옹 너무 재미있어요' ,'이거 사면 안되요..' , to_date('2015-04-27', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1001 ,'한국소설', '거짓말 너무 재미있어요' ,'이 책은 살면서 꼭 봐야할 필수 권장도서' , to_date('2015-05-04', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1001 ,'한국소설', '싸나희 순정 너무 재미있어요 ㅋ' ,'머릿말만 보다 지루해서 접음' , to_date('2015-05-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1001 ,'한국소설', '뱀파이어의 키스 너무 재미있어요 !' ,'완전 재미있어요.' , to_date('2015-06-05', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1001 ,'한국소설', '발원1 너무 재미있습니다.' ,'중독되는 책입니다.' , to_date('2015-06-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1001 ,'한국소설', '발원2 너무 재미있군요 ㅎ' ,'역시 발원 시리즈죠.' , to_date('2015-06-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1001 ,'한국소설', '새의 선물 너무 재미있습니다 !!' ,'너무 좋은 책이라 제가 운영하는 북카페에도 넣어놨습니다.' , to_date('2015-07-30', 'yyyy-mm-dd'), 152 );

INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1001 ,'한국소설', '글자전쟁 재미있네요 ㅎㅎ' ,'꼭 보세요' , to_date('2015-04-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1001 ,'한국소설', '발원2 너무 재미있군요 ㅎ' ,'역시 발원 시리즈죠.' , to_date('2015-06-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1001 ,'한국소설', '엘퀴네스 너무 재미있어요 ㅎㅎ' ,'제 점수는요' , to_date('2015-07-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1001 ,'한국소설', '새의 선물 너무 재미있습니다 !!' ,'너무 좋은 책이라 제가 운영하는 북카페에도 넣어놨습니다.' , to_date('2015-07-30', 'yyyy-mm-dd'), 152 );

INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1001 ,'한국소설', '글자전쟁 재미있네요 ㅎㅎ' ,'꼭 보세요' , to_date('2015-04-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1001 ,'한국소설', '가짜 팔로 하는 포옹 너무 재미있어요' ,'이거 사면 안되요..' , to_date('2015-04-27', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1001 ,'한국소설', '싸나희 순정 너무 재미있어요 ㅋ' ,'머릿말만 보다 지루해서 접음' , to_date('2015-05-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1001 ,'한국소설', '트렁크 너무 재미있네요 !!' ,'너무 재미있어요' , to_date('2015-06-15', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1001 ,'한국소설', '발원1 너무 재미있습니다.' ,'중독되는 책입니다.' , to_date('2015-06-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1001 ,'한국소설', '발원2 너무 재미있군요 ㅎ' ,'역시 발원 시리즈죠.' , to_date('2015-06-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1001 ,'한국소설', '새의 선물 너무 재미있습니다 !!' ,'너무 좋은 책이라 제가 운영하는 북카페에도 넣어놨습니다.' , to_date('2015-07-30', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1001 ,'한국소설', '7년의 밤 너무 재미있어요 ㅎㅎ' ,'너무 재미있어요.' , to_date('2015-08-02', 'yyyy-mm-dd'), 152 );

INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '글자전쟁 재미있네요 ㅎㅎ' ,'꼭 보세요' , to_date('2015-04-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '가짜 팔로 하는 포옹 너무 재미있어요' ,'이거 사면 안되요..' , to_date('2015-04-27', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '거짓말 너무 재미있어요' ,'이 책은 살면서 꼭 봐야할 필수 권장도서' , to_date('2015-05-04', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '싸나희 순정 너무 재미있어요 ㅋ' ,'머릿말만 보다 지루해서 접음' , to_date('2015-05-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '뱀파이어의 키스 너무 재미있어요 !' ,'완전 재미있어요.' , to_date('2015-06-05', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '선의 법칙 너무 재미있네요 ㅎㅎ' ,'어른아이 할 것 없이 전부봐야 합니다.' , to_date('2015-06-15', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '트렁크 너무 재미있네요 !!' ,'너무 재미있어요' , to_date('2015-06-15', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '발원1 너무 재미있습니다.' ,'중독되는 책입니다.' , to_date('2015-06-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '발원2 너무 재미있군요 ㅎ' ,'역시 발원 시리즈죠.' , to_date('2015-06-20', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '엘퀴네스 너무 재미있어요 ㅎㅎ' ,'제 점수는요' , to_date('2015-07-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '새의 선물 너무 재미있습니다 !!' ,'너무 좋은 책이라 제가 운영하는 북카페에도 넣어놨습니다.' , to_date('2015-07-30', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc111', 1001 ,'한국소설', '7년의 밤 너무 재미있어요 ㅎㅎ' ,'너무 재미있어요.' , to_date('2015-08-02', 'yyyy-mm-dd'), 152 );

INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1002 ,'어드벤처,SF', '쥬라기월드 너무 재미있어요' ,'꼭 보세요~' , to_date('2015-03-27', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1002 ,'호러', '인사이드아웃 재미있음' ,'너무 재미있다 !!' , to_date('2015-04-21', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1002 ,'액션', '베테랑 꼭 보세요' ,'이거 진짜 재미있어요 꼭 보세요 ㅎ' , to_date('2015-06-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1002 ,'액션', '암살 굳!' ,'너무 재미있어요 ㅎㅎㅎ' , to_date('2015-06-24', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1002 ,'로맨스', '뷰티 인사이드 넘 재밌다' ,'재미있었다 크 ' , to_date('2015-06-30', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1002 ,'코미디', '미쓰 와이프 너무 재밌어요' ,'너무 재미있어요 ㅎㅎ' , to_date('2015-08-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc115', 1002 ,'어드벤처,SF', '쥬라기월드 진짜 재미있어요' ,'너무 재미있어요 ㅋ' , to_date('2015-04-10', 'yyyy-mm-dd'), 152 );

INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1002 ,'어드벤처,SF', '쥬라기월드 너무 재미있어요' ,'꼭 보세요~' , to_date('2015-03-27', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1002 ,'호러', '인사이드아웃 재미있음' ,'너무 재미있다 !!' , to_date('2015-04-21', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1002 ,'코미디', '픽셀 재미있어요 ㅋㅋ' ,'소재가 너무 독특해서 좋았어요.' , to_date('2015-04-23', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1002 ,'액션', '암살 굳!' ,'너무 재미있어요 ㅎㅎㅎ' , to_date('2015-06-24', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1002 ,'로맨스', '뷰티 인사이드 넘 재밌다' ,'재미있었다 크 ' , to_date('2015-06-30', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1002 ,'호러', '퇴마: 무녀굴 보고 왔어요 ㅎㅎ' ,'이거 꼭 보세요 ㅎㅎ' , to_date('2015-07-10', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc114', 1002 ,'어드벤처,SF', '쥬라기월드 진짜 재미있어요' ,'너무 재미있어요 ㅋ' , to_date('2015-04-10', 'yyyy-mm-dd'), 152 );


INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'어드벤처,SF', '쥬라기월드 너무 재미있어요' ,'꼭 보세요~' , to_date('2015-03-27', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'호러', '인사이드아웃 재미있음' ,'너무 재미있다 !!' , to_date('2015-04-21', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'코미디', '픽셀 재미있어요 ㅋㅋ' ,'소재가 너무 독특해서 좋았어요.' , to_date('2015-04-23', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'호러', '인시디어스3 재미있어요~' ,'재미있었다 ㅎㅎ' , to_date('2015-05-25', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'미스터리', '손님 굳굳' ,'또 보고 싶다 ㅎㅎ' , to_date('2015-06-07', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'액션', '베테랑 꼭 보세요' ,'이거 진짜 재미있어요 꼭 보세요 ㅎ' , to_date('2015-06-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'액션', '암살 굳!' ,'너무 재미있어요 ㅎㅎㅎ' , to_date('2015-06-24', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'로맨스', '뷰티 인사이드 넘 재밌다' ,'재미있었다 크 ' , to_date('2015-06-30', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'액션', '판타스틱4 대박' ,'너무 재미있당 ㅋㅋㅋ' , to_date('2015-07-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'호러', '퇴마: 무녀굴 보고 왔어요 ㅎㅎ' ,'이거 꼭 보세요 ㅎㅎ' , to_date('2015-07-10', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'코미디', '미쓰 와이프 너무 재밌어요' ,'너무 재미있어요 ㅎㅎ' , to_date('2015-08-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc113', 1002 ,'어드벤처,SF', '쥬라기월드 진짜 재미있어요' ,'너무 재미있어요 ㅋ' , to_date('2015-04-10', 'yyyy-mm-dd'), 152 );

INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'어드벤처,SF', '쥬라기월드 너무 재미있어요' ,'꼭 보세요~' , to_date('2015-03-27', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'호러', '인사이드아웃 재미있음' ,'너무 재미있다 !!' , to_date('2015-04-21', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'코미디', '픽셀 재미있어요 ㅋㅋ' ,'소재가 너무 독특해서 좋았어요.' , to_date('2015-04-23', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'호러', '인시디어스3 재미있어요~' ,'재미있었다 ㅎㅎ' , to_date('2015-05-25', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'미스터리', '손님 굳굳' ,'또 보고 싶다 ㅎㅎ' , to_date('2015-06-07', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'액션', '베테랑 꼭 보세요' ,'이거 진짜 재미있어요 꼭 보세요 ㅎ' , to_date('2015-06-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'액션', '암살 굳!' ,'너무 재미있어요 ㅎㅎㅎ' , to_date('2015-06-24', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'로맨스', '뷰티 인사이드 넘 재밌다' ,'재미있었다 크 ' , to_date('2015-06-30', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'액션', '판타스틱4 대박' ,'너무 재미있당 ㅋㅋㅋ' , to_date('2015-07-01', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'호러', '퇴마: 무녀굴 보고 왔어요 ㅎㅎ' ,'이거 꼭 보세요 ㅎㅎ' , to_date('2015-07-10', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'코미디', '미쓰 와이프 너무 재밌어요' ,'너무 재미있어요 ㅎㅎ' , to_date('2015-08-16', 'yyyy-mm-dd'), 152 );
INSERT INTO BOARD VALUES(BRD_NO.NEXTVAL,'abc112', 1002 ,'어드벤처,SF', '쥬라기월드 진짜 재미있어요' ,'너무 재미있어요 ㅋ' , to_date('2015-04-10', 'yyyy-mm-dd'), 152 );








-- 영화 장르 입력
INSERT INTO GENRE VALUES( '액션' );
INSERT INTO GENRE VALUES( '미스터리' );
INSERT INTO GENRE VALUES( '코미디' );
INSERT INTO GENRE VALUES( '호러' );
INSERT INTO GENRE VALUES( '로맨스' );
INSERT INTO GENRE VALUES( '어드벤처,SF' );
INSERT INTO GENRE VALUES( '범죄' );
INSERT INTO GENRE VALUES( '장르' );
INSERT INTO GENRE VALUES( '드라마' );
INSERT INTO GENRE VALUES( '액션,코미디' );
INSERT INTO GENRE VALUES( '애니메이션' );




-- 영화 정보 입력
INSERT INTO MOVIE( MOVIE_CODE, GENRE ,TITLE , VIEW_TIME, POSTER ,REG_DATE , BACKGROUND, IFRAME ,MOVIE_INFO)
VALUES( 'M001' ,'어드벤처,SF' , '쥬라기월드' ,'2015.06.11' , 'JURASSICWORLD.jpg', '2015.06.11' ,'JURASSICWORLD.JPG' , '<IFRAME WIDTH="800" HEIGHT="515" SRC="HTTPS://WWW.YOUTUBE.COM/EMBED/JPZ1X4BW5JS" FRAMEBORDER="0" ALLOWFULLSCREEN></IFRAME>' ,'영화 설명');

INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M011','호러','인사이드 아웃','2015.06.11','INSIDEOUT.JPG','15/06/11','INSIDEOUTBACK.JPG','<IFRAME WIDTH="800" HEIGHT="515" SRC="HTTPS://WWW.YOUTUBE.COM/EMBED/PHN0KWCXX-A" FRAMEBORDER="0" ALLOWFULLSCREEN></IFRAME>','이건 설명');
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M003','코미디','픽셀','2015.07.09','Pixels.jpg','2015.07.09','PixelsBack.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/Aw-LHRy905c" frameborder="0" allowfullscreen></iframe>','영화 설명');
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M004','호러','인시디어스3','2015.07.09','Insidious.jpg','2015.07.09','InsidiousBack.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/qW6Yp5t7AVI" frameborder="0" allowfullscreen></iframe>','영화 설명');
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M002','미스터리','손님','2015.07.09','sonnim.jpg','2015.07.09','sonnimBack.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/_5SroXuhptg" frameborder="0" allowfullscreen></iframe>','영화 설명');
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M021','액션','베테랑','2015.08.05','veteran.jpg','2015.08.05','veteranBack.jpg','<iframe width="800" height="515" src="https://www.youtube.com/embed/El8gg8XH7X4" frameborder="0" allowfullscreen></iframe>','한 번 꽂힌 것은 무조건 끝을 보는 행동파 ‘서도철’(황정민), 20년 경력의 승부사 ‘오팀장’(오달수), 위장 전문 홍일점 ‘미스봉’(장윤주), 육체파 ‘왕형사’(오대환), 막내 ‘윤형사’(김시후)까지 겁 없고, 못 잡는 것 없고, 봐주는 것 없는 특수 강력사건 담당 광역수사대. 오랫동안 쫓던 대형 범죄를 해결한 후 숨을 돌리려는 찰나, 서도철은 재벌 3세 ‘조태오’(유아인)를 만나게 된다. 세상 무서울 것 없는 안하무인의 조태오와 언제나 그의 곁을 지키는 오른팔 ‘최상무’(유해진). 서도철은 의문의 사건을 쫓던 중 그들이 사건의 배후에 있음을 직감한다. 건들면 다친다는 충고에도 불구하고 포기하지 않는 서도철의 집념에 판은 걷잡을 수 없이 커져가고 조태오는 이를 비웃기라도 하듯 유유히 포위망을 빠져 나가는데… 베테랑 광역수사대 VS 유아독존 재벌 3세 2015년 여름, 자존심을 건 한판 대결이 시작된다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M022','액션','암살','2015.07.22','assassination.jpg','2015.07.22','assassinationBack.jpg','<iframe width="800" height="515" src="https://www.youtube.com/embed/LllIFYytkfs" frameborder="0" allowfullscreen></iframe>','1933년 조국이 사라진 시대 대한민국 임시정부는 일본 측에 노출되지 않은 세 명을 암살작전에 지목한다. 한국 독립군 저격수 안옥윤, 신흥무관학교 출신 속사포, 폭탄 전문가 황덕삼! 김구의 두터운 신임을 받는 임시정부 경무국 대장 염석진은 이들을 찾아 나서기 시작한다. 암살단의 타깃은 조선주둔군 사령관 카와구치 마모루와 친일파 강인국. 한편, 누군가에게 거액의 의뢰를 받은 청부살인업자 하와이 피스톨이 암살단의 뒤를 쫓는데... 친일파 암살작전을 둘러싼 이들의 예측할 수 없는 운명이 펼쳐진다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M023','로맨스','뷰티 인사이드','2015.08.20','beautyinside.jpg','2015.08.20','beautyinsideback.jpg','<iframe width="800" height="515" src="https://www.youtube.com/embed/-dm_XE9qdjU" frameborder="0" allowfullscreen></iframe>','남자, 여자, 아이, 노인.. 심지어 외국인까지! 자고 일어나면 매일 다른 모습으로 변하는 남자, ‘우진’. 그에게 처음으로 비밀을 말하고 싶은 단 한 사람이 생겼다. 드디어 D-DAY! ‘우진’은 그녀에게 자신의 마음을 고백하기로 하는데… “초밥이 좋아요? 스테이크가 좋아요? 사실.. 연습 엄청 많이 했어요. 오늘 꼭 그쪽이랑 밥 먹고 싶어서…”'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M024','액션','판타스틱4','2015.08.20','fantastic4.jpg','2015.08.20','fantastic4back.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/-t1IK8-6vng" frameborder="0" allowfullscreen></iframe>','운명에 맞선 네 명의 슈퍼 히어로들의 등장! 천재적인 두뇌의 소유자 리드(마일즈 텔러). 저명한 과학자 스톰 박사의 눈에 띄어 과학연구소 백스터에서 다른 차원으로 이동할 수 있는 발명품을 개발한다. 자신의 발명품을 이용해  연구원인 빅터(토비 캡벨), 스톰박사의 딸인 수(케이트 마라)와 아들 조니(마이클 B. 조던), 그리고 절친한 친구인 벤(제이미 벨)과 함께 무한한 에너지원이 있는 행성으로의 이동을  시도한 리드. 하지만 그곳에서 일어난 폭발로 인해 네 사람은 심각한 부상을 입게 되고, 빅터는 실종된다. 겨우 구조되어 깨어난 이들은 자신의 신체에 엄청난 변화가 생겼다는 사실을 알게 되고 갑작스러운 변화에 괴로워한다. 정부와 군관계자들은 그들을 무기로 이용하려 하고, 자신의 운 명을 받아들인 네 사람은 강력한 힘, 닥터 둠 으로부터 지구를 구해야만 하는데……'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M025','호러','퇴마: 무녀굴','2015.08.20','Chosen.jpg','2015.07.22','Chosenback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/ZU-hWmipni0" frameborder="0" allowfullscreen></iframe>','“제게 숨기는 게 있으시면 안됩니다.” 유명한 정신과 전문의 ‘진명’은 그의 조수이자 영매인 ‘지광’과 함께 퇴마를 하는 ‘퇴마사’이다. 평소처럼 빙의 환자를 치료하던 어느 날, 절친한 선배에게서 의문의 메일이 왔다. 그리고 갑작스러운 선배의 죽음으로 찾아간 장례식장에서 무서운 기운을 느꼈다. 그 곳에서 그녀를 만났다! “선생님… 제발… 도와주세요……” 하루에도 몇 번씩 다른 사람처럼 변하고 이따금 기억을 잃는 ‘금주’. 얼마 전 남편의 죽음도, 점점 변해가는 딸의 모습도 나 때문인 것 같아 괴롭다. 남편의 장례식장에 그의 후배라는 정신과 의사 진명 이 찾아왔다. 내 안에 또 다른 뭔가 있는 게 분명하다! 그의 도움이 필요하다! 그녀와 얽힌 끔찍한 비밀! 지금 끝내지 않으면 또 다른 누군가가 피해를 입을 수 있다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M026','코미디','미쓰 와이프','2015.08.13','misswife.jpg','2015.08.13','misswifeback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/mkoL9jiZc9c" frameborder="0" allowfullscreen></iframe>','승소율 100% 잘 나가는 싱글 변호사 ‘이연우’ 뉴욕 본사 발령을 앞두고, 연우(엄정화)는 갑작스러운 교통사고를 당한다. 생사의 위기에 놓인 연우 앞에 나타난 수상한 남자 ‘이소장’(김상호) 그는 한 달간 다른 사람의 인생을  살면 다시 원래의 삶으로 돌려 보내주겠다고 제안한다. 하지만 제안을 수락한 그녀에게 찾아온 건 지나치게 자상한 남편과 애 둘 딸린 아줌마의 전쟁 같은 일상! 연우는 청천벽력 같은 인생반전으로 패닉에 빠지고, 남편 ‘성환’(송승헌) 과 아이들은 영문도 모른 채 변해버린 아내, 엄마로 인해 당황하기 시작하는데…! 딱 한달, 완벽하게 숨겨야만 하는 그녀의 반전 라이프가 시작된다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M027','애니메이션','명탐정 코난 : 화염의 해바라기','2015.08.05','konan.jpg','2015.08.05','konanback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/_xNqGtRVark" frameborder="0" allowfullscreen></iframe>','뉴욕 최대 미술품 경매장에서 빈센트 반 고흐의 명화 ‘해바라기’가 사상 최고 액 3억 달러에 낙찰된다. 그림을 소유하게 된 보라의 할아버지, 정지로 회장의 목표는 전 세계에 흩어져 있는 고흐의 ‘해바라기’ 7작품을 모아 최초로 전시하는 것. 난공불락을 자 랑하는 레이크 록 미술관에서의 대규모 전시 계획을 발표하는 기자회견이 전 세계에 생중계되는 가운데 갑자기 괴도 키드가 출현! 고흐의 해바라기를 접수하겠다는 예고장을 날리고 바 람처럼 사라지는데… 키드는 왜 고흐의 명화를 노리는 걸까? 명탐정 코난 VS 괴도 키드, 두 천재의 불꽃 대결이 시작된다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M028','코미디','미라클 벨리에','2015.08.27','belier.jpg','2015.08.27','belierback.jpg','<iframe width="800" height="515" src="https://www.youtube.com/embed/rOJMORaCN2c" frameborder="0" allowfullscreen></iframe>','가족 중 유일하게 듣고 말할 수 있는 폴라는 파리 전학생 가브리엘에게 첫눈에  반하고, 그가 있는 합창부에 가입한다. 그런데 한 번도 소리 내어 노래한 적 없었던 폴라의 천재적 재능을 엿본 선생님은 파리에 있는 합창학교 오디션을 제안하고 가브리엘과의 듀엣  공연의 기회까지 찾아온다. 하지만 들을 수 없는 가족과 세상을 이어주는 역할로 바쁜 폴라는 자신이 갑작스럽게 떠나면 가족들에게 찾아올 혼란을 걱정한다. 게다가 늘 사랑을 줬던  엄마의 속내를 알게 되면서 폴라는 급기야 오디션을 포기하게 되는데…'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M029','액션','아메리칸 울트라','2015.08.27','americanultra.jpg','2015.08.27','americanultraback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/aJ-ZnakV8Tg" frameborder="0" allowfullscreen></iframe>','상식파괴! 개념리셋! 취향저격! 역대급 비정상 스파이의 액션 세포가 깨어난다! 여자친구 피비(크리스틴 스튜어트)에게 멋진 프로포즈를 하는 것만이 최대 목표인 편의점 알바생 마이크(제시 아이젠버그). 어느 날 찾아온 의문의 여자가 도통 알 수 없는 암호를 남 기고 간 뒤 핵/노/잼이었던 인생이 핵/반/전 됐다! 갑자기 습격해온 괴한들을 얼떨결에 숟가락만으로 제압한 것! 자신도 몰랐던 액션 본능에 놀란 것도 잠시, 마이크는 자신이 일급 기밀 프로젝트로 만들어진 최정예 스파이였고 기억이  삭제된 채 비밀요원인 피비의 보호를 받고 있었다는 엄청난 사실을 알게 된다. 봉인됐던 마이크의 액션 세포가 깨어난 것을 확인한 CIA는 그를 제거하기 위해 도시를 폐쇄해버리고 결국, 마이크는 표적이 된 피비와 자신의 목숨을 건 미션을 시작하는데... 원스푼 투킬, 프라이팬 샷건, 통조림 헤드샷, 컵라면 어택. 올 여름, 뜻밖의 액션을 즐겨라!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M030','액션','협녀, 칼의 기억','2015.08.13','memoriesofthesword.jpg','2015.08.13','memoriesoftheswordback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/R8CKWFDPrtA" frameborder="0" allowfullscreen></iframe>','칼이 지배하던 시대, 고려 말 왕을 꿈꿨던 한 남자의 배신 그리고 18년 후 그를 겨눈 두 개의 칼. 고려를 탐한 검, 유백(이병헌) 대의를 지키는 검, 월소(전도연) 복수를 꿈꾸는 검, 홍이(김고은) 뜻이 달랐던 세 개의 칼이 부딪친다.'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M031','애니메이션','무민 더 무비','2015.08.13','Moomins.jpg, 2014.jpg','2015.08.13','Moominsback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/f0VfGqgnUxY" frameborder="0" allowfullscreen></iframe>','세상에서 가장 깜찍한 트롤 무민 가족 등장! 마침내 귀여움이라는 것이 폭발했다! 귀염지수 200%, 포근한 매력의 ‘무민’ 소년 같은 순수함을 간직한 ‘무민 파파’ 따뜻한 무민 가족의 버팀목 ‘무민 마마’ 못 말리는 ‘무민’의 여친 ‘스노크메이든’ 무민 가족은 골짜기를 벗어나 남쪽 바다로 여행을 떠난다. 두근두근 콩닥콩닥 신나는 바캉스 지금부터 시작~! 그.러.나 이들을 기다리고 있는 것은 예측불허 초특급 사건?! 올 여름, 엉뚱하지만 사랑스러운 무민 가족의 바캉스 대소동이 시작된다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M032','액션','더 리치','2015.07.16','thereach.jpg','2015.07.16','thereachback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/tKTHCmgd3cc" frameborder="0" allowfullscreen></iframe>','최고 기온 54℃, 물 없이 생존확률 0% 극한의 사막 ‘더 리치’ ‘리치’로 사냥 여행을 떠난 거물급 사업가 ‘매덕’과 베테랑 가이드 ‘벤’ 작열하는 태양 아래 사냥감의 실루엣이 드러나고, 고요한 사막을 뒤흔든 한 발의 총성! 그러나 밝혀진 사냥감의 실체는 다름아닌 ‘사람’! 살인을 덮으려는 ‘매덕’, 진실을 밝히려는 ‘벤’ 목격자는 단 두 명 살아남는 자, 진실이 된다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M033','드라마','우먼 인 골드','2015.07.09','womaningold.jpg','2015.07.09','womaningoldback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/0kKJUjVLOF4" frameborder="0" allowfullscreen></iframe>','경매가 1,500억원. 세계가 사랑한 그림 ‘레이디 인 골드’에 숨겨진 비밀! 빼앗긴 과거를 되찾기 위한 한 여인의 감동 실화를 만난다! 유명 화가 ‘클림트’는 자신의 후원자였던 ‘아델레’를 모델로 그림 [아델레 블로흐-바우어의 초상]을 그려 선물한다. 하지만, 그녀가 죽고 난 뒤 남편 ‘페르낭드’는 나치에 의해  오스트리아 정부에 그림을 몰수당하고, 이 그림을 조카들에게 남긴다는 유언만을 남긴 채 생을 마감한다. 세월이 지난 1998년, 이미 노년기로 접어 든 그의 조카 ‘마리아 알트만’은 젊은 시절 추억이 남긴 그림들을 되찾기 위해 무려 8년간 국가를 상대로 외롭고도 긴 싸움을 시작하는데…'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M034','코미디','연애의 맛','2015.05.07','loveclinic.jpg','2015.05.07','loveclinicback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/v6fkDJQOKN0" frameborder="0" allowfullscreen></iframe>','대한민국에서 여자 속(?) 제일 많이 본 남자! 대한민국에서 남자 사이즈(?) 제일 많이 아는 여자! 겉으론 멀쩡한 외모와 스펙의 뇌섹남! 그러나, 여자 속만 알고 정작 여자 맘은 모르는 산부인과 전문의 왕성기(오지호). 거침없는 성격으로 여성 불모지인 금녀의 벽에 도전! 그러나, 남성의 은밀한 그 곳을 진단하면서도 연애 경험은 전무한 비뇨기과 전문의 길신설(강예원). 낮에는 성 전문가 밤에는 연애 초보자 한 지붕 아래 만난 두 닥터! 환자 쟁탈을 위한 제로섬 게임이 시작된다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M035','드라마','약장수','2015.04.23','salesman.jpg','2015.04.23','salesmanback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/WfRZGFCLRZ8" frameborder="0" allowfullscreen></iframe>','“세상 어떤 자식이 매일 엄마한테 노래 불러주고 재롱 떨어줘?” 대리운전, 일용직 등을 전전하던 일범에게 신용불량자라는 딱지는 번번이 그의 발목을 잡는 족쇄다. 아픈 딸의 치료비를 위해 어머니들에게 각종 건강식품과 생활용품을 파는 홍보관  ‘떴다방’에 취직한 일범은 자신의 처지가 한심하다. 그런 그에게 홍보관 점장 철중은 “우리가 자식보다 낫다”며 당장 처자식 먹여 살리려면 목숨 걸고 팔라 한다. 그의 말처럼 오 히려 즐거워하는 어머니들을 보며 일범 역시 보람을 느끼기 시작하고 그러던 중, 자랑스런 검사 아들을 뒀지만 자식에게 짐이 되기 싫어서 홀로 외로이 노년을 보내던 옥님이 홍보관 을 찾아와 일범을 만나게 되는데… 4월 23일, 그곳에 가면 엄마도, 아들도 울고 웃는다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M036','코미디','조선명탐정: 사라진 놉의 딸','2015.02.11','josun.jpg.jpg','2015.02.11','josunback.jpg','<iframe width="800" height="515" src="https://www.youtube.com/embed/R-1exU52JhY" frameborder="0" allowfullscreen></iframe>','우리가 또 나설 차례인가! 정조 19년. 한때는 왕의 밀명을 받던 특사였으나 무슨 이유인지 왕에게 미운 털이 박혀 외딴 섬에 유배되어 버린 조선 제일의 명탐정 김민. 찾아오는 이라곤 지난 날 함께 했던 파트너 서필과 매일 같이 동생을 찾아달라며 오는 어린 소녀뿐이다. 그러던 중 김민은 조선 전역에 불량은괴가 유통되고 있다는 소식을 접하게 되고, 이로 인해 잠자고 있던 탐정 본능이 꿈틀거리기 시작한다. 결국 유배지 이탈이라는 초강수를 두며 불량은괴 유통사건과 행방불명 된 소녀의 동생을 찾기 위해 본격 수사에 착수하게 된다. 사상 최초로 동시에 두 사건 해결에 나선 조선 명탐정 김민과 서필! 그러나 정체를 알 수 없는 미모의 여인 히사코로 인해 명콤비의 수사는 더욱 혼선을 빚는다. 과연 이들은 의문의 두 사건을 해결하고, 화려한 옛 영광을 되찾을 수 있을까? 조선 제일의 명탐정 콤비, 김민과 서필이 돌아왔다! “위기의 조선. 우리에게 한번 더 맡겨보시지요!”'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M037','드라마','국제시장','2014.12.17','kukje.jpg','2014.12.17','kukjeback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/BBEDtovULHY" frameborder="0" allowfullscreen></iframe>','가족을 위해 굳세게 살아온 그때 그 시절, 가장 평범한 아버지의 가장 위대한  이야기가 시작된다! 1950년 한국전쟁을 지나 부산으로 피란 온 ‘덕수’의 다섯 식구, 전쟁 통에 헤어진 아버지를 대신해야 했던 ‘덕수’는 고모가 운영하는 부산 국제시장의 수입 잡화점 ‘꽃분이네’ 서 일하며 가족의 생계를 꾸려 나간다. 모두가 어려웠던 그때 그 시절, 남동생의 대학교 입학 등록금을 벌기 위해 이역만리 독일에 광부로 떠난 ‘덕수’는 그곳에서 첫사랑이자 평생 의 동반자 ‘영자’를 만난다. 그는 가족의 삶의 터전이 되어버린 ‘꽃분이네’ 가게를 지키기 위해 ‘선장’ 이 되고 싶었던 오랜 꿈을 접고 다시 한 번 전쟁이 한창이던 베트남으로  건너가 기술 근로자로 일하게 되는데…'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M038','드라마','타짜-신의손','2014.09.03','tazza.jpg','2014.09.03','tazzaback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/uYhVyJYqVHY" frameborder="0" allowfullscreen></iframe>','화투판엔 영원한 친구도, 영원한 원수도 없다! 삼촌 ‘고니’를 닮아 어린 시절부터 남다른 손재주와 승부욕을 보이던 ‘대길’(최승현 분)은 고향을 떠나 서울 강남의 하우스에서 ‘타짜’로 화려하게 데뷔하지만, 한 순간에 모든  것을 잃고 우연히 ‘고니’의 파트너였던 ‘고광렬’(유해진 분)을 만난다. ‘고광렬’과 함께 전국을 유랑하던 ‘대길’은 절대 악의 사채업자 ‘장동식’(곽도원 분)은 물론, 전설 의 타짜 ‘아귀’(김윤석 분)까지 ‘타짜’들과 목숨줄이 오가는 한 판 승부를 벌이는데…'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M039','드라마','명량','2014.07.30','12vs330.jpg','2014.07.30','12vs330back.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/spQtwggaCy4" frameborder="0" allowfullscreen></iframe>','1597년 임진왜란 6년, 오랜 전쟁으로 인해 혼란이 극에 달한 조선. 무서운 속도로 한양으로 북상하는 왜군에 의해 국가존망의 위기에 처하자 누명을 쓰고 파면 당했던 이순신 장군(최민식)이 삼도수군통제사로 재임명된다. 하지만 그에게 남은 건 전의를 상실한 병사와 두려움에 가득 찬 백성, 그리고 12척의 배 뿐. 마지막 희망이었던 거북선마저 불타고 잔혹한 성격과 뛰어난 지략을 지닌 용병 구루지마(류승룡)가 왜군 수장으로 나서자 조선은 더욱 술렁인다. 330척에 달하는 왜군의 배가 속속 집결하고 압도적인 수의 열세에 모두가 패배를 직감하는 순간, 이순신 장군은 단 12척의 배를 이끌고 명량 바다를 향해 나서는데…!1 12척의 조선 vs 330척의 왜군 역사를 바꾼 위대한 전쟁이 시작된다!'); 
INSERT INTO MOVIE(MOVIE_CODE,GENRE,TITLE,VIEW_TIME,POSTER,REG_DATE,BACKGROUND,IFRAME,MOVIE_INFO)
VALUES('M040','로맨스','비긴 어게인','2014.08.13','beginagain.jpg','2014.08.13','beginagainback.jpg','<iframe width="800" height="515"  src="https://www.youtube.com/embed/9qncSFGtXWE" frameborder="0" allowfullscreen></iframe>','“다시 시작해, 너를 빛나게 할 노래를!” 싱어송라이터인 ‘그레타’(키이라 나이틀리)는 남자친구 ‘데이브’(애덤 리바인)가 메이저 음반회사와 계약을 하게 되면서 뉴욕으로 오게 된다. 그러나 행복도 잠시, 오랜 연인이자  음악적 파트너로서 함께 노래를 만들고 부르는 것이 좋았던 그레타와 달리 스타가 된 데이브의 마음은 어느새 변해버린다. 스타 음반프로듀서였지만 이제는 해고된 ‘댄’(마크 러팔로)은 미치기 일보직전 들른 뮤직바에서 그레타의 자작곡을 듣게 되고 아직 녹슬지 않은 촉을 살려 음반제작을 제안한다. 거 리 밴드를 결성한 그들은 뉴욕의 거리를 스튜디오 삼아 진짜로 부르고 싶었던 노래를 만들어가는데…'); 









-- 지점 정보입력
INSERT INTO MULTIPLEX  
VALUES( '인천' );
INSERT INTO MULTIPLEX
VALUES( '수원' );
INSERT INTO MULTIPLEX
VALUES( '서울' );





-- 상영관 정보 입력
--인천
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M001', '1관' ,TRUNC(SYSDATE),'인천' , '09:00', '12:00' ,'15:00' , '18:00', '21:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M011', '2관' ,TRUNC(SYSDATE),'인천' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M003', '3관' ,TRUNC(SYSDATE),'인천' , '07:00', '09:00' ,'12:00' , '18:00', '21:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M004', '4관' ,TRUNC(SYSDATE),'인천' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M001', '1관' ,TRUNC(SYSDATE)+1,'인천' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M002', '2관' ,TRUNC(SYSDATE)+1,'인천' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M011', '3관' ,TRUNC(SYSDATE)+1,'인천' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M003', '4관' ,TRUNC(SYSDATE)+1,'인천' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
--서울
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M001', '1관' ,TRUNC(SYSDATE),'서울' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M002', '2관' ,TRUNC(SYSDATE), '서울', '09:00' ,'12:00' , '15:00', '18:00' ,'21:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M011', '3관' ,TRUNC(SYSDATE),'서울' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M003', '4관' ,TRUNC(SYSDATE), '서울', '09:00' ,'12:00' , '15:00', '18:00' ,'21:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M004', '1관' ,TRUNC(SYSDATE)+1,'서울' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M011', '2관' ,TRUNC(SYSDATE)+1, '수원', '09:00' ,'12:00' , '15:00', '18:00' ,'21:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M003', '3관' ,TRUNC(SYSDATE)+1,'서울' , '12:00', '15:00' ,'17:00' , '19:00', '22:00' );
INSERT INTO THEATER  
VALUES( 'T' ||LPAD(TH_CODE.NEXTVAL, 3, 0 ),'M002', '4관' ,TRUNC(SYSDATE)+1, '서울', '09:00' ,'12:00' , '15:00', '18:00' ,'21:00' );




-- 책 리뷰 정보입력
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (1, 'abc117', 1001, 10);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (2, 'abc117', 1002, 5);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (3, 'abc117', 1003, 6);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (4, 'abc117', 1004, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (5, 'abc117', 1005, 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (6, 'abc117', 1006, 8);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (7, 'abc117', 1007, 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (8, 'abc117', 1008, 8);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (9, 'abc117', 1009, 7);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (10, 'abc117', 1010, 5);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (11, 'abc117', 1011, 6);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (12, 'abc117', 1012, 3);

-- 영화 리뷰 정보입력
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (13, 'abc117', 'M001', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (14, 'abc117', 'M011', 10);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (15, 'abc117', 'M003', 3);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (16, 'abc117', 'M004', 6);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (17, 'abc117', 'M002', 17);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (18, 'abc117', 'M021', 7);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (19, 'abc117', 'M022', 8);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (20, 'abc117', 'M023', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (21, 'abc117', 'M024', 5);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (22, 'abc117', 'M025', 6);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (23, 'abc117', 'M026', 7);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (24, 'abc116', 'M001', 4);


INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (25, 'abc116', 1001, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (26, 'abc116', 1004, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (27, 'abc116', 1006, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (28, 'abc116', 1008, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (29, 'abc116', 1010, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (30, 'abc116', 1012, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (31, 'abc115', 1003, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (32, 'abc115', 1004, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (33, 'abc115', 1005, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (34, 'abc115', 1006, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (35, 'abc115', 1007, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (36, 'abc115', 1009, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (37, 'abc115', 1012, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (38, 'abc114', 1001, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (39, 'abc114', 1002, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (40, 'abc114', 1003, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (41, 'abc114', 1004, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (42, 'abc114', 1005, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (43, 'abc114', 1008, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (44, 'abc114', 1009, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (45, 'abc114', 1011, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (46, 'abc113', 1001, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (47, 'abc113', 1009, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (48, 'abc113', 1010, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (49, 'abc113', 1011, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (50, 'abc112', 1001, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (51, 'abc112', 1002, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (52, 'abc112', 1004, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (53, 'abc112', 1007, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (54, 'abc112', 1008, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (55, 'abc112', 1009, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (56, 'abc112', 1011, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (57, 'abc112', 1012, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (58, 'abc111', 1001, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (59, 'abc111', 1002, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (60, 'abc111', 1003, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (61, 'abc111', 1004, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (62, 'abc111', 1005, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (63, 'abc111', 1006, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (64, 'abc111', 1007, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (65, 'abc111', 1008, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (66, 'abc111', 1009, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (67, 'abc111', 1010, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (68, 'abc111', 1011, 4);
INSERT INTO BOARD_META(BRD_NO, USER_ID, BOOK_SERIAL_NO, GPOINT)
VALUES (69, 'abc111', 1012, 4);

INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (70, 'abc115', 'M001', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (71, 'abc115', 'M011', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (72, 'abc115', 'M021', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (73, 'abc115', 'M022', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (74, 'abc115', 'M023', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (75, 'abc115', 'M026', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (76, 'abc115', 'M001', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (77, 'abc114', 'M001', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (78, 'abc114', 'M011', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (79, 'abc114', 'M003', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (80, 'abc114', 'M022', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (81, 'abc114', 'M023', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (82, 'abc114', 'M025', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (83, 'abc114', 'M001', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (84, 'abc113', 'M001', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (85, 'abc113', 'M011', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (86, 'abc113', 'M003', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (87, 'abc113', 'M004', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (88, 'abc113', 'M002', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (89, 'abc113', 'M021', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (90, 'abc113', 'M022', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (91, 'abc113', 'M023', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (92, 'abc113', 'M024', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (93, 'abc113', 'M025', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (94, 'abc113', 'M026', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (95, 'abc113', 'M001', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (96, 'abc112', 'M001', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (97, 'abc112', 'M011', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (98, 'abc112', 'M003', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (99, 'abc112', 'M004', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (100, 'abc112', 'M002', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (101, 'abc112', 'M021', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (102, 'abc112', 'M022', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (103, 'abc112', 'M023', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (104, 'abc112', 'M024', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (105, 'abc112', 'M025', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (106, 'abc112', 'M026', 9);
INSERT INTO BOARD_META(BRD_NO, USER_ID, MOVIE_CODE, GPOINT)
VALUES (107, 'abc112', 'M001', 9);

insert into th_reservation values(th_res_seq.nextval, sysdate, 'abc112', 'T009','19:00');
insert into th_reservation values(th_res_seq.nextval, sysdate, 'abc112', 'T016','09:00');



INSERT INTO BOOK_STAT_TYPE(STAT_TYPE_CODE, STAT_TYPE_NAME)
VALUES (BOOK_STAT_SEQ.NEXTVAL, '사용자의 월별 독서량');
INSERT INTO BOOK_STAT_TYPE(STAT_TYPE_CODE, STAT_TYPE_NAME)
VALUES (BOOK_STAT_SEQ.NEXTVAL, '각 도서의 평균 평점');

INSERT INTO MOVIE_STAT_TYPE(STAT_TYPE_CODE, STAT_TYPE_NAME)
VALUES (3, '사용자의 월별 영화 상영 횟수');
INSERT INTO MOVIE_STAT_TYPE(STAT_TYPE_CODE, STAT_TYPE_NAME)
VALUES (4, '각 영화의 평균 평점');

commit;

