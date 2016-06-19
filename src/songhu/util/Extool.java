package songhu.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.File;

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
	
	public static String testtest(String a,int b){
		String r= Tools.getTextFromHtml(a,b);
		return r.replace("\n", "").replace("\r", "").replace("'", "\\'");
	}
	
	public static boolean mkDir(String path){
		File file = null;
		try{
			file = new File(path);
			if(!file.exists()){
				return file.mkdirs();
			}
		}catch(RuntimeException e){
			e.printStackTrace();
		}finally{
			file = null;
		}
		return false;
	}
	
	public static void main(String[] args){
		try{
			java.sql.Date date=new java.sql.Date(new java.util.Date().getTime()); 
			System.out.println(date);
		}catch(Exception e){
			
		}
	}
}
