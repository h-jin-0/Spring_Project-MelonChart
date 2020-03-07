# 스프링 부트 멜론사이트 만들기

## 1. 개발 환경
* Springboot
* MyBatis
* MySQL
* JSP
* Spring Security
* Lombok
* Jsoup
* Youtube API


## 2. 요구사항(기능)
* 회원가입
* 로그인
* 회원수정-비밀번호 변경, 사용자 프로파일(사진) 업로드
* 멜론 차트 음악(제목,가수,앨범,앨범사진,가사) 크롤링
* 차트 음악에 맞는 youtube 크롤링
* 음악 좋아요 버튼
* 음악 상세보기
* 뮤직비디오 상세보기
* 각 상세보기의 댓글 등록, 삭제
* 댓글 추천,반대
* 음악 재생(youtube 크롤링 연결후 재생)
* 음악 재생목록 추가
* 음악 검색

## 3. 테이블
```sql
create user 'spring'@'%' identified by 'bitc5600';
GRANT ALL PRIVILEGES ON *.* TO 'spring'@'%';
create database spring;
use spring;
```

```sql
CREATE TABLE music(
	id int AUTO_INCREMENT PRIMARY KEY,
	title varchar(100) not null,
	singer varchar(100) not null,
	album varchar(100) not null,
    albumDate date not null,
    photo varchar(1000),
	genre varchar(100) not null,
    lyrics varchar(5000),
	songNo int,
    videoLink varchar(2000),
    viewCount int default 0
)ENGINE=InnoDB CHARSET=utf8;
```

```sql
CREATE TABLE likes(
	id int auto_increment primary key,
    userId int,
    musicId int,
	foreign key (musicId) references music(id) on delete set null,
	foreign key (userId) references user(id) on delete set null
) engine=InnoDB default charset=utf8;
```

```sql
CREATE TABLE user(
	id int auto_increment primary key,
    username varchar(100) unique not null,
    name varchar(100) not null,
    password varchar(100) not null,
    email varchar(100),
    profile varchar(200)
) engine=InnoDB default charset=utf8;
```

```sql
CREATE TABLE comment(
	id int AUTO_INCREMENT PRIMARY KEY,
	username int,
	userId  int,
    content varchar(100) not null,
    Recommend int DEFAULT 0,
    opposite int DEFAULT 0,
    type varchar(50),
    foreign key (userId) references user(id) on delete set null
)ENGINE=InnoDB CHARSET=utf8;
```

