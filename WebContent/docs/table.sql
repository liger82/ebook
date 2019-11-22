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
	contentFilename varchar2(200) not null, --������ϸ� ���� ��� '0'���� �ϸ� ��.
	seriesCode varchar2(15),
	introduction clob not null, --å �Ұ� ��
	pubDate Date not null, --�Ⱓ��
	regDate Date not null, --�����
	constraint book_num_pk primary key (book_num)
);

CREATE sequence book_seq; -- book id ����.

--member db 
CREATE TABLE member1 (
	memberId varchar2(12) not null,
	pw varchar2(12) not null,
	lv number(1) not null,
	constraint member1_id_pk primary key (memberId)
);
--member �� ���� db
CREATE TABLE member2 (
	memberId varchar2(12) not null,
	name varchar2(12) not null,
	sex varchar2(6) not null,
	email varchar2(40) not null,
	phone varchar2(13) not null,
	mtype varchar2(30) default '0' not null, --�ɸ��׽�Ʈ ������ '0'
	regDate Date not null,
	constraint member2_id_fk foreign key (memberId) references member1 (memberId)
);

--��� db
CREATE TABLE book_reply (
	re_num number not null,
	re_content varchar2(900) not null,
	re_date date not null,
	re_ip varchar2(40) not null,
	rating number(2,1) not null, --�����̰� 0~5���̸� �Ҽ��� 1�ڸ����� ���
	book_num number not null,
	memberId varchar2(12) not null,
	constraint book_reply_pk primary key (re_num),
	constraint book_reply_fk1 foreign key (book_num) references book (book_num),
	constraint book_reply_fk2 foreign key (memberId) references member1 (memberId)
);

CREATE sequence bookreply_seq;

--���ű�� db
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

--��ٱ��� db
CREATE TABLE basket(
	book_num number not null,
	memberId varchar2(12) not null,
	constraint basket_booknum_fk1 foreign key (book_num) references book (book_num),
	constraint basket_memberId_fk2 foreign key (memberId) references member1 (memberId)
);

--�ɸ��׽�Ʈ ��� ���� db
CREATE TABLE pType(
    mtype varchar2(30) not null,
    image varchar2(200) not null,
    explanation clob not null,
    highLv varchar2(20) not null,
	lowLv varchar2(50) not null
);


insert into ptype values('HEALER','../img/type/HEALER.PNG','������, �̷�������, ������, �η繶���� Ÿ��. ������� ������ ���� �׾Ƴ���, ��ó�� Ÿ�ο��� ǥ������ �ʴ� ����̶� �̷����� �����ٴϱ� ����. ������ ���� ������ Ȯ���� �ų��� ������ ������ �����ϰ�, ������ Ȯ���ϰ� �� �ų��� ������Ų��. ��ü�� �������̰� ��ο��� ���������� ������ ���� �㹰������ ������ ���ϸ� ��ģ���� ���ƺ��δ�. �Ϻ��������̸� �뵿�� ������� �뵿 ��ü�� �ǹ̿� ������ ������.','��ȭ','������');
insert into ptype values('HEALER','../img/type/HEALER.PNG','������, �̷�������, ������, �η繶���� Ÿ��. ������� ������ ���� �׾Ƴ���, ��ó�� Ÿ�ο��� ǥ������ �ʴ� ����̶� �̷����� �����ٴϱ� ����. ������ ���� ������ Ȯ���� �ų��� ������ ������ �����ϰ�, ������ Ȯ���ϰ� �� �ų��� ������Ų��. ��ü�� �������̰� ��ο��� ���������� ������ ���� �㹰������ ������ ���ϸ� ��ģ���� ���ƺ��δ�. �Ϻ��������̸� �뵿�� ������� �뵿 ��ü�� �ǹ̿� ������ ������.','�Ҽ�','SF');
insert into ptype values('HEALER','../img/type/HEALER.PNG','������, �̷�������, ������, �η繶���� Ÿ��. ������� ������ ���� �׾Ƴ���, ��ó�� Ÿ�ο��� ǥ������ �ʴ� ����̶� �̷����� �����ٴϱ� ����. ������ ���� ������ Ȯ���� �ų��� ������ ������ �����ϰ�, ������ Ȯ���ϰ� �� �ų��� ������Ų��. ��ü�� �������̰� ��ο��� ���������� ������ ���� �㹰������ ������ ���ϸ� ��ģ���� ���ƺ��δ�. �Ϻ��������̸� �뵿�� ������� �뵿 ��ü�� �ǹ̿� ������ ������.','�����̽�','������');

insert into ptype values('INSPECTOR','../img/type/INSPECTOR.PNG','������, ������, �����, �������� Ÿ��. � ��ǿ� ���� �ִ� �״�� ��Ȯ�ϰ� ü�������� ����ϰ��� �ϸ�, �����ϰ� å�Ӱ��� ���� ��Ÿ��. ���ǰ����� �پ ��� ������ ���Ǽ��� �ο��ϸ� ������ ���⿡�� ��Ȳ���� �ʴ´�. �󱼷� ǥ������ ������ ��Ȳ�� ���� ���������� �޾Ƶ��̴� Ÿ��. �������� �����Ͽ� �����ϴ� ������ ������ ���� �� �ִ�.','��ȭ','������');
insert into ptype values('INSPECTOR','../img/type/INSPECTOR.PNG','������, ������, �����, �������� Ÿ��. � ��ǿ� ���� �ִ� �״�� ��Ȯ�ϰ� ü�������� ����ϰ��� �ϸ�, �����ϰ� å�Ӱ��� ���� ��Ÿ��. ���ǰ����� �پ ��� ������ ���Ǽ��� �ο��ϸ� ������ ���⿡�� ��Ȳ���� �ʴ´�. �󱼷� ǥ������ ������ ��Ȳ�� ���� ���������� �޾Ƶ��̴� Ÿ��. �������� �����Ͽ� �����ϴ� ������ ������ ���� �� �ִ�.','�Ҽ�','�߸�������');
insert into ptype values('INSPECTOR','../img/type/INSPECTOR.PNG','������, ������, �����, �������� Ÿ��. � ��ǿ� ���� �ִ� �״�� ��Ȯ�ϰ� ü�������� ����ϰ��� �ϸ�, �����ϰ� å�Ӱ��� ���� ��Ÿ��. ���ǰ����� �پ ��� ������ ���Ǽ��� �ο��ϸ� ������ ���⿡�� ��Ȳ���� �ʴ´�. �󱼷� ǥ������ ������ ��Ȳ�� ���� ���������� �޾Ƶ��̴� Ÿ��. �������� �����Ͽ� �����ϴ� ������ ������ ���� �� �ִ�.','��������','����');

insert into ptype values('SAINT','../img/type/SAINT.PNG','������, ������, ������, �η繶���� Ÿ��. ����� �ΰ��̷� ��ǥ�Ǵ� �����̸�, ��� ���� �߿��� �ڱ⸦ ���� ����ϰ� ���Ѵ�. ���� ���縦 ����, �پ �������ٴ� �� ������ ����� ���� �ൿ�ϴ� ������ ����. �� ���޺��ٴ� ������ �ޱ� ���� �Ϸ��Ϸ縦 ���� �ֺ� ����鿡�� ����� ���̴� ���. �ٸ� �ʹ� �������̾ �ߴ�縦 ������ �� Ÿ���� ������ ���������Ǵ� ������ �־� �����°� �������� ������ ��.','��ȭ','�θǽ�');
insert into ptype values('SAINT','../img/type/SAINT.PNG','������, ������, ������, �η繶���� Ÿ��. ����� �ΰ��̷� ��ǥ�Ǵ� �����̸�, ��� ���� �߿��� �ڱ⸦ ���� ����ϰ� ���Ѵ�. ���� ���縦 ����, �پ �������ٴ� �� ������ ����� ���� �ൿ�ϴ� ������ ����. �� ���޺��ٴ� ������ �ޱ� ���� �Ϸ��Ϸ縦 ���� �ֺ� ����鿡�� ����� ���̴� ���. �ٸ� �ʹ� �������̾ �ߴ�縦 ������ �� Ÿ���� ������ ���������Ǵ� ������ �־� �����°� �������� ������ ��.','�Ҽ�','����');
insert into ptype values('SAINT','../img/type/SAINT.PNG','������, ������, ������, �η繶���� Ÿ��. ����� �ΰ��̷� ��ǥ�Ǵ� �����̸�, ��� ���� �߿��� �ڱ⸦ ���� ����ϰ� ���Ѵ�. ���� ���縦 ����, �پ �������ٴ� �� ������ ����� ���� �ൿ�ϴ� ������ ����. �� ���޺��ٴ� ������ �ޱ� ���� �Ϸ��Ϸ縦 ���� �ֺ� ����鿡�� ����� ���̴� ���. �ٸ� �ʹ� �������̾ �ߴ�縦 ������ �� Ÿ���� ������ ���������Ǵ� ������ �־� �����°� �������� ������ ��.','�����̽�','��');

insert into ptype values('SPARK','../img/type/SPARK.PNG','������, �̷�������, ������, �η繶���� Ÿ��. �� �״�� ������ �������̰� ������ ǳ���� ���. � ���̵� �ּ������ϰ� ���� �������� ������ ������, ������ ���� �Ͽ� ���ؼ��� ���ο� ���̵� ������ �ɵ������� ó���Ѵ�. �������� �پ�� ���� ���ɼ��� �� ������ ���̸�, �ٸ� ����鵵 ���� �پ��Բ� ����� ���ְ� �ִ�. �ٸ� �ϻ��� �ݺ��� �ߵ��� ���ϰ� ������, â�Ƿ��� �ʿ���� �ܼ� �뵿�� ����Ѵ�.','��ȭ','�׼�');
insert into ptype values('SPARK','../img/type/SPARK.PNG','������, �̷�������, ������, �η繶���� Ÿ��. �� �״�� ������ �������̰� ������ ǳ���� ���. � ���̵� �ּ������ϰ� ���� �������� ������ ������, ������ ���� �Ͽ� ���ؼ��� ���ο� ���̵� ������ �ɵ������� ó���Ѵ�. �������� �پ�� ���� ���ɼ��� �� ������ ���̸�, �ٸ� ����鵵 ���� �پ��Բ� ����� ���ְ� �ִ�. �ٸ� �ϻ��� �ݺ��� �ߵ��� ���ϰ� ������, â�Ƿ��� �ʿ���� �ܼ� �뵿�� ����Ѵ�.','��ȭ','��Ÿ��');
insert into ptype values('SPARK','../img/type/SPARK.PNG','������, �̷�������, ������, �η繶���� Ÿ��. �� �״�� ������ �������̰� ������ ǳ���� ���. � ���̵� �ּ������ϰ� ���� �������� ������ ������, ������ ���� �Ͽ� ���ؼ��� ���ο� ���̵� ������ �ɵ������� ó���Ѵ�. �������� �پ�� ���� ���ɼ��� �� ������ ���̸�, �ٸ� ����鵵 ���� �پ��Բ� ����� ���ְ� �ִ�. �ٸ� �ϻ��� �ݺ��� �ߵ��� ���ϰ� ������, â�Ƿ��� �ʿ���� �ܼ� �뵿�� ����Ѵ�.','�Ҽ�','��Ÿ��');

insert into ptype values('INVENTOR','../img/type/INVENTOR.PNG','������, �̷�������, �����, �ν����� Ÿ��. ��Ե� ���ο� ���ɼ��� ��â���� ã������ Ÿ���̶� ���� ������ �η�η� ����� ����. ��ĥ �� �𸣴� �������� �׻� ���ο� ���� ã�� ������ �ȸ��� ���ϰ� �ִ�. �ٸ� ����� �̲��⺸�ٴ� �� ����� ����� ������ ��â������, �ڱ� �����ΰ� �ذ��ϴ� ���� �����Ѵ�. �ڽŰ��� ����ģ ���� ������ ��̰� ������ ���� �������� ä ���� �ʴ� �κ��� ���� �� �ִ�.','��������','�濵����');
insert into ptype values('INVENTOR','../img/type/INVENTOR.PNG','������, �̷�������, �����, �ν����� Ÿ��. ��Ե� ���ο� ���ɼ��� ��â���� ã������ Ÿ���̶� ���� ������ �η�η� ����� ����. ��ĥ �� �𸣴� �������� �׻� ���ο� ���� ã�� ������ �ȸ��� ���ϰ� �ִ�. �ٸ� ����� �̲��⺸�ٴ� �� ����� ����� ������ ��â������, �ڱ� �����ΰ� �ذ��ϴ� ���� �����Ѵ�. �ڽŰ��� ����ģ ���� ������ ��̰� ������ ���� �������� ä ���� �ʴ� �κ��� ���� �� �ִ�.','��������','����');
insert into ptype values('INVENTOR','../img/type/INVENTOR.PNG','������, �̷�������, �����, �ν����� Ÿ��. ��Ե� ���ο� ���ɼ��� ��â���� ã������ Ÿ���̶� ���� ������ �η�η� ����� ����. ��ĥ �� �𸣴� �������� �׻� ���ο� ���� ã�� ������ �ȸ��� ���ϰ� �ִ�. �ٸ� ����� �̲��⺸�ٴ� �� ����� ����� ������ ��â������, �ڱ� �����ΰ� �ذ��ϴ� ���� �����Ѵ�. �ڽŰ��� ����ģ ���� ������ ��̰� ������ ���� �������� ä ���� �ʴ� �κ��� ���� �� �ִ�.','�����̽�','������');

insert into ptype values('LEADER','../img/type/LEADER.PNG','������, �̷�������, �����, ��ȹ���� Ÿ��. ����� ���� ����ϰ� ��ȹ, ����, ü������ ���������, �������� �����Ϻ��ٴ� �̷��� ���� �Ž����� �ȸ��� ���� ������� �÷��� �����. ��ַ��� ���ϸ� �������̰�, �Ϲ������δ� �ذ��Ϸ� ���� �ʴ� ������ ������ Ǫ�� ���� ��̸� ���δ�. ���� �� ��Ȳ�� �ľ����� �ʰ� �����ϰ� ���� �����ϱ⵵ �ϸ�ҵ���, �ڽ��� ������ ����� ������ ū �ǹ̸� ���� �����Ƿ� �����ؾ� �Ѵ�.','��ȭ','�׼�');
insert into ptype values('LEADER','../img/type/LEADER.PNG','������, �̷�������, �����, ��ȹ���� Ÿ��. ����� ���� ����ϰ� ��ȹ, ����, ü������ ���������, �������� �����Ϻ��ٴ� �̷��� ���� �Ž����� �ȸ��� ���� ������� �÷��� �����. ��ַ��� ���ϸ� �������̰�, �Ϲ������δ� �ذ��Ϸ� ���� �ʴ� ������ ������ Ǫ�� ���� ��̸� ���δ�. ���� �� ��Ȳ�� �ľ����� �ʰ� �����ϰ� ���� �����ϱ⵵ �ϸ�ҵ���, �ڽ��� ������ ����� ������ ū �ǹ̸� ���� �����Ƿ� �����ؾ� �Ѵ�.','�����̽�','������');
insert into ptype values('LEADER','../img/type/LEADER.PNG','������, �̷�������, �����, ��ȹ���� Ÿ��. ����� ���� ����ϰ� ��ȹ, ����, ü������ ���������, �������� �����Ϻ��ٴ� �̷��� ���� �Ž����� �ȸ��� ���� ������� �÷��� �����. ��ַ��� ���ϸ� �������̰�, �Ϲ������δ� �ذ��Ϸ� ���� �ʴ� ������ ������ Ǫ�� ���� ��̸� ���δ�. ���� �� ��Ȳ�� �ľ����� �ʰ� �����ϰ� ���� �����ϱ⵵ �ϸ�ҵ���, �ڽ��� ������ ����� ������ ū �ǹ̸� ���� �����Ƿ� �����ؾ� �Ѵ�.','��������','�濵����');

commit;