package table;

import java.sql.Date;

public class Calendar {
	private int calid;
	private Date startdate;
	private Date enddate;
	private String text;
	private int postid;

	public int getCalid() {
		return calid;
	}

	public void setCalid(int calid) {
		this.calid = calid;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getPostid() {
		return postid;
	}

	public void setPostid(int postid) {
		this.postid = postid;
	}
}