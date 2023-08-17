package table;

import java.sql.Date;

public class Post {
	/*
	 	CREATE TABLE Post(
    		postid INT NOT NULL PRIMARY KEY, 
			type VARCHAR2(20), 
    		title VARCHAR2(2000),
			text VARCHAR2(2000), 
			writingdate DATE,
    		id INT,
    		name VARCHAR2(20),
    		img CLOB,
			viewsnum INT
		);
	 */
	private int postid;
	private String type;
	private String title;
	private String text;
	private Date writingdate;
	private String id;
	private String name;
	private String img;
	private int viewsnum;

	public int getPostid() {
		return postid;
	}

	public void setPostid(int postid) {
		this.postid = postid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Date getWritingdate() {
		return writingdate;
	}

	public void setWritingdate(Date writingdate) {
		this.writingdate = writingdate;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public int getViewsnum() {
		return viewsnum;
	}

	public void setViewsnum(int viewsnum) {
		this.viewsnum = viewsnum;
	}
}