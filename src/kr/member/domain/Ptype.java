package kr.member.domain;

public class Ptype {
	private String mtype;
	private String image;
	private String explanation;
	private String highLv;
	private String lowLv;
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
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
	@Override
	public String toString() {
		return "Ptype [mtype=" + mtype + ", image=" + image + ", explanation=" + explanation + ", highLv=" + highLv
				+ ", lowLv=" + lowLv + "]";
	}
}
