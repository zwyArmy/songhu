package songhu.system.pojo;

public class Depart {
	private String deptid;
	private String deptname;
	private String description;
	private String parentdeptid;
	private String email;
    private String phone;
	public String getDeptid() {
		return deptid;
	}
	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getParentdeptid() {
		return parentdeptid;
	}
	public void setParentdeptid(String parentdeptid) {
		this.parentdeptid = parentdeptid;
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

}
