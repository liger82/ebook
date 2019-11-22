package kr.purchase.domain;

import java.sql.Date;

public class RecordsDto {
	private int records_num; //���ű�� ������ȣ
	private int book_num; //å ������ȣ
	private String memberId; //��� ���̵�
	private int total_price; //�� ����
	private Date purchaseDate; //���� ����
	//å���Ǵ� �⺻ ���� 1�̹Ƿ� insert�� 1�� ����
	private int bookmark; //å����
	private String title;
	private String author;
	private int price;
	private String imgFilename;
	private String audioLink;

	public int getRecords_num() {
		return records_num;
	}
	public void setRecords_num(int records_num) {
		this.records_num = records_num;
	}
	public int getBook_num() {
		return book_num;
	}
	public void setBook_num(int book_num) {
		this.book_num = book_num;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public Date getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	public int getBookmark() {
		return bookmark;
	}
	public void setBookmark(int bookmark) {
		this.bookmark = bookmark;
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
	public String getImgFilename() {
		return imgFilename;
	}
	public void setImgFilename(String imgFilename) {
		this.imgFilename = imgFilename;
	}
	public String getAudioLink() {
		return audioLink;
	}
	public void setAudioLink(String audioLink) {
		this.audioLink = audioLink;
	}
	@Override
	public String toString() {
		return "RecordsDto [records_num=" + records_num + ", book_num=" + book_num + ", memberId=" + memberId
				+ ", total_price=" + total_price + ", purchaseDate=" + purchaseDate + ", bookmark=" + bookmark
				+ ", title=" + title + ", author=" + author + ", price=" + price + ", imgFilename=" + imgFilename
				+ ", audioLink=" + audioLink + "]";
	}
	
}
