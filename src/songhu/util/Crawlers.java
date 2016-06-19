package songhu.util;

import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import cpdetector.io.HTMLCodepageDetector;
import cpdetector.io.JChardetFacade; 
import cpdetector.io.CodepageDetectorProxy;


public class Crawlers {
	/*HZF*/
	 private static CodepageDetectorProxy detector = CodepageDetectorProxy  
		    .getInstance();  
		static {  
		
		detector.add(new HTMLCodepageDetector(false));  
		
		detector.add(JChardetFacade.getInstance());  
		
		}  
	    public static String getCharset(String strurl) throws IOException {   
	        URL url = new URL(strurl);    
	        HttpURLConnection urlConnection = (HttpURLConnection) url  
	                .openConnection();  
	        ;  
	        urlConnection.connect();  
	        String strencoding = null; 
	        Map<String, List<String>> map = urlConnection.getHeaderFields();  
	        Set<String> keys = map.keySet();  
	        Iterator<String> iterator = keys.iterator();  
	        String key = null;  
	        String tmp = null;  
	        while (iterator.hasNext()) {  
	            key = iterator.next();  
	            tmp = map.get(key).toString().toLowerCase();  
	            if (key != null && key.equals("Content-Type")) {  
	                int m = tmp.indexOf("charset=");  
	                if (m != -1) {  
	                    strencoding = tmp.substring(m + 8).replace("]", "");  
	                    return strencoding;  
	                }  
	            }  
	        } 
	        StringBuffer sb = new StringBuffer();  
	        String line;  
	        try {  
	            BufferedReader in = new BufferedReader(new InputStreamReader(url  
	                    .openStream()));  
	            while ((line = in.readLine()) != null) {  
	                sb.append(line);  
	            }  
	            in.close();  
	        } catch (Exception e) { 
	          //  System.err.println(e);  
	            //System.err  
	              //      .println("Usage:   java   HttpClient   <URL>   [<filename>]");  
	        }  
	        String htmlcode = sb.toString(); 
	        String strbegin = "<meta";  
	        String strend = ">";  
	        String strtmp;  
	        int begin = htmlcode.indexOf(strbegin);  
	        int end = -1;  
	        int inttmp;  
	        while (begin > -1) {  
	            end = htmlcode.substring(begin).indexOf(strend);  
	            if (begin > -1 && end > -1) {  
	                strtmp = htmlcode.substring(begin, begin + end).toLowerCase();  
	                inttmp = strtmp.indexOf("charset");  
	                if (inttmp > -1) {  
	                    strencoding = strtmp.substring(inttmp + 7, end).replace(  
	                            "=", "").replace("/", "").replace("\"", "")  
	                            .replace("\'", "").replace(" ", "");  
	                    return strencoding;  
	                }  
	            }  
	            htmlcode = htmlcode.substring(begin);  
	            begin = htmlcode.indexOf(strbegin);  
	        }  
	        strencoding = getFileEncoding(url);  
	  
	        if (strencoding == null) {  
	            strencoding = "GBK";  
	        }  
//	  
	        return strencoding;  
	    }  
	    public static String getFileEncoding(URL url) {  
	  
	        java.nio.charset.Charset charset = null;  
	        try {  
	  
	            charset = detector.detectCodepage(url);  
	  
	        } catch (Exception e) {  
	  
	            //System.out.println(e.getClass() + "分析" + "编码失败");  
	  
	        }  
	  
	        if (charset != null)  
	  
	            return charset.name();  
	  
	       return null;  
	  
	    }  /*HZF*/
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

	public static void main(String[] args){
		//List<String> list2 = Crawlers.getList("http://www.qzlc.net/node_6219.htm","utf-8","<Font class=\"black1\">泉州财经</Font>", "<a href=node_6219_2.htm class = \"word06\">","<a href=", " target=\"_blank\" class=heise14>");
		List<String> list2 =  Crawlers.getList("http://finance.sina.com.cn/stock/","utf-8","<!--headline start-->", "<!--headline end-->","<a href=\"", "\" target=_blank>");
		 HashSet hs = new HashSet(list2); 
		 Iterator j = hs.iterator();
		 ArrayList<String> list = new ArrayList();
		 while(j.hasNext()){
			 Object temp2 = j.next();
			 list.add(temp2.toString());
		 }
		 for(int k=list.size()-1;k>-1;k--){
			 try{
            	 String WebEncoding = getCharset(list.get(k));
 				//String title = Crawlers.getText(list.get(k),WebEncoding,"<title>","</title>").split("\\|")[0];
 				// String content = Crawlers.getText(list.get(k),WebEncoding,"<!-- 正文内容 begin -->","<!-- publish_helper_end -->");
 				//System.out.println(content.replaceAll("  ", ""));
 				 //System.out.println(title.replaceAll("  ", ""));
             }catch(Exception e){
            	 
             }
		 }
		 //去重示例
//		 while(j.hasNext()){  
//             Object temp = j.next(); 
//            // System.out.println(temp.toString());  
//             try{
//            	 String WebEncoding = getCharset(temp.toString());
// 				String title = Crawlers.getText(temp.toString(),WebEncoding,"<title>","</title>").split("\\|")[0];
// 				 String content = Crawlers.getText(temp.toString(),WebEncoding,"<!-- 正文内容 begin -->","<!-- publish_helper_end -->");
// 				System.out.println(content.replaceAll("  ", ""));
// 				 //System.out.println(title.replaceAll("  ", ""));
//             }catch(Exception e){
//            	 
//             }
//      }  
		for(int i=0;i<list2.size();i++){
			//System.out.println(list2.get(i));
			//String content = Crawlers.getText("http://www.qzlc.net/"+list2.get(i),"utf-8","<span class=\"songti1\"> <!--enfpcontent-->","<!--/enpcontent-->");
			try{
				//String title = Crawlers.getText(list2.get(i),"gb2312","<title>","</title>").split("\\|")[0];
				String WebEncoding = getCharset(list2.get(i));
				String title = Crawlers.getText(list2.get(i),WebEncoding,"<title>","</title>").split("\\|")[0];
				 String content = Crawlers.getText(list2.get(i),Crawlers.getCharset(list2.get(i)),"<!--单图 end-->","<!-- publish_helper_end -->");
			System.out.println(content.replaceAll("  ", ""));
			//System.out.println(title.replaceAll("  ", ""));
			//	System.out.println(WebEncoding);
			}catch(Exception e){
				//  e.printStackTrace();
			}
		}
	}
	
}
