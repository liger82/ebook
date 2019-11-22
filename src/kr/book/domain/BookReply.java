package kr.book.domain;

import java.sql.Date;

public class BookReply {
	private int re_num; // ´ñ±Û °íÀ¯¹øÈ£
	private String re_content; //´ñ±Û ³»¿ë
	private Date re_date; //´ñ±Û µî·ÏÀÏ
	private String re_ip; //ip
	private float rating;
	private int book_num; //Ã¥ °íÀ¯¹øÈ£
	private String memberId;
	
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public Date getRe_date() {
		return re_date;
	}
	public void setRe_date(Date re_date) {
		this.re_date = re_date;
	}
	public String getRe_ip() {
		return re_ip;
	}
	public void setRe_ip(String re_ip) {
		this.re_ip = re_ip;
	}
	
	public float getRating() {
		return rating;
	}
	public void setRating(float rating) {
		this.rating = rating;
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

	
}
