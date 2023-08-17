package table;

import java.sql.Date;

public class TenantBan {
	private String banid;
	private Date bandate;

	public String getBanid() {
		return banid;
	}

	public void setBanid(String banid) {
		this.banid = banid;
	}

	public Date getBandate() {
		return bandate;
	}

	public void setBandate(Date bandate) {
		this.bandate = bandate;
	}
}
