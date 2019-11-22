--book db
CREATE TABLE book(
	highLv varchar2(20) not null,
	lowLv varchar2(50) not null,
	book_num number not null,
	title varchar2(100) not null,
	author varchar2(20) not null,
	price number(9) not null,
	audioLink varchar2(200),
	imgFilename varchar2(200) not null,
	contentFilename varchar2(200) not null, --오디오북만 있을 경우 '0'으로 하면 됨.
	seriesCode varchar2(15),
	introduction clob not null, --책 소개 글
	pubDate Date not null, --출간일
	regDate Date not null, --등록일
	constraint book_num_pk primary key (book_num)
);

CREATE sequence book_seq; -- book id 용임.

--member db 
CREATE TABLE member1 (
	memberId varchar2(12) not null,
	pw varchar2(12) not null,
	lv number(1) not null,
	constraint member1_id_pk primary key (memberId)
);
--member 상세 정보 db
CREATE TABLE member2 (
	memberId varchar2(12) not null,
	name varchar2(12) not null,
	sex varchar2(6) not null,
	email varchar2(40) not null,
	phone varchar2(13) not null,
	mtype varchar2(30) default '0' not null, --심리테스트 불참시 '0'
	regDate Date not null,
	constraint member2_id_fk foreign key (memberId) references member1 (memberId)
);

--댓글 db
CREATE TABLE book_reply (
	re_num number not null,
	re_content varchar2(900) not null,
	re_date date not null,
	re_ip varchar2(40) not null,
	rating number(2,1) not null, --평점이고 0~5점이며 소숫점 1자리까지 허용
	book_num number not null,
	memberId varchar2(12) not null,
	constraint book_reply_pk primary key (re_num),
	constraint book_reply_fk1 foreign key (book_num) references book (book_num),
	constraint book_reply_fk2 foreign key (memberId) references member1 (memberId)
);

CREATE sequence bookreply_seq;

--구매기록 db
CREATE TABLE recordsPurchases (
	records_num number not null,
	book_num number not null,
	memberId varchar2(12) not null,
	total_price number(9) not null,
	purchaseDate Date not null,
    bookmark number default 1 not null,    
	constraint records_bookId_fk1 foreign key (book_num) references book (book_num),
	constraint records_memberId_fk2 foreign key (memberId) references member1 (memberId)
);

CREATE sequence records_seq;

--장바구니 db
CREATE TABLE basket(
	book_num number not null,
	memberId varchar2(12) not null,
	constraint basket_booknum_fk1 foreign key (book_num) references book (book_num),
	constraint basket_memberId_fk2 foreign key (memberId) references member1 (memberId)
);

--심리테스트 결과 기준 db
CREATE TABLE pType(
    mtype varchar2(30) not null,
    image varchar2(200) not null,
    explanation clob not null,
    highLv varchar2(20) not null,
	lowLv varchar2(50) not null
);


insert into ptype values('HEALER','../img/type/HEALER.PNG','내향적, 미래지향적, 감정적, 두루뭉술한 타입. 상대방과는 마음의 벽을 쌓아놓고, 좀처럼 타인에게 표현하지 않는 사람이라서 이래저래 끌려다니기 쉽다. 마음이 깊고 넓으나 확고한 신념을 가지고 있으며 조용하게, 하지만 확실하게 그 신념을 실현시킨다. 대체로 개방적이고 모두에게 관대하지만 마음의 벽이 허물어지는 위협을 당하면 미친듯이 몰아붙인다. 완벽주의자이며 노동의 결과보다 노동 자체의 의미에 관심을 가진다.','만화','스포츠');
insert into ptype values('HEALER','../img/type/HEALER.PNG','내향적, 미래지향적, 감정적, 두루뭉술한 타입. 상대방과는 마음의 벽을 쌓아놓고, 좀처럼 타인에게 표현하지 않는 사람이라서 이래저래 끌려다니기 쉽다. 마음이 깊고 넓으나 확고한 신념을 가지고 있으며 조용하게, 하지만 확실하게 그 신념을 실현시킨다. 대체로 개방적이고 모두에게 관대하지만 마음의 벽이 허물어지는 위협을 당하면 미친듯이 몰아붙인다. 완벽주의자이며 노동의 결과보다 노동 자체의 의미에 관심을 가진다.','소설','SF');
insert into ptype values('HEALER','../img/type/HEALER.PNG','내향적, 미래지향적, 감정적, 두루뭉술한 타입. 상대방과는 마음의 벽을 쌓아놓고, 좀처럼 타인에게 표현하지 않는 사람이라서 이래저래 끌려다니기 쉽다. 마음이 깊고 넓으나 확고한 신념을 가지고 있으며 조용하게, 하지만 확실하게 그 신념을 실현시킨다. 대체로 개방적이고 모두에게 관대하지만 마음의 벽이 허물어지는 위협을 당하면 미친듯이 몰아붙인다. 완벽주의자이며 노동의 결과보다 노동 자체의 의미에 관심을 가진다.','에세이시','에세이');

insert into ptype values('INSPECTOR','../img/type/INSPECTOR.PNG','내향적, 현실적, 사고적, 직선적인 타입. 어떤 사실에 대해 있는 그대로 정확하고 체계적으로 기억하고자 하며, 신중하고 책임감도 강한 스타일. 현실감각이 뛰어나 모든 행위에 현실성을 부여하며 웬만한 위기에는 당황하지 않는다. 얼굴로 표현하진 않지만 상황에 대해 개인적으로 받아들이는 타입. 세부적인 디테일에 집착하는 성격적 단점이 있을 수 있다.','만화','스포츠');
insert into ptype values('INSPECTOR','../img/type/INSPECTOR.PNG','내향적, 현실적, 사고적, 직선적인 타입. 어떤 사실에 대해 있는 그대로 정확하고 체계적으로 기억하고자 하며, 신중하고 책임감도 강한 스타일. 현실감각이 뛰어나 모든 행위에 현실성을 부여하며 웬만한 위기에는 당황하지 않는다. 얼굴로 표현하진 않지만 상황에 대해 개인적으로 받아들이는 타입. 세부적인 디테일에 집착하는 성격적 단점이 있을 수 있다.','소설','추리스릴러');
insert into ptype values('INSPECTOR','../img/type/INSPECTOR.PNG','내향적, 현실적, 사고적, 직선적인 타입. 어떤 사실에 대해 있는 그대로 정확하고 체계적으로 기억하고자 하며, 신중하고 책임감도 강한 스타일. 현실감각이 뛰어나 모든 행위에 현실성을 부여하며 웬만한 위기에는 당황하지 않는다. 얼굴로 표현하진 않지만 상황에 대해 개인적으로 받아들이는 타입. 세부적인 디테일에 집착하는 성격적 단점이 있을 수 있다.','전문서적','과학');

insert into ptype values('SAINT','../img/type/SAINT.PNG','내향적, 현실적, 감정적, 두루뭉술한 타입. 관용과 인간미로 대표되는 유형이며, 모든 유형 중에서 자기를 가장 겸손하게 평가한다. 삶의 현재를 즐기고, 뛰어난 성과보다는 그 성과를 만들기 위해 행동하는 과정을 즐긴다. 즉 월급보다는 월급을 받기 위한 하루하루를 즐기며 주변 사람들에게 헌신을 보이는 사람. 다만 너무 온정적이어서 중대사를 결정할 때 타인의 감정에 좌지우지되는 경향이 있어 결정력과 추진력이 부족한 편.','만화','로맨스');
insert into ptype values('SAINT','../img/type/SAINT.PNG','내향적, 현실적, 감정적, 두루뭉술한 타입. 관용과 인간미로 대표되는 유형이며, 모든 유형 중에서 자기를 가장 겸손하게 평가한다. 삶의 현재를 즐기고, 뛰어난 성과보다는 그 성과를 만들기 위해 행동하는 과정을 즐긴다. 즉 월급보다는 월급을 받기 위한 하루하루를 즐기며 주변 사람들에게 헌신을 보이는 사람. 다만 너무 온정적이어서 중대사를 결정할 때 타인의 감정에 좌지우지되는 경향이 있어 결정력과 추진력이 부족한 편.','소설','고전');
insert into ptype values('SAINT','../img/type/SAINT.PNG','내향적, 현실적, 감정적, 두루뭉술한 타입. 관용과 인간미로 대표되는 유형이며, 모든 유형 중에서 자기를 가장 겸손하게 평가한다. 삶의 현재를 즐기고, 뛰어난 성과보다는 그 성과를 만들기 위해 행동하는 과정을 즐긴다. 즉 월급보다는 월급을 받기 위한 하루하루를 즐기며 주변 사람들에게 헌신을 보이는 사람. 다만 너무 온정적이어서 중대사를 결정할 때 타인의 감정에 좌지우지되는 경향이 있어 결정력과 추진력이 부족한 편.','에세이시','시');

insert into ptype values('SPARK','../img/type/SPARK.PNG','외향적, 미래지향적, 감정적, 두루뭉술한 타입. 말 그대로 굉장히 열정적이고 상상력이 풍부한 사람. 어떤 일이든 솔선수범하고 먼저 끝내려는 경향이 있으며, 관심을 가진 일에 대해서는 새로운 아이디어를 가지고 능동적으로 처리한다. 통찰력이 뛰어나며 성장 가능성에 더 관심을 보이며, 다른 사람들도 같이 뛰어들게끔 만드는 재주가 있다. 다만 일상의 반복을 견디지 못하고 통찰력, 창의력이 필요없는 단순 노동을 경멸한다.','만화','액션');
insert into ptype values('SPARK','../img/type/SPARK.PNG','외향적, 미래지향적, 감정적, 두루뭉술한 타입. 말 그대로 굉장히 열정적이고 상상력이 풍부한 사람. 어떤 일이든 솔선수범하고 먼저 끝내려는 경향이 있으며, 관심을 가진 일에 대해서는 새로운 아이디어를 가지고 능동적으로 처리한다. 통찰력이 뛰어나며 성장 가능성에 더 관심을 보이며, 다른 사람들도 같이 뛰어들게끔 만드는 재주가 있다. 다만 일상의 반복을 견디지 못하고 통찰력, 창의력이 필요없는 단순 노동을 경멸한다.','만화','판타지');
insert into ptype values('SPARK','../img/type/SPARK.PNG','외향적, 미래지향적, 감정적, 두루뭉술한 타입. 말 그대로 굉장히 열정적이고 상상력이 풍부한 사람. 어떤 일이든 솔선수범하고 먼저 끝내려는 경향이 있으며, 관심을 가진 일에 대해서는 새로운 아이디어를 가지고 능동적으로 처리한다. 통찰력이 뛰어나며 성장 가능성에 더 관심을 보이며, 다른 사람들도 같이 뛰어들게끔 만드는 재주가 있다. 다만 일상의 반복을 견디지 못하고 통찰력, 창의력이 필요없는 단순 노동을 경멸한다.','소설','판타지');

insert into ptype values('INVENTOR','../img/type/INVENTOR.PNG','외향적, 미래지향적, 사고적, 인식적인 타입. 어떻게든 새로운 가능성과 독창성을 찾으려는 타입이라서 여러 업종에 두루두루 재능이 많다. 지칠 줄 모르는 에너지로 항상 새로운 것을 찾고 지대한 안목을 지니고 있다. 다른 사람을 이끌기보다는 그 사람이 당면한 문제를 독창적으로, 자기 스스로가 해결하는 것을 좋아한다. 자신감이 지나친 면이 있으며 흥미가 떨어진 일은 마무리가 채 되지 않는 부분이 있을 수 있다.','전문서적','경영경제');
insert into ptype values('INVENTOR','../img/type/INVENTOR.PNG','외향적, 미래지향적, 사고적, 인식적인 타입. 어떻게든 새로운 가능성과 독창성을 찾으려는 타입이라서 여러 업종에 두루두루 재능이 많다. 지칠 줄 모르는 에너지로 항상 새로운 것을 찾고 지대한 안목을 지니고 있다. 다른 사람을 이끌기보다는 그 사람이 당면한 문제를 독창적으로, 자기 스스로가 해결하는 것을 좋아한다. 자신감이 지나친 면이 있으며 흥미가 떨어진 일은 마무리가 채 되지 않는 부분이 있을 수 있다.','전문서적','과학');
insert into ptype values('INVENTOR','../img/type/INVENTOR.PNG','외향적, 미래지향적, 사고적, 인식적인 타입. 어떻게든 새로운 가능성과 독창성을 찾으려는 타입이라서 여러 업종에 두루두루 재능이 많다. 지칠 줄 모르는 에너지로 항상 새로운 것을 찾고 지대한 안목을 지니고 있다. 다른 사람을 이끌기보다는 그 사람이 당면한 문제를 독창적으로, 자기 스스로가 해결하는 것을 좋아한다. 자신감이 지나친 면이 있으며 흥미가 떨어진 일은 마무리가 채 되지 않는 부분이 있을 수 있다.','에세이시','에세이');

insert into ptype values('LEADER','../img/type/LEADER.PNG','외향적, 미래지향적, 사고적, 계획적인 타입. 사업가 형과 비슷하게 계획, 추진, 체계적인 사람이지만, 세부적인 디테일보다는 미래를 향한 거시적인 안목을 보고 장기적인 플랜을 세운다. 통솔력이 강하며 관념적이고, 일반적으로는 해결하려 하지 않는 복잡한 문제를 푸는 데에 흥미를 보인다. 때로 현 상황을 파악하지 않고 성급하게 일을 추진하기도 하며불도저, 자신을 따르는 사람의 감정엔 큰 의미를 두지 않으므로 주의해야 한다.','만화','액션');
insert into ptype values('LEADER','../img/type/LEADER.PNG','외향적, 미래지향적, 사고적, 계획적인 타입. 사업가 형과 비슷하게 계획, 추진, 체계적인 사람이지만, 세부적인 디테일보다는 미래를 향한 거시적인 안목을 보고 장기적인 플랜을 세운다. 통솔력이 강하며 관념적이고, 일반적으로는 해결하려 하지 않는 복잡한 문제를 푸는 데에 흥미를 보인다. 때로 현 상황을 파악하지 않고 성급하게 일을 추진하기도 하며불도저, 자신을 따르는 사람의 감정엔 큰 의미를 두지 않으므로 주의해야 한다.','에세이시','에세이');
insert into ptype values('LEADER','../img/type/LEADER.PNG','외향적, 미래지향적, 사고적, 계획적인 타입. 사업가 형과 비슷하게 계획, 추진, 체계적인 사람이지만, 세부적인 디테일보다는 미래를 향한 거시적인 안목을 보고 장기적인 플랜을 세운다. 통솔력이 강하며 관념적이고, 일반적으로는 해결하려 하지 않는 복잡한 문제를 푸는 데에 흥미를 보인다. 때로 현 상황을 파악하지 않고 성급하게 일을 추진하기도 하며불도저, 자신을 따르는 사람의 감정엔 큰 의미를 두지 않으므로 주의해야 한다.','전문서적','경영경제');

commit;
