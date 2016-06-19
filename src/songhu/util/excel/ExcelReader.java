package songhu.util.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

/**
 * @author administrator
 */
public class ExcelReader {
	private HSSFWorkbook wb = null;// book [includes sheet]
	private HSSFSheet sheet = null;
	private HSSFRow row = null;
	private int sheetNum = 0; // 第sheetnum个工作表
	private int rowNum = 0;
	private FileInputStream fis = null;
	private File file = null;

	public ExcelReader() {
	}

	public ExcelReader(File file) {
		this.file = file;
	}

	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}

	public void setSheetNum(int sheetNum) {
		this.sheetNum = sheetNum;
	}

	public void setFile(File file) {
		this.file = file;
	}

	/**
	 * 读取excel文件获得HSSFWorkbook对象
	 */
	public void open() throws IOException {
		fis = new FileInputStream(file);
		wb = new HSSFWorkbook(new POIFSFileSystem(fis));
		fis.close();
	}

	/**
	 * 返回sheet表数目
	 * 
	 * @return int
	 */
	public int getSheetCount() {
		int sheetCount = -1;
		sheetCount = wb.getNumberOfSheets();
		return sheetCount;
	}

	/**
	 * sheetNum下的记录行数
	 * 
	 * @return int
	 */
	public int getRowCount() {
		if (wb == null)
			System.out.println("=============>WorkBook为空");
		HSSFSheet sheet = wb.getSheetAt(this.sheetNum);
		int rowCount = -1;
		rowCount = sheet.getLastRowNum();
		return rowCount;
	}

	/**
	 * 读取指定sheetNum的rowCount
	 * 
	 * @param sheetNum
	 * @return int
	 */
	public int getRowCount(int sheetNum) {
		HSSFSheet sheet = wb.getSheetAt(sheetNum);
		int rowCount = -1;
		rowCount = sheet.getLastRowNum();
		return rowCount;
	}

	/**
	 * 得到指定行的内容
	 * 
	 * @param lineNum
	 * @return String[]
	 */
	public String[] readExcelLine(int lineNum) {
		return readExcelLine(this.sheetNum, lineNum);
	}

	/**
	 * 指定工作表和行数的内容
	 * 
	 * @param sheetNum
	 * @param lineNum
	 * @return String[]
	 */
	public String[] readExcelLine(int sheetNum, int lineNum) {
		if (sheetNum < 0 || lineNum < 0)
			return null;
		String[] strExcelLine = null;
		try {
			sheet = wb.getSheetAt(sheetNum);
			row = sheet.getRow(lineNum);
			int cellCount = row.getLastCellNum();
			strExcelLine = new String[cellCount + 1];
			for (int i = 0; i <= cellCount; i++) {
				strExcelLine[i] = readStringExcelCell(lineNum, i);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return strExcelLine;
	}

	/**
	 * 读取指定列的内容
	 * 
	 * @param cellNum
	 * @return String
	 */
	public String readStringExcelCell(int cellNum) {
		return readStringExcelCell(this.rowNum, cellNum);
	}

	/**
	 * 指定行和列编号的内容
	 * 
	 * @param rowNum
	 * @param cellNum
	 * @return String
	 */
	public String readStringExcelCell(int rowNum, int cellNum) {
		return readStringExcelCell(this.sheetNum, rowNum, cellNum);
	}

	/**
	 * 指定工作表、行、列下的内容
	 * 
	 * @param sheetNum
	 * @param rowNum
	 * @param cellNum
	 * @return String
	 */
	public String readStringExcelCell(int sheetNum, int rowNum, int cellNum) {
		if (sheetNum < 0 || rowNum < 0)
			return "";
		String strExcelCell = "";
		try {
			sheet = wb.getSheetAt(sheetNum);
			row = sheet.getRow(rowNum);
			if (row.getCell((short) cellNum) != null) { // add this condition
				// judge
				switch (row.getCell((short) cellNum).getCellType()) {
				case HSSFCell.CELL_TYPE_FORMULA: // 公式型
					strExcelCell = String.valueOf(row.getCell((short) cellNum)
							.getNumericCellValue());
					if (strExcelCell.equals("NaN"))
						strExcelCell = row.getCell((short) cellNum)
								.getStringCellValue().toString();
					// strExcelCell = "FORMULA ";
					break;
				case HSSFCell.CELL_TYPE_NUMERIC:
					// 纯数字型
					strExcelCell = String.valueOf(row.getCell((short) cellNum)
							.getNumericCellValue());
					// 日期型
					if (HSSFDateUtil.isCellDateFormatted(row
							.getCell((short) cellNum))) {
						strExcelCell = HSSFDateUtil.getJavaDate(
								row.getCell((short) cellNum)
										.getNumericCellValue()).toString();
					}
					if (cellNum == 0) {
						strExcelCell = strExcelCell.substring(0, strExcelCell
								.indexOf("."));
					}
					break;
				case HSSFCell.CELL_TYPE_STRING: // 字符串型
					strExcelCell = row.getCell((short) cellNum)
							.getStringCellValue();
					break;
				case HSSFCell.CELL_TYPE_BLANK: // 空值型
					strExcelCell = "";
					break;
				case HSSFCell.CELL_TYPE_ERROR: // 错误
					strExcelCell = String.valueOf(row.getCell((short) cellNum)
							.getErrorCellValue());
				case HSSFCell.CELL_TYPE_BOOLEAN: // 布尔型
					strExcelCell = String.valueOf(row.getCell((short) cellNum)
							.getBooleanCellValue());
				default:
					strExcelCell = "";
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return strExcelCell;
	}

	public String parseFormula(String pPOIFormula) {
		final String cstReplaceString = "ATTR(semiVolatile)"; //$NON-NLS-1$
		StringBuffer result = null;
		int index;
		result = new StringBuffer();
		index = pPOIFormula.indexOf(cstReplaceString);
		if (index >= 0) {
			result.append(pPOIFormula.substring(0, index));
			result.append(pPOIFormula.substring(index
					+ cstReplaceString.length()));
		} else {
			result.append(pPOIFormula);
		}
		return result.toString();
	}

	public static void main(String args[]) {
		File file = new File("e:\\work\\n.xls");
		ExcelReader readExcel = new ExcelReader(file);
		try {
			readExcel.open();
		} catch (IOException e) {
			e.printStackTrace();
		}
		readExcel.setSheetNum(0); // 设置读取索引为0的工作表
		// 总行数
		int count = readExcel.getRowCount();
		String[] header = new String[] { "材料编码", "材料名称", "规格型号", "单位", "客户价",
				"单重", "设计", "损耗率", "实际用量", "合计", "合重" };
		int m = header.length;
		int[] n = new int[7];
		String flag = "0";
		String[] rows = readExcel.readExcelLine(2);
		int i = 1;
			for (i = 1; i <= count; i++) {
				rows = readExcel.readExcelLine(i);
				for (int j = 0; j < n.length; j++) {
						System.out.print(rows[j] + " ");
						
				}

					System.out.print("\n");
			}
		System.out.println(i+"");
		// for (int i = 3; i <= count; i++) {
		// String[] rows = readExcel.readExcelLine(i);
		// if (!rows[0].replaceAll(" ", "").equals("")) {
		// for (int j = 0; j < rows.length; j++) {
		// System.out.print(rows[j]+"*"+j+" ");
		// }
		// } else {
		// if(rows[1].replaceAll(" ", "").equals("运输量合计")){
		// yslhj = rows[15];
		// }
		// if(rows[1].replaceAll(" ", "").equals("材料合计")){
		// clhj = rows[14];
		// }
		// if(rows[1].replaceAll(" ", "").equals("普通设备合计")){
		// ptsbhj = rows[14];
		// }
		// if(rows[1].replaceAll(" ", "").equals("主设备合计")){
		// zsbhj = rows[14];
		// }
		// if(rows[1].replaceAll(" ", "").equals("合计")){
		// hj = rows[14];
		// }
		// if(rows[1].replaceAll(" ", "").equals("")){
		// break;
		// }
		// }
		// System.out.print("\n");
		// }
	}
}
