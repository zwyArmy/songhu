package songhu.util;

import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

public class TestPost {
	public static String getHtmlContent(URL url, String encode) {
		StringBuffer contentBuffer = new StringBuffer();
		int responseCode = -1;
		HttpURLConnection con = null;
		try {
			con = (HttpURLConnection) url.openConnection();
			con.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");// IE代理进行下载
			con.setConnectTimeout(60000);
			con.setReadTimeout(60000);
			// 获得网页返回信息码
			try{
			responseCode = con.getResponseCode();
			}catch(Exception e){
				
			}
			if (responseCode == -1) {
			//	System.out.println(url.toString() + " : connection is failure...");
				con.disconnect();
				return null;
			}
			if (responseCode >= 400) // 请求失败
			{
				System.out.println("请求失败:get response code: " + responseCode);
				con.disconnect();
				return null;
			}

			InputStream inStr = con.getInputStream();
			InputStreamReader istreamReader = new InputStreamReader(inStr, encode);
			BufferedReader buffStr = new BufferedReader(istreamReader);

			String str = null;
			while ((str = buffStr.readLine()) != null)
				contentBuffer.append(str);
			inStr.close();
		} catch (IOException e) {
			e.printStackTrace();
			contentBuffer = null;
			System.out.println("error: " + url.toString());
		} finally {
			con.disconnect();
		}
		return contentBuffer.toString();
	}

	public static String getHtmlContent(String url, String encode) {
		if (!url.toLowerCase().startsWith("http://")) {
			url = "http://" + url;
		}
		try {
			URL rUrl = new URL(url);
			return getHtmlContent(rUrl, encode);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static String subString(String s, String sb, String se) {
		String tmp = s.substring(s.indexOf(sb));
		return tmp.substring(0,tmp.indexOf(se));
	}
	
	public static void appendFile(String fileName, String content) {
		try {
			// 打开一个写文件器，构造函数中的第二个参数true表示以追加形式写文件
			FileWriter writer = new FileWriter(fileName, true);
			writer.write(content);
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 获取文章内容
	 * @param url 路径
	 * @param encode 编码
	 * @param sf 截取开始标志
	 * @param ef 截取结束标志
	 * @return
	 */
	public static String getText(String url, String encode, String sf, String ef){
		String s = getHtmlContent(url, encode);
		s = subString(s, sf, ef);
		s = s.substring(sf.length());
		//去掉页面上看不到的字符
		//s = s.replaceAll("\\s", "");
		//去除<a>,<img>
		s = s.replaceAll("<a[^>]*>", "");	
		s = s.replaceAll("</a>", "");	
		s = s.replaceAll("<span[^>]*>", "");
		s = s.replaceAll("</span>", "");		
		s = s.replaceAll("<div[^>]*>", "");	
		s = s.replaceAll("</div>", "");			
		//s = s.replaceAll("<img[^>]*/>", " ");
		return s;
	}
	
	/**
	 * 获取文章内容
	 * @param url 路径
	 * @param encode 编码
	 * @param sf 截取开始标志
	 * @param ef 截取结束标志
	 * @param sf1 第二个截取开始标志
	 * @param ef1 第二个截取结束标志
	 * @return
	 */
	public static String getText(String url, String encode, String sf, String ef, String sf1, String ef1){
		String s = getHtmlContent(url, encode);
		if(s.indexOf(sf)>-1){
			s = subString(s, sf, ef);
			s = s.substring(sf.length());
		}else if(s.indexOf(sf1)>-1){
			s = subString(s, sf1, ef1);
			s = s.substring(sf1.length());
		}else{
			return null;
		}
		//去掉页面上看不到的字符
		s = s.replaceAll("\\s", "");
		//去除<a>,<img>
		s = s.replaceAll("<a[^>]*>", "");		
		s = s.replaceAll("</a>", "");		
		s = s.replaceAll("<span[^>]*>", "");
		s = s.replaceAll("</span>", "");	
		s = s.replaceAll("<div[^>]*>", "");	
		s = s.replaceAll("</div>", "");			
		s = s.replaceAll("<img[^>]*/>", " ");
		return s;
	}
	/**
	 * 获取栏目列表的href
	 * @param url
	 * @param encode
	 * @param sf
	 * @param ef
	 * @param sa <a>开始
	 * @param ea <a>结束
	 * @return
	 */
	public static List<String> getList(String url, String encode, String sf, String ef, String sa, String ea){
		String s = getHtmlContent(url, encode) ;
		s = subString(s, sf, ef);
		List<String> list = new ArrayList<String>();
		while(s.indexOf(sa)>-1){
			String s1 = s.substring(s.indexOf(sa)+sa.length());	
			String href = s1.substring(0,s1.indexOf(ea));
			list.add(href);
			s = s1.substring(s1.indexOf(ea)+ea.length());
		}
		return list;
	}
	public static String sendMsg(String articleId){
		List<String> list2 =  Crawlers.getList("http://www.waqiang.com/index.php/url/shorten?url=http://www.qzjrfw.com/m/"+articleId+".html","utf-8","<div id=\"warp\">", "<div id=\"footer\">","<input name=\"url\" id=\"url\" type=\"text\" class=\"input\" readonly=\"readonly\" value=\"", "\" />");
		return list2.get(0);
	}
	public static void main(String[] args){
		List<String> list2 =  Crawlers.getList("http://www.waqiang.com/index.php/url/shorten?url=http://www.qzjrfw.com/b15657.html","utf-8","<div id=\"warp\">", "<div id=\"footer\">","<input name=\"url\" id=\"url\" type=\"text\" class=\"input\" readonly=\"readonly\" value=\"", "\" />");
		System.out.println(list2.get(0));
	}
}
