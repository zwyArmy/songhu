package songhu.system.pojo;

import java.math.BigDecimal;

public class Column {
    private String id;
    private String parentId;
    private String colName;
    private String link;
    private String description;
    private BigDecimal sort;
    private String enabled;
	private String lmdm1;
    private String lmdm2;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEnabled() {
        return enabled;
    }

    public void setEnabled(String enabled) {
        this.enabled = enabled;
    }
    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getColName() {
        return colName;
    }

    public void setColName(String colName) {
        this.colName = colName;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getSort() {
        return sort;
    }

    public void setSort(BigDecimal sort) {
        this.sort = sort;
    }
    public String getLmdm1() {
  		return lmdm1;
  	}
  	public void setLmdm1(String lmdm1) {
  		this.lmdm1 = lmdm1;
  	}

  	public String getLmdm2() {
  		return lmdm2;
  	}

  	public void setLmdm2(String lmdm2) {
  		this.lmdm2 = lmdm2;
  	}
}