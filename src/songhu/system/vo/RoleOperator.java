package songhu.system.vo;

public class RoleOperator {
	private String dmCzy;//操作员代码
	private String dmGw;//岗位代码
	private String mcGw;//岗位名称
	private String locked;//岗位状态
	public String getDmCzy() {
		return dmCzy;
	}
	public void setDmCzy(String dmCzy) {
		this.dmCzy = dmCzy;
	}
	public String getDmGw() {
		return dmGw;
	}
	public void setDmGw(String dmGw) {
		this.dmGw = dmGw;
	}
	public String getMcGw() {
		return mcGw;
	}
	public void setMcGw(String mcGw) {
		this.mcGw = mcGw;
	}
	public String getLocked() {
		return locked;
	}
	public void setLocked(String locked) {
		this.locked = locked;
	}
}
