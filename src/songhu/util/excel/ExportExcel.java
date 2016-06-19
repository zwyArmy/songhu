package songhu.util.excel;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class ExportExcel<T> {

	public String GridToExcel(List<T> list,String[] header,String[] fields, String expFile) {
		File f = new File(expFile);
		ExcelWriter ew = new ExcelWriter();
		try {
			ew = new ExcelWriter(new FileOutputStream(f));
			ew.setCellStyle();
			ew.createRow(0);
			for(int k=0;k<header.length;k++){
				ew.setCell(k, header[k], ew.DefaultCellStyle, true);
			}
			
			for (int i = 0, len = list.size(); i < len; i++) {
				ew.createRow(i+1);
				Object model = list.get(i);
				//Field[] field = model.getClass().getDeclaredFields();
				for (int j = 0, len1 = fields.length; j < len1; j++) {
					String name = fields[j];
					Field field = model.getClass().getDeclaredField(name);
					String type = field.getGenericType().toString(); // 获取属性的类型
					if (type.equals("class java.lang.String")) { // 如果type是类类型，则前面包含"class
																	// "，后面跟类名
						Method m = model.getClass().getMethod("get" + UpperFirst(name));
						String value = (String) m.invoke(model); // 调用getter方法获取属性值
						if (value != null) {
							ew.setCell(j, value, ew.DefaultCellStyle, true);
						}
					}
					if (type.equals("class java.lang.Integer")) {
						Method m = model.getClass().getMethod("get" + name);
						Integer value = (Integer) m.invoke(model);
						if (value != null) {
							ew.setCell(j, value, ew.DefaultCellStyle, true);
						}
					}
					if (type.equals("class java.lang.Short")) {
						Method m = model.getClass().getMethod("get" + name);
						Short value = (Short) m.invoke(model);
						if (value != null) {
							ew.setCell(j, value, ew.DefaultCellStyle, true);
						}
					}
					if (type.equals("class java.lang.Double")) {
						Method m = model.getClass().getMethod("get" + name);
						Double value = (Double) m.invoke(model);
						if (value != null) {
							ew.setCell(j, value, true);
						}
					}
					if (type.equals("java.math.BigDecimal")) {
						Method m = model.getClass().getMethod("get" + name);
						BigDecimal value = (BigDecimal) m.invoke(model);
						if (value != null) {
							ew.setCell(j, value.doubleValue(), true);
						}
					}
					if (type.equals("class java.util.Date")) {
						Method m = model.getClass().getMethod("get" + name);
						Date value = (Date) m.invoke(model);
						if (value != null) {
							Calendar cal = Calendar.getInstance();
							cal.setTime(value);
							ew.setCell(j, cal, true);
						}
					}

				}
			}			
			ew.export();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String GridToExcel3(List<List<String>> list,
			List<List<ExcelHeader>> header, String expFile) {
		BufferedWriter bw = null;
		try {
			bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(expFile),"GBK"));

			bw
					.write("<html xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:x=\"urn:schemas-microsoft-com:office:excel\" xmlns=\"http://www.w3.org/TR/REC-html40\">\n<head>\n<meta http-equiv=Content-Type content=\"text/html; charset=gb2312\">\n<meta name=ProgId content=Excel.Sheet>\n<meta name=Generator content=\"Microsoft Excel 11\">\n<style>\n<!--table{mso-displayed-decimal-separator:\"\\.\";\nmso-displayed-thousand-separator:\"\\,\";}\n@page\n	{margin:1.0in .75in 1.0in .75in;\n	mso-header-margin:.5in;\n	mso-footer-margin:.5in;}\n.font0\n	{color:windowtext;\n	font-size:10.0pt;\n	font-weight:400;\n	font-style:normal;\n	text-decoration:none;\n	font-family:Arial, sans-serif;\n	mso-font-charset:0;}\ntr\n	{mso-height-source:auto;\n	mso-ruby-visibility:none;}\ncol\n	{mso-width-source:auto;\n	mso-ruby-visibility:none;}\nbr\n	{mso-data-placement:same-cell;}\n.style0\n	{mso-number-format:General;\n	text-align:general;\n	vertical-align:bottom;\n	white-space:nowrap;\n	mso-rotate:0;\n	mso-background-source:auto;\n	mso-pattern:auto;\n	color:windowtext;\n	font-size:10.0pt;\n	font-weight:400;\n	font-style:normal;\n	text-decoration:none;\n	font-family:Arial, sans-serif;\n	mso-font-charset:0;\n	border:none;\n	mso-protection:locked visible;\n	mso-style-name:常规;\n	mso-style-id:0;}\ntd\n	{mso-style-parent:style0;\n	padding-top:1px;\n	padding-right:1px;\n	padding-left:1px;\n	mso-ignore:padding;\n	color:windowtext;\n	font-size:10.0pt;\n	font-weight:400;\n	font-style:normal;\n	text-decoration:none;\n	font-family:Arial, sans-serif;\n	mso-font-charset:0;\n	mso-number-format:General;\n	text-align:general;\n	vertical-align:bottom;\n	border:none;\n	mso-background-source:auto;\n	mso-pattern:auto;\n	mso-protection:locked visible;\n	white-space:nowrap;\n	mso-rotate:0;}\n.xl25\n	{mso-style-parent:style0;\n	font-family:宋体;\n	mso-generic-font-family:auto;\n	mso-font-charset:134;\n	text-align:center;}\nruby\n	{ruby-align:left;}\nrt\n	{color:windowtext;\n	font-size:9.0pt;\n	font-weight:400;\n	font-style:normal;\n	text-decoration:none;\n	font-family:宋体;\n	mso-generic-font-family:auto;\n	mso-font-charset:134;\n	mso-char-type:none;\n	display:none;}\n-->\n</style>\n<!--[if gte mso 9]><xml>\n <x:ExcelWorkbook>\n  <x:ExcelWorksheets>\n   <x:ExcelWorksheet>\n    <x:Name>Sheet0</x:Name>\n    <x:WorksheetOptions>\n     <x:Print>\n      <x:ValidPrinterInfo/>\n      <x:HorizontalResolution>300</x:HorizontalResolution>\n      <x:VerticalResolution>300</x:VerticalResolution>\n      <x:NumberofCopies>0</x:NumberofCopies>\n     </x:Print>\n     <x:Selected/>\n     <x:Panes>\n      <x:Pane>\n       <x:Number>3</x:Number>\n       <x:ActiveRow>5</x:ActiveRow>\n       <x:ActiveCol>3</x:ActiveCol>\n      </x:Pane>\n     </x:Panes>\n     <x:ProtectContents>False</x:ProtectContents>\n     <x:ProtectObjects>False</x:ProtectObjects>\n     <x:ProtectScenarios>False</x:ProtectScenarios>\n    </x:WorksheetOptions>\n   </x:ExcelWorksheet>\n  </x:ExcelWorksheets>\n  <x:ProtectStructure>False</x:ProtectStructure>\n  <x:ProtectWindows>False</x:ProtectWindows>\n </x:ExcelWorkbook>\n</xml><![endif]-->\n</head>\n<body link=blue vlink=purple>\n");
			bw
					.write("<table x:str border=0 cellpadding=0 cellspacing=0 style='border-collapse:collapse;table-layout:fixed;width:"
							+ ((list.size()>0?list.get(0).size():20) * 40) + "pt'>\n");
			if (header != null) {
				for (int n = 0; n < header.size(); n++) {
					List<ExcelHeader> eh = header.get(n);
					bw.write("<tr>\n");
					for (int k = 0, lenk = eh.size(); k < lenk; k++) {
						bw.write("<td colspan=" + eh.get(k).getLength()
								+ " class=xl25>" + eh.get(k).getName()
								+ "</td>\n");
					}
					bw.write("</tr>\n");
				}
			}
			for (int i = 0, len = list.size(); i < len; i++) {
				List<String> Li = list.get(i);
				bw.write("<tr>\n");
				for (int j = 0, lenj = Li.size(); j < lenj; j++) {
					bw.write("<td>"+Li.get(j)+"</td>\n");
				}
				bw.write("</tr>\n");
			}
			bw.write("</table></body></html>");
			bw.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				bw.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public void testReflect(Object model) {
		try {
			Field[] field = model.getClass().getDeclaredFields();
			for (int i = 0, len = field.length; i < len; i++) {
				String name = field[i].getName();
				//System.out.println("Attribute name:" + name);
				String type = field[i].getGenericType().toString(); // 获取属性的类型
				if (type.equals("class java.lang.String")) { // 如果type是类类型，则前面包含"class
																// "，后面跟类名
					Method m = model.getClass().getMethod(
							"get" + UpperFirst(name));
					String value = (String) m.invoke(model); // 调用getter方法获取属性值
					if (value != null) {

						System.out.println("attribute value:" + value);
					}
				}
				if (type.equals("class java.lang.Integer")) {
					Method m = model.getClass().getMethod("get" + name);
					Integer value = (Integer) m.invoke(model);
					if (value != null) {
						System.out.println("attribute value:" + value);
					}
				}
				if (type.equals("class java.lang.Short")) {
					Method m = model.getClass().getMethod("get" + name);
					Short value = (Short) m.invoke(model);
					if (value != null) {
						System.out.println("attribute value:" + value);
					}
				}
				if (type.equals("class java.lang.Double")) {
					Method m = model.getClass().getMethod("get" + name);
					Double value = (Double) m.invoke(model);
					if (value != null) {
						System.out.println("attribute value:" + value);
					}
				}
				if (type.equals("class java.lang.Boolean")) {
					Method m = model.getClass().getMethod("get" + name);
					Boolean value = (Boolean) m.invoke(model);
					if (value != null) {
						System.out.println("attribute value:" + value);
					}
				}
				if (type.equals("class java.util.Date")) {
					Method m = model.getClass().getMethod("get" + name);
					Date value = (Date) m.invoke(model);
					if (value != null) {
						System.out.println("attribute value:"
								+ value.toLocaleString());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String UpperFirst(String s) {
		return s.length() > 0 ? s.substring(0, 1).toUpperCase()
				+ s.substring(1) : "";
	}

	public static void main(String[] args) {
		// com.sui.cgdfx.model.Cgdfx cgdfx = new com.sui.cgdfx.model.Cgdfx();
		// cgdfx.setBd("111111");
		// testReflect(cgdfx);
	}
}
