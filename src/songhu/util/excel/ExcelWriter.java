package songhu.util.excel;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Calendar;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.hssf.usermodel.HSSFFont;

/**
 * 生成导出Excel文件对象
 * 
 * @author administrator
 * 
 */

public class ExcelWriter {
	// 设置cell编码解决中文高位字节截断
	private static short XLS_ENCODING = HSSFCell.ENCODING_UTF_16;
	// 定制浮点数格式
	private static String NUMBER_FORMAT = "#,##0.00";
	// 定制日期格式
	private static String DATE_FORMAT = "m/d/yy"; // "m/d/yy h:mm"
	private OutputStream out = null;
	private HSSFWorkbook workbook = null;
	private HSSFSheet sheet = null;
	private HSSFRow row = null;
	public HSSFCellStyle DefaultCellStyle = null; //默认字体风格
	public HSSFCellStyle cellStyle = null;        //标题风格 黑体、加粗、居中
	public HSSFCellStyle cellStyle1 = null;       //风格 居中
	

	public ExcelWriter() {
	}
	

	/**
	 * 初始化Excel
	 * 
	 */
	public ExcelWriter(OutputStream out) {
		this.out = out;
		this.workbook = new HSSFWorkbook();
		this.sheet = workbook.createSheet();
	}

	/**
	 * 导出Excel文件
	 * 
	 * @throws IOException
	 */
	public void export() throws FileNotFoundException, IOException {
		try {
			workbook.write(out);
			out.flush();
			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 增加一行
	 * 
	 * @param index
	 *            行号
	 */
	public void createRow(int index) {
		this.row = this.sheet.createRow(index);
	}

	/**
	 * 获取单元格的值
	 * 
	 * @param index
	 *            列号
	 */
	public String getCell(int index) {
		HSSFCell cell = this.row.getCell((short) index);
		String strExcelCell = "";
		if (cell != null) { // add this condition
			// judge
			switch (cell.getCellType()) {
			case HSSFCell.CELL_TYPE_FORMULA:
				strExcelCell = "FORMULA ";
				break;
			case HSSFCell.CELL_TYPE_NUMERIC: {
				strExcelCell = String.valueOf(cell.getNumericCellValue());
			}
				break;
			case HSSFCell.CELL_TYPE_STRING:
				strExcelCell = cell.getStringCellValue();
				break;
			case HSSFCell.CELL_TYPE_BLANK:
				strExcelCell = "";
				break;
			default:
				strExcelCell = "";
				break;
			}
		}
		return strExcelCell;
	}
	
	private void setRegion(int row1, int Column1, int row2, int Column2){
		sheet.addMergedRegion(new Region((short)row1,(short)Column1,(short)row2,(short)Column2));
	}

	/**
	 * 设置单元格
	 * 
	 * @param index
	 *            列号
	 * @param value
	 *            单元格填充值
	 */
	public void setCell(int index, int value, HSSFCellStyle cellStyle, boolean fit) {
		HSSFCell cell = this.row.createCell((short) index);
		cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
		cell.setCellValue(value);
		cell.setCellStyle(cellStyle);
		if (fit) {
			this.sheet.autoSizeColumn((short) index);
		}
	}

	/**
	 * 设置单元格
	 * 
	 * @param index
	 *            列号
	 * @param value
	 *            单元格填充值
	 */
	public void setCell(int index, double value, boolean fit) {
		HSSFCell cell = this.row.createCell((short) index);
		cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
		cell.setCellValue(value);
		HSSFCellStyle cellStyle = workbook.createCellStyle(); // 建立新的cell样式
		HSSFDataFormat format = workbook.createDataFormat();
		cellStyle.setDataFormat(format.getFormat(NUMBER_FORMAT)); // 设置cell样式为定制的浮点数格式
		cell.setCellStyle(cellStyle); // 设置该cell浮点数的显示格式
		if (fit) {
			this.sheet.autoSizeColumn((short) index);
		}
	}

	/**
	 * 设置单元格
	 * 
	 * @param index
	 *            列号
	 * @param value
	 *            单元格填充值
	 */
	public void setCell(int index, String value,HSSFCellStyle cellStyle, boolean fit) {
		HSSFCell cell = this.row.createCell((short) index);
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		//cell.setEncoding(XLS_ENCODING);
		cell.setCellValue(value);
		cell.setCellStyle(cellStyle);
		if (fit) {
			this.sheet.autoSizeColumn((short) index);
		}
	}

	/**
	 * 设置单元格
	 * 
	 * @param index
	 *            列号
	 * @param value
	 *            单元格填充值
	 */
	public void setCell(int index, Calendar value, boolean fit) {
		HSSFCell cell = this.row.createCell((short) index);
		//cell.setEncoding(XLS_ENCODING);
		cell.setCellValue(value.getTime());
		HSSFCellStyle cellStyle = workbook.createCellStyle(); // 建立新的cell样式
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat(DATE_FORMAT)); // 设置cell样式为定制的日期格式
		cell.setCellStyle(cellStyle); // 设置该cell日期的显示格式
		if (fit) {
			this.sheet.autoSizeColumn((short) index);
		}
	}
	
	public void setCellStyle(){
		DefaultCellStyle = workbook.createCellStyle();
		DefaultCellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		DefaultCellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		DefaultCellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		DefaultCellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		
		HSSFFont font = workbook.createFont();   
	    font.setColor(HSSFFont.COLOR_NORMAL);   
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);   
		font.setFontHeightInPoints((short) 14);
		cellStyle = workbook.createCellStyle();   
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle.setFont(font);   
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		
		HSSFFont font1 = workbook.createFont();   
	    font1.setColor(HSSFFont.COLOR_NORMAL);   
		font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);   
		font1.setFontHeightInPoints((short) 8);
		cellStyle1 = workbook.createCellStyle();  
		cellStyle1.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle1.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle1.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle1.setBorderTop(HSSFCellStyle.BORDER_THIN); 
		//cellStyle1.setFont(font1);   
		cellStyle1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	}

	public static void main(String[] args) {
		System.out.println(" 开始导出Excel文件 ");
		File f = new File("e:\\textExcel.xls");
		ExcelWriter e = new ExcelWriter();
		try {
			e = new ExcelWriter(new FileOutputStream(f));
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
		e.setCellStyle();
		 

		//第一行
		e.createRow(0);
        e.setRegion(0, 0, 0, 7);
		e.setCell(0, "晋江市天健有限公司",e.cellStyle, false);
		//第二行
		e.createRow(1);
        e.setRegion(1, 0, 1, 7);
		e.setCell(0, "工程分包施工费用提取计算表",e.cellStyle, false);
		//第三行
		e.createRow(2);
		e.setCell(0, "合同号",e.cellStyle1, false);
		e.setRegion(2, 1, 2, 3);
		e.setCell(1, "",e.cellStyle1, false);
		e.setCell(4, "发票日期 ",e.cellStyle1, true);
		e.setRegion(2, 5, 2, 7);
		e.setCell(5, "2011-07-04",e.cellStyle1, false);
		//第四行
		e.createRow(3);
		e.setCell(0, "工程名称",e.cellStyle1,false);
		e.setRegion(3, 1, 3, 7);
		e.setCell(1, "陈埭区域2010年单相表上线工程（9月份-11月份)", e.cellStyle1, false);
		//第五行
		e.createRow(4);
		e.setCell(0, "施工单位",e.cellStyle1,false);
		e.setRegion(4, 1, 4, 7);
		e.setCell(1, "福建源大电力工程有限公司晋江分公司", e.cellStyle1, false);
		//第六行
		e.createRow(5);
		e.setCell(0, "施工单位",e.cellStyle1,false);
		e.setRegion(4, 1, 4, 7);
		e.setCell(1, "福建源大电力工程有限公司晋江分公司", e.cellStyle1, false);
		try {
			e.export();
			System.out.println(" 导出Excel文件[成功] ");
		} catch (IOException ex) {
			System.out.println(" 导出Excel文件[失败] ");
			ex.printStackTrace();
		}
	}

}
