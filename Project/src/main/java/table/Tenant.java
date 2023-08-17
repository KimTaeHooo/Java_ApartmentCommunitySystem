package table;

import java.sql.Date;

public class Tenant {
	/*
		CREATE TABLE TenantComplet(
    		id VARCHAR2(200) PRIMARY KEY, 
			name VARCHAR2(200), 
			password VARCHAR2(200), 
			accessiondate DATE, 
			residence VARCHAR2(200)
		);
	*/
	private String id;
	private String name;
	private String password;
	private Date accessiondate;
	private String residence;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getAccessiondate() {
		return accessiondate;
	}
	public void setAccessiondate(Date accessiondate) {
		this.accessiondate = accessiondate;
	}
	public String getResidence() {
		return residence;
	}
	public void setResidence(String residence) {
		this.residence = residence;
	}
}