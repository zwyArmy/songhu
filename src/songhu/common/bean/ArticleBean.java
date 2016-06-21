package songhu.common.bean;

import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import jodd.util.StringUtil;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleFragmenter;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.LockObtainFailedException;
import org.apache.lucene.util.Version;
import org.wltea.analyzer.lucene.IKAnalyzer;

import com.weixin.core.constant.Global;
import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.spring.BeanFactoryUtil;
import com.weixin.core.util.DateUtils;
import com.weixin.core.util.QMap;

import songhu.common.pojo.Appendix;
import songhu.common.pojo.Article;
import songhu.common.pojo.Column;
import songhu.common.pojo.Crumb;
import songhu.common.pojo.SearchResult;
import songhu.common.service.ArticleService;

public class ArticleBean {
	private static ArticleService articleService;

	public ArticleBean() {
		super();
		if(articleService == null)
			articleService = (ArticleService)BeanFactoryUtil.getBean("articleService");
	}


	public List<Article> listByColumnId(String columnId, int limit) {
		try {	
			String cid = "'"+columnId.replaceAll(",", "','")+"'";
			QMap map = new QMap("columnId", cid);
			RowSelection row = new RowSelection();
			row.setFirstRow(0);
			row.setFetchSize(limit);
			List<Article> list = articleService.findByColumnId(map, row);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Article> listByColumnId2(String columnId, int limit) {
		try {	
			String cid = "'"+columnId.replaceAll(",", "','")+"'";
			QMap map = new QMap("columnId", cid);
			RowSelection row = new RowSelection();
			row.setFirstRow(0);
			row.setFetchSize(limit);
			List<Article> list = articleService.findByColumnId2(map, row);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Article> listByHot(String articleId, int limit) {
		try {			
			QMap map = new QMap("id", articleId);
			RowSelection row = new RowSelection();
			row.setFirstRow(0);
			row.setFetchSize(limit);
			List<Article> list = articleService.findByHot(map, row);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Article> listMore(String articleId, int limit) {
		try {			
			QMap map = new QMap("id", articleId);
			RowSelection row = new RowSelection();
			row.setFirstRow(0);
			row.setFetchSize(limit);
			List<Article> list = articleService.listMore(articleId, row);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Article> listByColumnId(String columnId, int start, int limit) {
		try {	
			String cid = "'"+columnId.replaceAll(",", "','")+"'";			
			QMap map = new QMap("columnId", cid);
			RowSelection row = new RowSelection();
			row.setFirstRow(start);
			row.setFetchSize(limit);			
			List<Article> list = articleService.findByPaging(map, row);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public Article getByArticleId(String id) throws Exception {
		Article article =  articleService.getById(id);
		return article;
	}

	public int countByColumnId(String columnId) throws Exception {
		int c =  articleService.countByColumnId(columnId);
		return c;
	}
	
	public void countArticle(String articleId, int views) throws Exception {
		Article a = new Article();
		a.setId(articleId);
		a.setViews(views+1);
		articleService.updateBLOBs(a);
	}
	
	public Crumb getCrumb(String articleId) throws Exception {
		return articleService.getCrumb(articleId);
	}
	
	public List<Column> listColumnByParent(String parentId) {
		try{
			return articleService.listColumnByParent(parentId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public SearchResult Search(String wd, int start, int limit) throws Exception {
		wd = java.net.URLDecoder.decode(wd,"utf-8");
		String[] field = new String[]{"title","content","author"};
		IndexReader reader = null;
		IndexSearcher searcher = null;
		SearchResult sr = new SearchResult();
        ArrayList<Article> list = new ArrayList<Article>();
		try {
			reader = IndexReader.open(FSDirectory.open(new File(Global.INDEX_PATH)));
			searcher = new IndexSearcher(reader);
			Analyzer analyzer = new IKAnalyzer();
			//QueryParser parser = new QueryParser(Version.LUCENE_36, field, analyzer);
			
			MultiFieldQueryParser multiParser= new MultiFieldQueryParser(Version.LUCENE_36 ,field,analyzer);
			multiParser.setPhraseSlop(3);
			
			Query query = multiParser.parse(wd);
			System.out.println("Searching for: " + query.toString());
			// 搜索相似度最高的5条记录
			Date begin = new Date();
			TopDocs topDocs = searcher.search(query, start + limit);
			// 输出结果
			ScoreDoc[] scoreDocs = topDocs.scoreDocs; 
	        SimpleHTMLFormatter simpleHtmlFormatter = new SimpleHTMLFormatter("<FONT COLOR=RED>","</FONT>");//设定高亮显示的格式，也就是对高亮显示的词组加上前缀后缀   
	        Highlighter highlighter = new Highlighter(simpleHtmlFormatter,new QueryScorer(query));   
	        highlighter.setTextFragmenter(new SimpleFragmenter(150));//设置每次返回的字符数.想必大家在使用搜索引擎的时候也没有一并把全部数据展示出来吧，当然这里也是设定只展示部分数据
	        
	        int numTotalHits=topDocs.totalHits;
	        int end = Math.min(numTotalHits, start + limit); 
			for (int i = start; i < end; i++) {
				Document targetDoc = searcher.doc(scoreDocs[i].doc);
				String content = targetDoc.get("content");
				TokenStream tokenStream = analyzer.tokenStream("",new StringReader(content));
				content = highlighter.getBestFragment(tokenStream, content);
				String id = targetDoc.get("id");
				String author = targetDoc.get("author");
				String columnId = targetDoc.get("columnId");
				String title = targetDoc.get("title");
				if(title.length()>28){
					title = title.substring(0, 28)+"...";
				}
				Date publishTime = DateUtils.str2Date(targetDoc.get("publishTime"), DateUtils.yyyymmddhhmmss) ;
				if(StringUtil.isEmpty(content)){
					content = articleService.getById(id).getSummary();
				}
				Article a = new Article();
				a.setId(id);
				a.setAuthor(author);
				a.setColumnId(columnId);
				a.setTitle(title);
				a.setContent(content);
				a.setPublishTime(publishTime);
				list.add(a);
			}			
			Date ended = new Date();
			System.out.println("使用：" + (ended.getTime() - begin.getTime())
					+ "毫秒, 命中：" + topDocs.totalHits);

			sr.setList(list);
			sr.setTotalHits(topDocs.totalHits);
			sr.setUsedtime(ended.getTime() - begin.getTime());
			reader.close();
		} catch (CorruptIndexException e) {
			e.printStackTrace();
		} catch (LockObtainFailedException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return sr;
	}
	public List<Appendix> listAppendix(String articleId) throws Exception{
		try{			
			List<Appendix> list = articleService.listPath3(articleId);
			return list;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * <h1>自动增加30分钟的日期时间格式化</h1>
	 * 例：传入时间为2012-11-4 11:20:00<br>
	 * 格式化为：2012年11月4日上午11:20—11:50
	 * @param date
	 * @return
	 */
	public String formatDate(Date date) {
		//Initialize
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月d日aHH:mm");
		StringBuffer sb = new StringBuffer(sdf.format(date));
		
		//第一部分格式化
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		
		sb.append("—");
		
		//第二部分格式化
		calendar.add(Calendar.MINUTE, 30);
		sdf = new SimpleDateFormat("HH:mm");
		sb.append(sdf.format(new Date(calendar.getTimeInMillis())));
		return sb.toString();
	}
	
	public SearchResult verticalSearch(String wd, int start, int limit, String columnId) throws Exception {
		wd = java.net.URLDecoder.decode(wd,"utf-8");
		Calendar begin = Calendar.getInstance();
		SearchResult sr = new SearchResult();
		
		//参数处理
		List<String> param = new ArrayList<String>();
		if(wd.contains(" ")) { //包含多个关键字
			String[] wds = wd.split(" ");
			for(int i = 0; i < wds.length; i++) {
				param.add(wds[i]);
			}
		}
		else {
			param.add(wd);
		}
		
		//开始搜索
        List<Article> list = articleService.findByVertical(param, start, limit, columnId);
        int count = articleService.countByVertical(param, columnId);
        Calendar ended = Calendar.getInstance();
        
        sr.setList(list);
		sr.setTotalHits(count);
		sr.setUsedtime(ended.getTimeInMillis() - begin.getTimeInMillis());
		
        return sr;
	}
}