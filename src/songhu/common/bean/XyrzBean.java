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
import songhu.common.pojo.Xyrz;
import songhu.common.service.ArticleService;
import songhu.common.service.XyrzService;

public class XyrzBean {
	private static XyrzService xyrzService;

	public XyrzBean() {
		super( );
		if(xyrzService == null)
			xyrzService = (XyrzService)BeanFactoryUtil.getBean("xyrzService");
	}
	public List<Xyrz> findByTypeList(String type,int limit){
		try {	
			List<Xyrz> list =  xyrzService.findByTypeList(type, limit);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	

	/*public List<XyrzBean> listByType(String typeId, int limit) {
		try {	
			String cid = "'"+typeId.replaceAll(",", "','")+"'";
			QMap map = new QMap("typeId", cid);
			RowSelection row = new RowSelection();
			row.setFirstRow(0);
			row.setFetchSize(limit);
			List<XyrzBean> list = xyrzService.findByType(cid, row);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}*/
	
}