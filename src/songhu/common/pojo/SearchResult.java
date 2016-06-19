package songhu.common.pojo;

import java.util.List;

public class SearchResult {
	private int totalHits;
	private long usedtime;
	private List<Article> list;

	public int getTotalHits() {
		return totalHits;
	}

	public void setTotalHits(int totalHits) {
		this.totalHits = totalHits;
	}

	public long getUsedtime() {
		return usedtime;
	}

	public void setUsedtime(long usedtime) {
		this.usedtime = usedtime;
	}

	public List<Article> getList() {
		return list;
	}

	public void setList(List<Article> list) {
		this.list = list;
	}

}
