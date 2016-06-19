package songhu.util.aop;

public class Syslog {
	private String ipAddress;
	private String loginName;
	private String methodName;
	private String methodRemark;
	private String operDate;
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	public String getMethodRemark() {
		return methodRemark;
	}
	public void setMethodRemark(String methodRemark) {
		this.methodRemark = methodRemark;
	}
	public String getOperDate() {
		return operDate;
	}
	public void setOperDate(String operDate) {
		this.operDate = operDate;
	}

}
