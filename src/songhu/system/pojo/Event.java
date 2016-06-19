package songhu.system.pojo;

import java.math.BigDecimal;

public class Event {
    private String eventid;
    private String userid;
    private String account;
    private String username;
    private String description;
    private String activetime;
    private String activetime1;
    private String requestpath;
    private String methodname;
    private BigDecimal costtime;
	public String getEventid() {
		return eventid;
	}
	public void setEventid(String eventid) {
		this.eventid = eventid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getActivetime() {
		return activetime;
	}
	public void setActivetime(String activetime) {
		this.activetime = activetime;
	}
	public String getActivetime1() {
		return activetime1;
	}
	public void setActivetime1(String activetime1) {
		this.activetime1 = activetime1;
	}
	public String getRequestpath() {
		return requestpath;
	}
	public void setRequestpath(String requestpath) {
		this.requestpath = requestpath;
	}
	public String getMethodname() {
		return methodname;
	}
	public void setMethodname(String methodname) {
		this.methodname = methodname;
	}
	public BigDecimal getCosttime() {
		return costtime;
	}
	public void setCosttime(BigDecimal costtime) {
		this.costtime = costtime;
	}
}