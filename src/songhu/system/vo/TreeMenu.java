package songhu.system.vo;

public class TreeMenu {
    private String id;
    private String fbh;
    private String mc;
    private String xh;
    private String click;
    private String lb;
    private String enabled;
    private boolean leaf;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFbh() {
		return fbh;
	}
	public void setFbh(String fbh) {
		this.fbh = fbh;
	}
	public String getMc() {
		return mc;
	}
	public void setMc(String mc) {
		this.mc = mc;
	}
	public String getXh() {
		return xh;
	}
	public void setXh(String xh) {
		this.xh = xh;
	}
	public String getClick() {
		return click;
	}
	public void setClick(String click) {
		this.click = click;
	}
	public String getLb() {
		return lb;
	}
	public void setLb(String lb) {
		this.lb = lb;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled.equals("1")?"<font color=blue>启用</font>":"<font color=red>禁用</font>";
	}

}
