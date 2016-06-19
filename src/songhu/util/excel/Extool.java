package songhu.util.excel;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.htmlparser.Node;
import org.htmlparser.NodeFilter;
import org.htmlparser.Parser;
import org.htmlparser.filters.TagNameFilter;
import org.htmlparser.tags.ImageTag;
import org.htmlparser.util.NodeList;
import org.htmlparser.util.ParserException;

import com.weixin.core.util.Tools;

public class Extool {
	/**
	 * 获得请求路径
	 * 
	 * @param request
	 * @return
	 */
	public static String getRequestPath(HttpServletRequest request) {
		String requestPath = request.getRequestURI() + "?" + request.getQueryString();
		if (requestPath.indexOf("&") > -1) {// 去掉其他参数
			requestPath = requestPath.substring(0, requestPath.indexOf("&"));
		}
		requestPath = requestPath.substring(request.getContextPath().length() + 1);// 去掉项目路径
		return requestPath;
	}
	
	public static String getRandName(){
		Date dt = new Date(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		return sdf.format(dt);
	}
	/**
	 * 获取第一张图片地址
	 * @param txt
	 * @return
	 * @throws ParserException
	 */
	public static String getImageURL(String txt) throws ParserException {
		String img = null;
		Parser parser;
		NodeFilter filter = new TagNameFilter("img");
		parser = Parser.createParser(txt, "GB2312");
		NodeList nodelist = parser.parse(filter);
		if (nodelist.size() != 0) {
			Node[] nodes = nodelist.toNodeArray();
			ImageTag image = (ImageTag) nodes[0];
			img = image.getImageURL().toString();
			/*for (int i = 0; i < nodes.length; i++) {
				ImageTag image = (ImageTag) nodes[i];
				if ("".equals(img)) {
					img = image.getImageURL().toString();
				} else {
					img = img + "," + image.getImageURL().toString();
				}
			}*/
		}
		return img;
	}

	/**
	 * 删除文件
	 * 
	 * @param filePathAndName
	 *            String 文件路径及名称 如c:/fqf.txt
	 * @param fileContent
	 *            String
	 * @return boolean
	 */
	public static boolean delFile(String filePathAndName) {
		File myDelFile = new java.io.File(filePathAndName);
		if (!myDelFile.exists()) {
			return true;
		}
		return myDelFile.delete();
	}
	public static String testtest(String a,int b){
		String r= Tools.getTextFromHtml(a,b);
		return r.replace("\n", "").replace("\r", "").replace("'", "\\'");
	}
	
	/**
	 * 删除指定文件路径下面的所有文件和文件夹
	 * 
	 * @param file
	 */
	public static boolean delFiles(File file) {
		boolean flag = false;
		try {
			if (file.exists()) {
				if (file.isDirectory()) {
					String[] contents = file.list();
					for (int i = 0; i < contents.length; i++) {
						File file2X = new File(file.getAbsolutePath() + "/" + contents[i]);
						if (file2X.exists()) {
							if (file2X.isFile()) {
								flag = file2X.delete();
							} else if (file2X.isDirectory()) {
								delFiles(file2X);
							}
						} else {
							throw new RuntimeException("File not exist!");
						}
					}
				}
				flag = file.delete();
			} else {
				throw new RuntimeException("File not exist!");
			}
		} catch (Exception e) {
			flag = false;
			e.printStackTrace();
		}
		return flag;
	}
	
	/**
	 * 根据路径创建一系列的目录
	 * 
	 * @param path
	 */
	public static boolean mkDir(String path) {
		File file = null;
		try {
			file = new File(path);
			if (!file.exists()) {
				return file.mkdirs();
			}
		} catch (RuntimeException e) {
			e.printStackTrace();
		} finally {
			file = null;
		}
		return false;
	}
	
	/*******************************************************************************
	   把是str=null代替成空格
	*******************************************************************************/
	  public static String Checknull(String Str, String rpt) {
	    if (Str == null || Str.equals("null") || Str.equals("") || Str.trim() == null ||
	        Str.trim().equals("")) {
	      return rpt;
	    }
	    else {
	      return Str;
	    }
	  }

	  public static String Checknull(String Str) {
	    return Checknull(Str, "");
	  }

	  public static String Repnull(String Str) {
	    return Checknull(Str, "&nbsp;");
	  }
	
	public static void main(String[] args){
		try{
		System.out.println(getImageURL("<img alt='' style='width: 480px; height: 307px;' data-cke-saved-src='/excms/userfiles/images/thumb_480_320_1339409931903.jpg' src='/excms/userfiles/images/thumb_480_320_1339409931903.jpg'>"));
		}catch(Exception e){
			
		}
	}
}
