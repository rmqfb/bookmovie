DROP SEQUENCE SEQ;
-- 시트넘버와 게시판 테마 게시판 글 시퀀스 테이블 생성
CREATE SEQUENCE SEQ
increment by 1
start with 1001
nocycle;


drop table seat;
-- 좌석번호 테이블 생성
create table seat (
    SEAT_NO number default 0 ,
    constraint SEAT_NO_pk primary key( SEAT_NO)
);
-- 1001부터  1010 번까지 자리번호
insert into seat
values(seq.nextval);
insert into seat
values(seq.nextval);
insert into seat
values(seq.nextval);
insert into seat
values(seq.nextval);
insert into seat
values(seq.nextval);
insert into seat
values(seq.nextval);
insert into seat
values(seq.nextval);
insert into seat
values(seq.nextval);
insert into seat
values(seq.nextval);
insert into seat
values(seq.nextval);

drop table BOARD_THEME;
-- 게시판 테마 테이블 생성
CREATE table BOARD_theme (
    BOARD_theme_NUM NUMBER default 0,
    BOARD_theme_NAME VARCHAR2 ( 20 ) default 'NULL' ,
    constraint BOARD_theme_PK primary key(BOARD_theme_NUM)
);
insert into BOARD_theme values(seq.nextval, '공지사항' );
insert into BOARD_theme values(seq.nextval, '자유게시판' );
-- 1011이 공지사항 1012 이 자유게시판

drop table MEMBER;
create table member (
    id       varchar2(15 ) default 'NULL' ,
    pass       varchar2 ( 15 ) default 'NULL' ,
    name     varchar2(20 ) default 'NULL' ,
    email      varchar2 ( 30 ) default 'NULL' ,
    phone_num         number       default 0 ,
    gender     number         default 0,
    birth      date           default sysdate,
    address    varchar2 ( 50 ) default 'NULL' ,      
    admin    number       default 0,
    reg_date date   default sysdate,
    constraint mem_id_pk primary key(id)
);



insert into member ( id, pass, name, email, phone_num, gender, birth , address, admin, reg_date)
values('abc110', 'abc110' , '에이씨' , 'abc110@naver.com' , 01042342412 , 0 , '1990-01-20' , '서울시', 0, sysdate);

insert into member
values('abc111', 'abc111' , '심영순' , 'abc111@naver.com' ,  01089594890 , 1 , '1980-02-02' , '서울시', 0, sysdate );

insert into member
values('abc112', 'abc112' , '김길동' , 'abc112@naver.com' ,  01034535434 , 0 , '1960-05-05' , '인천시' , 0, sysdate );

insert into member
values('abc113', 'abc113' , '박길동' , 'abc113@naver.com' , 01045234235 , 0 , '1990-01-20' , '대구시' , 0, sysdate );

insert into member
values('abc114', 'abc114' , '뭐길동' , 'abc114@naver.com' , 01078664584 , 1 , '1990-01-20' , '경기시' , 0, sysdate );

insert into member
values('abc115', 'abc115' , '김탱구' , 'abc115@naver.com' , 01042342410 , 0 ,'1970-01-20' ,'인천시', 0, sysdate );

insert into member
values('abc116', 'abc116' , '장동건' , 'abc116@naver.com'  ,01042342412 , 0 ,'1980-01-20' ,'대구시', 0, sysdate );

insert into member
values('abc117', 'abc117' , '김태희' , 'abc117@naver.com'  ,01042342412 , 1 ,'1990-01-20' ,'부산시', 0, sysdate );

insert into member
values('abc118', 'abc118' , '원빈' , 'abc118@naver.com'  , 01042342412 , 0 , '1990-01-20' , '서울시' , 0, sysdate );

insert into member
values('abc119', 'abc119' , '홍길동' , 'abc119@naver.com'  ,01045342412 , 0 ,'1990-01-20' ,'인천시', 0, sysdate );

insert into member
values('abc120', 'abc120' , '송혜교' , 'abc120@naver.com'  ,01012442412 , 1 ,'1990-01-20' ,'서울시', 0, sysdate );

insert into member
values('admin', 'admin' , '관리자' , 'admin@naver.com'  ,01015151515 , 1 ,'1990-01-20' ,'서울시', 1, sysdate );

-- 블린 표시 0이 운영자 아님, 남성 표시입니니다.
 
DROP SEQUENCE SEQ_ARTICLE;
create sequence seq_article;

drop table ARTICLE;
create table ARTICLE (
    SEQ_ARTICLE NUMBER default 0,
    ID VARCHAR2( 15 ) default 'NULL',
    TITLE VARCHAR2 ( 200 ) default 'NULL',
    COMMENTS VARCHAR2( 500 ) default 'NULL',
    CONTENT VARCHAR2( 2000 ) default 'NULL',
    POSTING_DATE DATE default sysdate,
    CATEGORY VARCHAR2(20 ) default 'NULL',
    READ_COUNT NUMBER default 0,
    FILE_SRC VARCHAR2 ( 200 ) default 'NULL',
    BOARD_theme_NUM NUMBER default 1011,
    constraint ARTICLE_PK_SEQ primary key( SEQ_ARTICLE),
    constraint ARTICLE_FK_BOARD foreign key( BOARD_theme_NUM) references BOARD_theme ( BOARD_theme_NUM ) on delete cascade,
    constraint ARTICLE_FK_ID foreign key( ID) references MEMBER (ID) on delete cascade
);


insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc111' , '청산별곡' , '살어리 살어리랏다. / 청산(靑山)애 살어리랏다.' , '2015-06-26' , '고전문학' , '10' , 'C:\Users\공지사항\고전문학' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc112' , '사미인곡' , '엊그제 님을 뫼셔 廣寒殿(광한전)의 올낫더니 / 그 더ㄷㆎ 엇디ㅎㆍ야 下界(하계)에 ㄴㆍ려오니' , '2015-06-26', '고전문학' , '13', 'C:\Users\공지사항\고전문학' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc113' , '동백꽃' , '나는 눈물을 우선 씻고 뭘 안 그러는지 명색도 모르건만' , '2015-06-26' , '현대문학' , '5' , 'C:\Users\공지사항\현대문학' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc113' , '중2병의 뜻' , '중학교 2학년 나이 또래의 청소년들이 사춘기 자아 형성 과정에서 겪는 혼란이나 불만과 같은 심리적 상태, 또는 그로 말미암은 반항과 일탈 행위를 일컫는다.' , '2015-06-26' , '상식', '10' , 'C:\Users\자유게시판\상식' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc114' , '사미인곡' , '중학교 2학년 나이 또래의 청소년들이 사춘기 자아 형성 과정에서 겪는 혼란이나 불만과 같은 심리적 상태, 또는 그로 말미암은 반항과 일탈 행위를 일컫는다.' , '2015-06-26' , '상식', '15' , 'C:\Users\자유게시판\상식' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc115' , '훈민정음해례본' , '나랏말싸미 듕귁에 달아 / 문자와로 서르 사맛디 아니할쎄' , '2015-06-26' , '상식' , '20' , 'C:\Users\자유게시판\상식' ,1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc116' , '오감도(烏瞰圖)' , '13인의아해(兒孩)가도로로질주하오. / (길은막다른골목이적당하오)' , '2015-06-26' ,      '현대시' , '13' , 'C:\Users\공지사항\현대시' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc116' , '빈집' , '장님처럼 나 이제 더듬거리며 문을 잠그네 / 가엾은 내 사랑 빈집에 갇혔네', '2015-06-26', '현대시' , '25' , 'C:\Users\공지사항\현대시' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc117' , '그리스 협상 막판 충돌...디폴트 우려 고조', '유럽은 물론 세계가 주목하고 있는 그리스 구제금융 협상이 부채 상환 시한을 이틀 앞두고 파국을 맞았습니다.', '2015-06-27', '시사' , '30' , 'C:\Users\자유게시판\시사' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc118' , '모란이 피기까지는 ' , '모란이 피기까지는, 나는 아직 나의 봄을 기다리고 있을 테요.' , '2015-06-27' , '현대시' , '25' , 'C:\Users\공지사항\현대시' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc119' , '유승민 사퇴 압박…축출이냐 사수냐, 친박-비박 29일부터 정면충돌 ' , '유승민 원내대표의 사퇴와 사수를 놓고 친박(친 박근혜)과 비박간의 정면 충돌이 임박했다. ' , '2015-06-28' , '시사' , '25' , 'C:\Users\자유게시판\시사' , 1011 );

insert into ARTICLE ( SEQ_ARTICLE , ID, TITLE , CONTENT, POSTING_DATE, CATEGORY, READ_COUNT, FILE_SRC , BOARD_theme_NUM )
values(SEQ_ARTICLE.nextval, 'abc120' , '시문학파' , '시전문지 《시문학(詩文學)》을 중심으로 순수시 운동을 주도하였던 시인들.', '2015-06-28', '상식' , '25', 'C:\Users\자유게시판\상식' , 1011 );



drop table RESERVATION;
create table reservation (
    RES_NO number (10) default 0 ,
    SEAT_NO number (10) default 0 ,
    ID VARCHAR2( 15 ) default 'NULL' ,
    r_date date default sysdate,
    constraint RES_NO_pk primary key( RES_NO),
    constraint SEAT_NO_fk foreign key( SEAT_NO)
    references SEAT( SEAT_NO ) on delete cascade,
    constraint ID_fk foreign key(ID)
    references MEMBER(ID) on delete cascade
);

insert into reservation values(seq.nextval, 1001, 'abc111', sysdate);
insert into reservation values(seq.nextval, 1002, 'abc111', sysdate);
insert into reservation values(seq.nextval, 1003, 'abc111', sysdate);
insert into reservation values(seq.nextval, 1004, 'abc111', sysdate);
insert into reservation values(seq.nextval, 1005, 'abc111', sysdate);
insert into reservation values(seq.nextval, 1006, 'abc111', sysdate);
insert into reservation values(seq.nextval, 1007, 'abc111', sysdate);
insert into reservation values(seq.nextval, 1008, 'abc111', sysdate);
insert into reservation values(seq.nextval, 1009, 'abc111', sysdate);
insert into reservation values(seq.nextval, 1010, 'abc111', sysdate);


drop table BOOK_CAT;
create table BOOK_CAT (
    book_cat_big        varchar2 ( 45 ) default 'NULL' ,
    book_cat_medium        varchar2 ( 45 ) default 'NULL' ,
    book_cat_small        varchar2 ( 45 ) default 'NULL' ,
    constraint book_cat_pk primary key ( book_cat_small)
);
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


-- 시트넘버와 게시판 테마 게시판 글 시퀀스 테이블 생성
CREATE SEQUENCE book_SEQ
increment by 1
start with 1001
nocycle;

drop table BOOK;
create table BOOK (
	book_serial_no     number default 0 ,
    book_title         varchar2( 100) default 'NULL' ,
    author             varchar2( 100) default 'NULL' ,
    img_addr           varchar2( 255) default 'NULL' ,
    press_day          date,
    publisher         varchar2( 30) default 'NULL' ,
    book_category 	varchar2( 100) default 'NULL' ,
    detail			   varchar2(2000) default 'NULL',
    constraint book_serial_no_pk primary key( book_serial_no),
    constraint book_category_fk foreign key( book_category)
        references BOOK_CAT ( book_cat_small ) on delete cascade
);
-- 1001 부터 시작
insert into book values(book_seq.nextval, '글자전쟁', '김진명', 'war.jpg', to_date('2015-08-01','yyyy-mm-dd'), '새움', '한국소설','5천 년간 잠들어 있던 거대한 진실 게임이 시작된다!소설이라는 장치를 넘어 근본적인 질문을 던지는 김진명의 대작 『글자전쟁』.<br/> 천년 제국 고구려를 되살린 대하소설 《고구려》와 미국과 중국이라는 거대한 충돌의 그림자에 드리운 한반도의 운명을 그린 《싸드》에 이어 ‘한자(漢字)’ 속에 숨겨진 우리의 역사와 치열한 정치적 메커니즘을 가지고 돌아왔다.<br/> 스탠퍼드 출신의 명망 있는 국제무기중개상 이태민은 명예보다는 오로지 500억의 커미션을 챙겨 안락한 인생을 살고픈 욕망으로 가득 찬 남자다.<br/> 무기제조업체 ‘록히드마틴’에 입사한 지 2년도 안 되어 헤비급 사원이 된 그는 특유의 비상한 머리와 국제정세를 꿰뚫는 날카로운 식견으로 나날이 탄탄대로를 걷는다.<br/>하지만 무기중개 과정에서 뜻하지 않은 법의 그물에 갇히게 되고, 궁지에 몰린 그는 검찰 출석 하루 전날 중국으로 도피한다.<br/> 그곳에서 비밀에 싸인 남자 ‘킬리만자로’에게 USB 하나를 받게 된 태민은 머지않아 그날 밤 ‘킬리만자로’가 살해당한 사실을 알게 된다.<br/> 의문의 죽음 앞에 남겨진 USB. ‘중국의 치명적 약점’이라던 킬리만자로의 말을 떠올리며 태민은 정체불명의 파일을 열게 되고, 역사에 숨겨진 거대한 비밀과 마주하게 되는데…….<br/>[인터넷 교보문고 제공]');
insert into book values(book_seq.nextval, '가짜 팔로 하는 포옹', '김중혁', 'arm.jpg', to_date('2015-07-27','yyyy-mm-dd'), '문학동네', '한국소설','가짜 팔로 뒤지게 안아주는 내용');
insert into book values(book_seq.nextval, '거짓말', '한은형', 'lie.jpg', to_date('2015-07-10','yyyy-mm-dd'), '한겨레출판사', '한국소설','존나 뻥치는 내용');
insert into book values(book_seq.nextval, '싸나희 순정', '류근', 'ssanahee.jpg', to_date('2015-07-05','yyyy-mm-dd'), '문학세계사', '한국소설','사나이로 태어나서 할일도 많다만~~ 너와 난 나라 지키는 영광에 살았다~~ 뚠뚠~');
insert into book values(book_seq.nextval, '뱀파이어의 키스 2/완결', '신지은', 'vam.jpg', to_date('2015-06-17','yyyy-mm-dd'), '테라스북', '한국소설','아 ~ 몰라 끝나쪙~');
insert into book values(book_seq.nextval, '선의 법칙', '편혜영', 'seon.jpg', to_date('2015-06-15','yyyy-mm-dd'), '문학동네', '한국소설','착한일 하고 살아야지요~~');
insert into book values(book_seq.nextval, '트렁크', '김려령', 'trunc.jpg', to_date('2015-05-29','yyyy-mm-dd'), '창비', '한국소설','트렁크 빤쓰 입고 돌아다니는 내용인가?? 아몰랑~');
insert into book values(book_seq.nextval, '발원1', '김선우', 'balwon1.jpg', to_date('2015-05-25','yyyy-mm-dd'), '민음사', '한국소설','발원하는 내용 1권');
insert into book values(book_seq.nextval, '발원2', '김선우', 'balwon2.jpg', to_date('2015-05-25','yyyy-mm-dd'), '믿음사', '한국소설','발원하는 내용 2권');
insert into book values(book_seq.nextval, '정령왕 엘퀴네스 7', '장현도', 'elque.jpg', to_date('2015-05-20','yyyy-mm-dd'), '드림북스', '한국소설','내가 바로 정령왕이다~~');


commit;



create table BOOK_RENT (
    reg_date          date default sysdate,
    state           varchar2(2char) default 'NULL',
    book_serial_no     number default 0 ,
    id              varchar2(15) default 'NULL' ,
    constraint book_serial_no_fk foreign key( book_serial_no)
        references BOOK ( book_serial_no ) on delete cascade,
    constraint rent_id_fk foreign key(id)
        references MEMBER (id) on delete cascade
);


insert into book_rent values(to_date('2015-08-04', 'yyyy-mm-dd'), '대여', 1003, 'abc111');
insert into book_rent values(to_date('2015-08-07', 'yyyy-mm-dd'), '반납', 1003, 'abc111');
insert into book_rent values(to_date('2015-08-09', 'yyyy-mm-dd'), '대여', 1003, 'abc110');
insert into book_rent values(to_date('2015-08-10', 'yyyy-mm-dd'), '반납', 1003, 'abc110');
insert into book_rent values(to_date('2015-08-11', 'yyyy-mm-dd'), '대여', 1003, 'abc111');
insert into book_rent values(to_date('2015-08-14', 'yyyy-mm-dd'), '빈닙', 1003, 'abc111');
insert into book_rent values(to_date('2015-08-17', 'yyyy-mm-dd'), '대여', 1003, 'abc111');
insert into book_rent values(to_date('2015-08-18', 'yyyy-mm-dd'), '반납', 1003, 'abc111');
insert into book_rent values(to_date('2015-08-20', 'yyyy-mm-dd'), '대여', 1003, 'abc110');
insert into book_rent values(to_date('2015-08-27', 'yyyy-mm-dd'), '반납', 1003, 'abc110');
insert into book_rent values(to_date('2015-08-30', 'yyyy-mm-dd'), '대여', 1003, 'abc111');
insert into book_rent values(to_date('2015-09-01', 'yyyy-mm-dd'), '반납', 1003, 'abc111');
insert into book_rent values(to_date('2015-09-02', 'yyyy-mm-dd'), '대여', 1003, 'abc110');
insert into book_rent values(to_date('2015-09-04', 'yyyy-mm-dd'), '반납', 1003, 'abc110');

insert into book_rent values(to_date('2015-08-04', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-08-05', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-08-06', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-08-07', 'yyyy-mm-dd'), '대여', 1002, 'abc110');
insert into book_rent values(to_date('2015-08-08', 'yyyy-mm-dd'), '반납', 1002, 'abc110');
insert into book_rent values(to_date('2015-08-10', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-08-14', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-08-15', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-08-20', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-08-21', 'yyyy-mm-dd'), '대여', 1002, 'abc110');
insert into book_rent values(to_date('2015-08-30', 'yyyy-mm-dd'), '반납', 1002, 'abc110');
insert into book_rent values(to_date('2015-09-01', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-02', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-03', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-04', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-06', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-07', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-08', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-10', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-12', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-13', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-16', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-17', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-20', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-24', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-25', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-26', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-27', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-28', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-30', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
    

insert into book_rent values(to_date('2015-08-03', 'yyyy-mm-dd'), '대여', 1009, 'abc110');
insert into book_rent values(to_date('2015-08-06', 'yyyy-mm-dd'), '반납', 1009, 'abc110');
insert into book_rent values(to_date('2015-08-07', 'yyyy-mm-dd'), '대여', 1009, 'abc111');
insert into book_rent values(to_date('2015-08-10', 'yyyy-mm-dd'), '반납', 1009, 'abc111');
insert into book_rent values(to_date('2015-08-14', 'yyyy-mm-dd'), '대여', 1009, 'abc111');
insert into book_rent values(to_date('2015-08-19', 'yyyy-mm-dd'), '반납', 1009, 'abc111');
insert into book_rent values(to_date('2015-08-22', 'yyyy-mm-dd'), '대여', 1009, 'abc110');
insert into book_rent values(to_date('2015-08-29', 'yyyy-mm-dd'), '반납', 1009, 'abc110');
insert into book_rent values(to_date('2015-08-30', 'yyyy-mm-dd'), '대여', 1009, 'abc111');
insert into book_rent values(to_date('2015-08-31', 'yyyy-mm-dd'), '반납', 1009, 'abc111');
insert into book_rent values(to_date('2015-09-04', 'yyyy-mm-dd'), '대여', 1009, 'abc110');
insert into book_rent values(to_date('2015-09-07', 'yyyy-mm-dd'), '반납', 1009, 'abc110');
insert into book_rent values(to_date('2015-09-15', 'yyyy-mm-dd'), '대여', 1009, 'abc111');
insert into book_rent values(to_date('2015-09-17', 'yyyy-mm-dd'), '반납', 1009, 'abc111');
insert into book_rent values(to_date('2015-09-20', 'yyyy-mm-dd'), '대여', 1009, 'abc110');
insert into book_rent values(to_date('2015-09-21', 'yyyy-mm-dd'), '반납', 1009, 'abc110');

insert into book_rent values(to_date('2015-08-01', 'yyyy-mm-dd'), '대여', 1006, 'abc111');
insert into book_rent values(to_date('2015-08-05', 'yyyy-mm-dd'), '반납', 1006, 'abc111');
insert into book_rent values(to_date('2015-09-03', 'yyyy-mm-dd'), '대여', 1006, 'abc111');
insert into book_rent values(to_date('2015-09-07', 'yyyy-mm-dd'), '반납', 1006, 'abc111');

insert into book_rent values(to_date('2015-08-01', 'yyyy-mm-dd'), '대여', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-02', 'yyyy-mm-dd'), '반납', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-03', 'yyyy-mm-dd'), '대여', 1007, 'abc110');
insert into book_rent values(to_date('2015-08-04', 'yyyy-mm-dd'), '반납', 1007, 'abc110');
insert into book_rent values(to_date('2015-08-06', 'yyyy-mm-dd'), '대여', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-08', 'yyyy-mm-dd'), '반납', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-10', 'yyyy-mm-dd'), '대여', 1007, 'abc110');
insert into book_rent values(to_date('2015-08-12', 'yyyy-mm-dd'), '반납', 1007, 'abc110');
insert into book_rent values(to_date('2015-08-13', 'yyyy-mm-dd'), '대여', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-16', 'yyyy-mm-dd'), '반납', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-20', 'yyyy-mm-dd'), '대여', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-21', 'yyyy-mm-dd'), '반납', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-23', 'yyyy-mm-dd'), '대여', 1007, 'abc110');
insert into book_rent values(to_date('2015-08-24', 'yyyy-mm-dd'), '반납', 1007, 'abc110');
insert into book_rent values(to_date('2015-08-25', 'yyyy-mm-dd'), '대여', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-26', 'yyyy-mm-dd'), '반납', 1007, 'abc111');
insert into book_rent values(to_date('2015-08-30', 'yyyy-mm-dd'), '대여', 1007, 'abc110');
insert into book_rent values(to_date('2015-09-01', 'yyyy-mm-dd'), '반납', 1007, 'abc110');

    
insert into book_rent values(to_date('2015-08-04', 'yyyy-mm-dd'), '대여', 1001, 'abc111');
insert into book_rent values(to_date('2015-08-20', 'yyyy-mm-dd'), '반납', 1001, 'abc111');
insert into book_rent values(to_date('2015-08-23', 'yyyy-mm-dd'), '대여', 1001, 'abc110');
insert into book_rent values(to_date('2015-08-25', 'yyyy-mm-dd'), '반납', 1001, 'abc110');
insert into book_rent values(to_date('2015-09-02', 'yyyy-mm-dd'), '대여', 1001, 'abc111');
insert into book_rent values(to_date('2015-09-04', 'yyyy-mm-dd'), '반납', 1001, 'abc111');
insert into book_rent values(to_date('2015-09-06', 'yyyy-mm-dd'), '대여', 1001, 'abc110');
insert into book_rent values(to_date('2015-09-10', 'yyyy-mm-dd'), '반납', 1001, 'abc110');
insert into book_rent values(to_date('2015-09-14', 'yyyy-mm-dd'), '대여', 1001, 'abc111');
insert into book_rent values(to_date('2015-09-18', 'yyyy-mm-dd'), '반납', 1001, 'abc111');

insert into book_rent values(to_date('2015-08-26', 'yyyy-mm-dd'), '대여', 1008, 'abc111');
insert into book_rent values(to_date('2015-08-27', 'yyyy-mm-dd'), '반납', 1008, 'abc111');
insert into book_rent values(to_date('2015-09-3', 'yyyy-mm-dd'), '대여', 1008, 'abc110');
insert into book_rent values(to_date('2015-09-6', 'yyyy-mm-dd'), '반납', 1008, 'abc110');
insert into book_rent values(to_date('2015-09-10', 'yyyy-mm-dd'), '대여', 1008, 'abc110');
insert into book_rent values(to_date('2015-09-13', 'yyyy-mm-dd'), '반납', 1008, 'abc110');
insert into book_rent values(to_date('2015-09-17', 'yyyy-mm-dd'), '대여', 1008, 'abc111');
insert into book_rent values(to_date('2015-09-22', 'yyyy-mm-dd'), '반납', 1008, 'abc111');
insert into book_rent values(to_date('2015-09-26', 'yyyy-mm-dd'), '대여', 1008, 'abc110');
insert into book_rent values(to_date('2015-09-30', 'yyyy-mm-dd'), '반납', 1008, 'abc110');

insert into book_rent values(to_date('2015-08-06', 'yyyy-mm-dd'), '대여', 1005, 'abc111');
insert into book_rent values(to_date('2015-08-11', 'yyyy-mm-dd'), '반납', 1005, 'abc111');
insert into book_rent values(to_date('2015-08-17', 'yyyy-mm-dd'), '대여', 1005, 'abc111');
insert into book_rent values(to_date('2015-08-23', 'yyyy-mm-dd'), '대여', 1005, 'abc111');
insert into book_rent values(to_date('2015-08-29', 'yyyy-mm-dd'), '반납', 1005, 'abc111');
insert into book_rent values(to_date('2015-09-01', 'yyyy-mm-dd'), '대여', 1005, 'abc111');
insert into book_rent values(to_date('2015-09-02', 'yyyy-mm-dd'), '반납', 1005, 'abc111');
insert into book_rent values(to_date('2015-09-03', 'yyyy-mm-dd'), '대여', 1005, 'abc111');
insert into book_rent values(to_date('2015-09-06', 'yyyy-mm-dd'), '반납', 1005, 'abc111');
insert into book_rent values(to_date('2015-09-07', 'yyyy-mm-dd'), '대여', 1005, 'abc110');
insert into book_rent values(to_date('2015-09-08', 'yyyy-mm-dd'), '반납', 1005, 'abc110');
insert into book_rent values(to_date('2015-09-11', 'yyyy-mm-dd'), '대여', 1005, 'abc111');
insert into book_rent values(to_date('2015-09-12', 'yyyy-mm-dd'), '반납', 1005, 'abc111');
insert into book_rent values(to_date('2015-09-13', 'yyyy-mm-dd'), '대여', 1005, 'abc110');
insert into book_rent values(to_date('2015-09-15', 'yyyy-mm-dd'), '반납', 1005, 'abc110');
insert into book_rent values(to_date('2015-09-16', 'yyyy-mm-dd'), '대여', 1005, 'abc111');
insert into book_rent values(to_date('2015-09-18', 'yyyy-mm-dd'), '반납', 1005, 'abc110');
insert into book_rent values(to_date('2015-09-19', 'yyyy-mm-dd'), '대여', 1005, 'abc110');

insert into book_rent values(to_date('2015-08-06', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-16', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-21', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-24', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-26', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-27', 'yyyy-mm-dd'), '반납', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-28', 'yyyy-mm-dd'), '대여', 1002, 'abc111');
insert into book_rent values(to_date('2015-09-30', 'yyyy-mm-dd'), '반납', 1002, 'abc111');

insert into book_rent values(to_date('2015-09-01', 'yyyy-mm-dd'), '대여', 1004, 'abc111');
insert into book_rent values(to_date('2015-09-02', 'yyyy-mm-dd'), '반납', 1004, 'abc111');
insert into book_rent values(to_date('2015-09-03', 'yyyy-mm-dd'), '대여', 1004, 'abc111');
insert into book_rent values(to_date('2015-09-04', 'yyyy-mm-dd'), '반납', 1004, 'abc111');



create sequence seq_stat
    start with 1
    increment by 1;



create table rent_stat (
    stat_no number constraint stat_no_pk primary key,
    reg_date date default sysdate
);

create table rent_stat_by_age (
    stat_no number constraint
    stat_no_fk references rent_stat ( stat_no ),
    age_grp varchar2 (10 ) default 'NULL' ,
    rank number default 0,
    rent_cnt number default 0,
    book_serial_no number
    constraint rent_by_age_book_serial_no_fk
    references book( book_serial_no )
);

create table rent_stat_by_cat (
    stat_no number
    constraint rent_stat_no_fk references rent_stat ( stat_no ),
    rank number default 0,
    rent_cnt number default 0,
    book_serial_no number
    constraint rent_by_cat_serial_no_fk references book ( book_serial_no ),
    cat_all varchar2( 3 ) default 'NO'
);



commit;

------------------------------------------------------------------------------------------------------------------------------
-- 아래 PL/SQL 부분은 지울 예정입니다. 그러나 아직 삭제하진 마십시오.






--
--
--create or replace procedure gather_rent_stat_by_cat ( stat_date in date, p_book_group_code in book_group.book_group_code %type, cat_all in boolean default false)
--as
--    seq number := seq_stat.nextval ;
--    statRecord number := 0;
--    fetched boolean := false;
--begin
--    insert into rent_stat( stat_no, reg_date ) values ( seq, stat_date );
--    if cat_all = true then
--        for i in (
--            select
--                a.rnk,
--                a.book_serial_no,
--                a.rent_cnt
--            from
--                (
--                select
--                    rownum rnk,
--                    a.book_serial_no ,
--                    a.rent_cnt
--                from
--                    (
--                      select
--                            book_serial_no ,
--                            count(*) rent_cnt
--                        from
--                            rent
--                        where
--                            state = 1
--                            and trunc( proc_date, 'MM') = trunc(sysdate, 'MM')
--                        group by
--                            book_serial_no
--                        order by
--                            2 desc
--                    )a
--                )a
--            where
--                rownum <= 25
--        ) loop
--            fetched := true;
--            insert into rent_stat_by_cat ( stat_no , rank, rent_cnt , book_serial_no, cat_all)
--                values ( seq, i.rnk, i.rent_cnt , i.book_serial_no , 'YES');
--        end loop;
--    else
--        for i in (
--           select
--                a.rnk,
--                a.book_serial_no,
--                a.rent_cnt
--            from
--                (
--                    select
--                       rownum rnk,
--                       a.book_serial_no ,
--                       a.rent_cnt
--                    from
--                       (
--                           select
--                               rent.book_serial_no,
--                               count(*) rent_cnt
--                           from
--                               rent
--                               join book on book.book_serial_no = rent.book_serial_no
--                               join book_group book_grp on book_grp.book_group_code = book.book_group_code
--                           where
--                               rent.state = 1
--                               and trunc( rent.proc_date , 'MM') = trunc(stat_date, 'MM' )
--                               and book_grp.book_group_code = p_book_group_code
--                           group by
--                               rent.book_serial_no, book.book_title
--                           order by
--                               2 desc
--                       )a
--               )a
--            where
--                a.rnk <= 25
--        ) loop
--            fetched := true;
--            insert into rent_stat_by_cat ( stat_no , rank, rent_cnt , book_serial_no, cat_all)
--                values ( seq, i.rnk, i.rent_cnt , i.book_serial_no , 'NO');
--        end loop;
--    end if;
--    if fetched <> true then
--        rollback;
--    else
--        commit;
--    end if;
--end;
--/
--
--
--create or replace procedure gather_rent_stat_by_age_group ( stat_date in date, age_grp in rent_stat_by_age.age_grp%type)
--as
--    seq number := seq_stat.nextval ;
--    fetched boolean := false;
--begin 
--    insert into rent_stat( stat_no, reg_date ) values ( seq, stat_date );
--    if age_grp = 'ALL' then
--        for i in (
--            select
--                a.rnk,
--                a.book_serial_no,
--                a.rent_cnt
--            from
--                (
--                    select
--                        rownum rnk,
--                        a.book_serial_no ,
--                        a.rent_cnt
--                    from
--                        (
--                            select
--                                rent.book_serial_no,
--                                count(*) rent_cnt
--                            from
--                                rent
--                                join member mem on rent.id = mem.id
--                            where
--                                rent.state = 1
--                                and trunc( rent.proc_date , 'MM') = trunc(stat_date, 'MM' )
--                            group by
--                                rent.book_serial_no
--                            order by
--                                2 desc
--                        )a
--                )a
--            where
--                a.rnk <= 10
--        ) loop
--            fetched := true;
--            insert into rent_stat_by_age ( stat_no , age_grp , rank, rent_cnt, book_serial_no)
--                values(seq, age_grp, i.rnk, i.rent_cnt , i.book_serial_no);
--        end loop;
--    else
--        for i in (
--            select
--                a.rnk,
--                a.book_serial_no,
--                a.rent_cnt
--            from
--                (
--                    select
--                        rownum rnk,
--                        a.book_serial_no ,
--                        a.rent_cnt
--                    from
--                        (
--                            select
--                                rent.book_serial_no,
--                                count(*) rent_cnt
--                            from
--                                rent
--                                join member mem on rent.id = mem.id
--                                join book on book.book_serial_no = rent.book_serial_no
--                            where
--                                rent.state = 1
--                                and trunc( rent.proc_date , 'MM') = trunc(stat_date, 'MM' )
--                                and trunc( ( to_number(to_char(sysdate, 'yyyy' )) - to_number(to_char( birth, 'yyyy')) ), -1 ) = to_number( age_grp)
--                            group by
--                                rent.book_serial_no, book.book_title
--                            order by
--                                2 desc, book.book_title asc
--                        )a
--                ) a
--            where
--                a.rnk <= 10                
--        ) loop
--            fetched := true;
--            insert into rent_stat_by_age ( stat_no , age_grp , rank, rent_cnt, book_serial_no)
--                values(seq, age_grp, i.rnk, i.rent_cnt , i.book_serial_no);
--        end loop;
--    end if;
--    if fetched <> true then
--        rollback;
--    else
--        commit;
--    end if;
--end;
--/
--
--create or replace procedure gather_rent_stats
--as
--    l_stat_date date := sysdate;
--    l_age_grp rent_stat_by_age.age_grp%type;
--begin
--    for i in (
--        select book_group_code from book_group
--    ) loop
--        gather_rent_stat_by_cat(
--            stat_date => l_stat_date,
--            p_book_group_code => i.book_group_code,
--            cat_all => false);
--    end loop;
--    gather_rent_stat_by_cat(
--        stat_date => l_stat_date,
--        p_book_group_code => null,
--        cat_all => true);
--    for i in 1..6 loop
--        l_age_grp := to_char(i * 10 );
--        gather_rent_stat_by_age_group(
--            stat_date => l_stat_date,
--            age_grp => l_age_grp);
--    end loop;
--    gather_rent_stat_by_age_group(
--            stat_date => l_stat_date,
--            age_grp => 'ALL' );
--end;
--/
--
--
--begin
--    dbms_scheduler.drop_job(
--        job_name => 'COLLECT_BOOK_RENT_STAT' ,
--        force => true
--    );
--    exception
--        when others then
--            null;
--end;
--/
--
--begin
--    dbms_scheduler.create_job(
--        job_name => 'COLLECT_BOOK_RENT_STAT' ,
--        job_type => 'STORED_PROCEDURE' ,
--        job_action => 'BOOK.GATHER_RENT_STATS' ,
--        start_date => sysdate,
--        repeat_interval => 'FREQ=MONTHLY; INTERVAL=1' ,
--        enabled => true,
--        auto_drop => false,
--        comments => '도서 대여 순위 구하기'
--    );
--end;
--/
--
