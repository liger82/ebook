package kr.book.domain;

import java.sql.Date;

public class BookDto {
	private String highLv; //대분류
	private String lowLv; //소분류
	private int book_num; //책 고유번호
	private String title; //제목
	private String author; //저자
	private int price; // 가격
	private float rating; //평점
	private String audioLink; //오디오북 링크
	private String imgFilename; //책 겉표지 이미지 파일네임(경로 포함)
	private String contentFilename; //책 내용 파일이름
	private String seriesCode; //시리즈가 있으면 동일한 이름으로 코드주기
	private String introduction; //책 소개
	private Date pubDate; //출간일
	private Date regDate; //등록일
	private int re_cnt; // 댓글 개수
	
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
