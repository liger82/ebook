package kr.member.domain;

import java.sql.Date;

public class MemberDto {
	private String memberId;
	private String pw;
	private int lv;
	private String name;
	private String sex;
	private String email;
	private String phone;
	private String mtype;
	private Date regDate;
	
	public boolean isCheckedPasswd(String userPasswd) {
		if(userPasswd.equals(pw)) {
			return true;
		}else return false;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public int getLv() {
		return lv;
	}
	public void setLv(int lv) {
		this.lv = lv;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "MemberDto [memberId=" + memberId + ", pw=" + pw + ", lv=" + lv + ", name=" + name + ", sex=" + sex
				+ ", email=" + email + ", phone=" + phone + ", mtype=" + mtype + ", regDate=" + regDate + "]";
	}
	
}
