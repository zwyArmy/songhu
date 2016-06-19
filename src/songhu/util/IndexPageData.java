package songhu.util;

import java.util.List;

import songhu.common.pojo.Article;

public class IndexPageData {

	private static String substring(String str, int length) {
		if (str == null || str.equals(""))
			return "";
		if (str.length() <= length)
			return str;
		return str.substring(0, length) + "...";
	}

	// 文章内容
	public static String getwznr(String id, int ttlength, int ttlength2, int size, Boolean showrq, songhu.common.bean.ArticleBean com) {
		if (id == null || id.equals(""))
			return "";
		List<Article> lista = com.listByColumnId(id, size+1);
		if (lista == null || lista.size() == 0)
			return "";
		java.text.DateFormat format2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
		// StringBuilder sb=new StringBuilder("Unicode");
		Article top = lista.get(0);
		String dt = top.getSummary();
		String str = "";
		String artTitle=top.getTitle();
		if (top.getTitle()!=null && top.getTitle().length()>19) {
			artTitle=top.getTitle().substring(0, 19)+"...";
		}
		str += "<div class=\"mk122\"><h1><a onclick=\"myopen('" + top.getId() + ".html')\" class=\"title cli\">" + artTitle + "</a></h1><p style=\"margin-top: 5px; margin-bottom: 8px\"><a class=\"b1\">" + (format2.format(top.getPublishTime())) + "</a></p><p><a class=\"b1\">";
		str += substring(dt, ttlength);
		str += "</a><a onclick=\"myopen('" + top.getId() + ".html')\" class=\"b1 cli\" style=\"color: #db0000;\">[详细]</a></p></div>";
		str += "<div class=\"xx1\"></div><div class=\"mk123\"><ul>";
		for (int i = 1; i < lista.size(); i++) {
			Article top2 = lista.get(i);
			String ss = top2.getTitle();

			str += "<li class='" + (i % 2 == 0 ? "e" : "f") + "'><a onclick=\"myopen('" + top2.getId() + ".html')\" class=\"b1 cli\">•&nbsp;" + substring(ss, ttlength2) + "</a>" + (showrq ? "<a class='b1 d'>[" + format2.format(top2.getPublishTime()) + "]</a>" : "") + "</li>";
		}
		str += "</ul></div><div class=\"xx2\"></div>";

		String res = "";

		try {
			res = Base64.encode(str, "UTF-16LE");
		} catch (Exception e) {
			e.printStackTrace();
			try {
				res = Base64.encode("转码出现错误", "UTF-16LE");
			} catch (Exception e1) {
			}
		}

		return res;
	}

}
