package kr.purchase.domain;

public class BasketDto {
	private int basket_num;
	private int book_num;
	private String memberId;
	private String imgFilename;
	private String title;
	private int price;
	private String author;
	private String audioLink;
	
	public int getBasket_num() {
		return basket_num;
	}
	public void setBasket_num(int basket_num) {
		this.basket_num = basket_num;
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
	
	public String getImgFilename() {
		return imgFilename;
	}
	public void setImgFilename(String imgFilename) {
		this.imgFilename = imgFilename;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	
	public String getAudioLink() {
		return audioLink;
	}
	public void setAudioLink(String audioLink) {
		this.audioLink = audioLink;
	}
	@Override
	public String toString() {
		return "BasketDto [basket_num=" + basket_num + ", book_num=" + book_num + ", memberId=" + memberId + "]";
	}
}
