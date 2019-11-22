package kr.book.domain;

import java.sql.Date;

public class BookDto {
	private String highLv; //��з�
	private String lowLv; //�Һз�
	private int book_num; //å ������ȣ
	private String title; //����
	private String author; //����
	private int price; // ����
	private float rating; //����
	private String audioLink; //������� ��ũ
	private String imgFilename; //å ��ǥ�� �̹��� ���ϳ���(��� ����)
	private String contentFilename; //å ���� �����̸�
	private String seriesCode; //�ø�� ������ ������ �̸����� �ڵ��ֱ�
	private String introduction; //å �Ұ�
	private Date pubDate; //�Ⱓ��
	private Date regDate; //�����
	private int re_cnt; // ��� ����
	
	public int getRe_cnt() {
		return re_cnt;
	}
	public void setRe_cnt(int re_cnt) {
		this.re_cnt = re_cnt;
	}
	public String getHighLv() {
		return highLv;
	}
	public void setHighLv(String highLv) {
		this.highLv = highLv;
	}
	public String getLowLv() {
		return lowLv;
	}
	public void setLowLv(String lowLv) {
		this.lowLv = lowLv;
	}
	public int getBook_num() {
		return book_num;
	}
	public void setBook_num(int book_num) {
		this.book_num = book_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}

	public float getRating() {
		return rating;
	}
	public void setRating(float rating) {
		this.rating = rating;
	}
	public String getAudioLink() {
		return audioLink;
	}
	public void setAudioLink(String audioLink) {
		this.audioLink = audioLink;
	}
	public String getImgFilename() {
		return imgFilename;
	}
	public void setImgFilename(String imgFilename) {
		this.imgFilename = imgFilename;
	}
	public String getContentFilename() {
		return contentFilename;
	}
	public void setContentFilename(String contentFilename) {
		this.contentFilename = contentFilename;
	}
	public String getSeriesCode() {
		return seriesCode;
	}
	public void setSeriesCode(String seriesCode) {
		this.seriesCode = seriesCode;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public Date getPubDate() {
		return pubDate;
	}
	public void setPubDate(Date pubDate) {
		this.pubDate = pubDate;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "BookDto [highLv=" + highLv + ", lowLv=" + lowLv + ", book_num=" + book_num + ", title=" + title
				+ ", author=" + author + ", price=" + price + ", rating=" + rating + ", audioLink=" + audioLink + ", imgFilename=" + imgFilename + ", contentFilename=" + contentFilename
				+ ", seriesCode=" + seriesCode + ", introduction=" + introduction + ", pubDate=" + pubDate
				+ ", regDate=" + regDate + ", re_cnt=" + re_cnt + "]";
	}
	
}
