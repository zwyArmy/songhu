package songhu.util;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.eic.util.excel.ExcelReader;
import com.weixin.core.util.SystemPath;

public class ImpExcel{

	public static ExcelReader impExcel(String[] header2,HttpServletRequest request,String upfile) throws Exception{
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile(upfile);
		String filename = file.getOriginalFilename();
		String path = SystemPath.getSysPath()+ "upfile/tmp/";
		File source = new File(path+filename);
		try{
		file.transferTo(source);
		}catch(Exception e){
			//System.out.println("+++++++"+e.toString());
		}
		ExcelReader readExcel = new ExcelReader(source);
		try {
			readExcel.open();
			readExcel.setSheetNum(0); // 设置读取索引为0的工作表
			String[] header = header2;
			String[] rows = readExcel.readExcelLine(0);
			String[] header1 = new String[header.length];
			System.arraycopy(rows, 0, header1, 0, header.length);
			if (!Arrays.equals(header, header1)) {
				return null;
			}
			return readExcel;
		} catch (IOException e) {
			e.printStackTrace();
		} 
		return null;
	}
	public static String delExcel(HttpServletRequest request,String upfile){
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile(upfile);
		String filename = file.getOriginalFilename();
		String path = SystemPath.getSysPath()+ "upfile/tmp/";
		File source = new File(path+filename);
		source.delete();
		return null;
	}
	public static void main(String[] args){
		
	}
	
}
