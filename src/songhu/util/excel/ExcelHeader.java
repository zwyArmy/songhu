package songhu.util.excel;

public class ExcelHeader {
	public ExcelHeader(String name, int length) {
		this.name = name;
		this.length = length;
	}

	private String name;
	private int length;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getLength() {
		return length;
	}

	public void setLength(int length) {
		this.length = length;
	}
}
