package songhu.system.vo;

public class TreeCode {
    private String id;
    private String zldm;
    private String dmmc;
    private String kz;
    private boolean leaf;
	private String enabled;
	
    public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getZldm() {
		return zldm;
	}
	public void setZldm(String zldm) {
		this.zldm = zldm;
	}
	public String getDmmc() {
		return dmmc;
	}
	public void setDmmc(String dmmc) {
		this.dmmc = dmmc;
	}
	public String getKz() {
		return kz;
	}
	public void setKz(String kz) {
		this.kz = kz;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
}
