 package songhu.util.timer;


import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.Term;
import org.apache.lucene.index.FieldInfo.IndexOptions;
import org.apache.lucene.index.IndexWriterConfig.OpenMode;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.wltea.analyzer.lucene.IKAnalyzer;

import com.weixin.core.constant.Global;
import com.weixin.core.util.DateUtils;
import com.weixin.core.util.StringUtil;
import com.weixin.core.util.Tools;

import songhu.common.pojo.Article;
import songhu.common.service.ArticleService;
import songhu.system.service.SettingService;
import songhu.util.Crawlers;

@Component
public class Job {
	private static ArticleService articleService;
	private static SettingService settingService;
	
//	@Scheduled(cron="0/10 * * * * *") 
    public void s10(){
		if(Lock.isLock()){
			System.out.println(DateUtils.getDataString(DateUtils.yyyymmddhhmmss)+"Note: Try to run s10 but system is Locked");
		}
		else{ 
			Lock.setLock(true);
			System.out.println(DateUtils.getDataString(DateUtils.yyyymmddhhmmss)+"Note: Allowed to run s10 and lock it by s10;");
		}
    }

//	@Scheduled(cron="0/10 * * * * *") 
    public void d10(){
		if(Lock.isLock()){
			System.out.println(DateUtils.getDataString(DateUtils.yyyymmddhhmmss)+"Note: Try to run d10 but system is Locked");
		}
		else{ 
			Lock.setLock(true);
			System.out.println(DateUtils.getDataString(DateUtils.yyyymmddhhmmss)+"Note: Allowed to run d10 and lock it by d10;");
		}
    }
//	@Scheduled(cron="0/30 * * * * *") 
    public void m5(){
		Lock.setLock(false);
		System.out.println("******************");
		System.out.println(DateUtils.getDataString(DateUtils.yyyymmddhhmmss)+"Note: System auto to Unlock;");
    }
    /**
     * 每天上午7点执行一次采集
     * */
    @Scheduled(cron="0 10 7 * * ?") 
    public void am710PerDay(){ 
    	Lock.setLock(false);//开锁
    }
    
    @Scheduled(cron="0 12 7 * * ?") 
    public void am712PerDay(){ 
    	//新华08-股票要闻
    	crawler("http://stock.xinhua08.com/zlyj/","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0403","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","am712");
    }
    
    @Scheduled(cron="0 15 7 * * ?") 
    public void am715PerDay(){
    	//新华08-外汇-美联储
    	crawler("http://forex.xinhua08.com/yhdt/mlc/","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0404","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","am715");
    }
    
    @Scheduled(cron="0 18 7 * * ?") 
    public void am718PerDay(){
    	//新华08-人民币
    	crawler("http://www.xinhua08.com/list/s307/","utf-8","<ul class=\"unilist\">", "<ul class=\"page_down\">","<a href=\"", "\" target=\"_blank\">",
    			"0405","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","am718");
    }
    
    @Scheduled(cron="0 21 7 * * ?") 
    public void am721PerDay(){
    	//新华08-债券
    	crawler("http://bond.xinhua08.com/qtzq/","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0406","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","am721");
    }
    
    @Scheduled(cron="0 24 7 * * ?") 
    public void am724PerDay(){
    	//新华08-期货	
		crawler("http://futures.xinhua08.com/","utf-8","<div class=\"rsubwidth\">", "<h4>国内期货行情</h4>","<a href=\"", "\" target=\"_blank\">",
    			"0407","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","am724");
    }
    
    @Scheduled(cron="0 27 7 * * ?") 
    public void am727PerDay(){
    	//新华08-国际财经-独家
    	crawler("http://app.xinhua08.com/prop.php?pid=2&cid=5273","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0401","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","am727");
    }
    
    @Scheduled(cron="0 30 7 * * ?") 
    public void am730PerDay(){
    	//新华08-国内财经-产业经济
    	crawler("http://app.xinhua08.com/prop.php?pid=43","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0401","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","am730");
    }
    
    @Scheduled(cron="0 33 7 * * ?") 
    public void am733PerDay(){
		//新华-国内财经
    	crawler("http://www.xinhuanet.com/fortune/gn.htm","utf-8","<!---->", "<td width=\"260\" align=\"right\">","<a href=\"","<a href=", "\" target=\"_blank\">",
    			"0401","新华","<h1 id=\"title\">","</h1>","<div class=\"article\">","<!--文章操作-->","am733");
    }
    
    //@Scheduled(cron="0 36 7 * * ?") 
    public void am736PerDay(){
    	//新华-国际财经
    	crawler("http://www.xinhuanet.com/fortune/guojicaijing.htm","utf-8","<div class=\"conTitle\">", "<p>","<a href=\"", "\" target=\"_blank\">",
    			"0401","新华","<h1 id=\"title\">","</h1>","<div id=\"content\">","</div>","am736");
    }
    
    @Scheduled(cron="0 39 7 * * ?") 
    public void am739PerDay(){
    	//新华-债券
    	crawler("http://www.xinhuanet.com/finance/zhaiquan.htm","utf-8","<table width=\"990\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"," <table width=\"990\" height=\"68\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">","<a href=\"", "\" target=\"_blank\"",
    			"0406","新华","<h1 id=\"title\">","</h1>","<span id=\"content\">","</span>","am739");
    }
    
    @Scheduled(cron="0 42 7 * * ?") 
    public void am742PerDay(){
    	//泉州网-泉州新闻
    	crawler_qzxw("http://news.qzwb.com/gb/node/node_538.htm","utf-8","<div class=\"news_c_2\">", "<div id=\"displaypagenum\"","<a href=", " target=\"_blank\">",
    			"0402","泉州网","<li class=\"bt\" id=\"div_title_article\">","</li>","<div id=\"id_content\">","<!--/enpcontent--></div>", "http://news.qzwb.com/gb/node/","am742");  
    }

    //@Scheduled(cron="0 45 7 * * ?") 
    public void am745PerDay(){
		//泉州理财网-泉州财经
    	crawler("http://www.qzlc.net/node_6220.htm","utf-8","<td align=\"center\" valign=\"top\">", "<div id=\"displaypagenum\"","<a href=", " target=\"_blank\" class=heise14>",
    			"0402","泉州理财网","<div align=\"center\" class=\"lvword3\" id=\"div_title_article\">","</div>","<span class=\"songti1\"> <!--enpcontent-->","<!--/enpcontent-->", "http://www.qzlc.net/","am745");
    }
    
    //@Scheduled(cron="0 48 7 * * ?") 
    public void am748PerDay(){
    	//泉州网-泉州财经
    	crawler("http://www.qzlc.net/node_6219.htm","utf-8","<Font class=\"black1\">泉州财经</Font>", "<span  class = \"word06\">1</span>","<a href=", " target=\"_blank\" class=heise14>",
    			"0402","泉州理财网","<div align=\"center\" class=\"lvword3\" id=\"div_title_article\">","</div>","<span class=\"songti1\"> <!--enpcontent-->","<!--/enpcontent-->","am748");    	
    }
    
    //@Scheduled(cron="0 51 7 * * ?") 
    public void am751PerDay(){
    	//新浪网-新浪债券
    	crawler("http://roll.finance.sina.com.cn/finance/zq2/zsscdt/index.shtml","gb2312","<div class=\"hs01\"></div>", "<div class=\"pagebox\">","<a href=\"", "\" target=\"_blank\"",
    			"0406","新浪网","<title>","</title>","<!--单图 end--> ","<!-- publish_helper_end -->","am751");    	
    }
    
    //@Scheduled(cron="0 54 7 * * ?") 
    public void am754PerDay(){
		//新浪-新浪财经-银行
    	crawler("http://finance.sina.com.cn/money/bank/","utf-8","<div class=\"blk05_cont\">", "<!-- blk05 end -->","<a class=\"fblue\" href=\"", "\" target=\"_blank\">",
    			"0401","新浪财经","<title>","</title>","<!-- 正文内容 begin -->","<!-- publish_helper_end -->","am754"); 
    }
    
    //@Scheduled(cron="0 57 7 * * ?") 
    public void am757PerDay(){
		//新浪-新浪财经-全球市场滚动
    	crawler("http://roll.finance.sina.com.cn/s/channel.php?ch=03#col=205&spec=&type=&ch=03&k=&offset_page=0&offset_num=0&num=60&asc=&page=1","utf-8","<div class=\"d_list_txt\" id=\"d_list\">", "<div class=\"pagebox\">","<a href=\"", "\" target=\"_blank\">",
    			"0401","新浪财经","<title>","</title>","<!-- 正文内容 begin -->","<!-- publish_helper_end -->","am757"); 
    }
    
    //@Scheduled(cron="0 0 8 * * ?") 
    public void am800PerDay(){
		//新浪-新浪财经-股票
    	crawler("http://finance.sina.com.cn/stock/","utf-8","<div class=\"p01_m fl\" id=\"directad00\" data-sudaclick=\"blk_yw\">", "<div class=\"p01_r fr\">","<a target=\"_blank\" href=\"", "\">",
    			"0403","新浪财经","<title>","</title>","<!--单图 end-->","<!-- publish_helper_end -->","am800"); 
    }
    
    //@Scheduled(cron="0 3 8 * * ?") 
    public void am803PerDay(){
		//新浪-新浪财经-外汇
    	crawler("http://finance.sina.com.cn/forex/","utf-8","<div class=\"ListB\"><ul data-client=\"scroll\">", "<div class=\"Right\">","<a href=\"", "\" target=\"_blank\">",
    			"0404","新浪财经","<title>","</title>","<!--单图 end-->","<!-- publish_helper_end -->","am803"); 
    }
    
    //@Scheduled(cron="0 6 8 * * ?") 
    public void am806PerDay(){
		//新浪-新浪财经-期货
    	crawler("http://futures.eastmoney.com/","utf-8","<div id=\"newsContent1\"", "<div id=\"newsContent2\"","<a href=\"", "\" target=\"_blank\"",
    			"0407","东方财富网","<h1>","</h1>","<div id=\"ContentBody\" class=\"Body\">","<div class=\"BodyEnd\">","am806"); 
    }    
    
    @Scheduled(cron="0 10 8 * * ?") 
    public void pm610clear(){
		//清除重复记录
      removeDuplicateArticles();
    } 
    
    /**
     * 每天下午14点执行一次采集
     */
    @Scheduled(cron="0 10 14 * * ?") 
    public void pm210PerDay(){ 
    	Lock.setLock(false);//开锁
    }
    
    @Scheduled(cron="0 12 14 * * ?") 
    public void pm212PerDay(){
    	//新华08-股票要闻
    	crawler("http://stock.xinhua08.com/zlyj/","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0403","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm212");

    }
    
    @Scheduled(cron="0 15 14 * * ?") 
    public void pm215PerDay(){
    	//新华08-外汇-美联储
    	crawler("http://forex.xinhua08.com/yhdt/mlc/","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0404","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm215");
    }
    
    @Scheduled(cron="0 18 14 * * ?") 
    public void pm218PerDay(){
    	//新华08-人民币
    	crawler("http://www.xinhua08.com/list/s307/","utf-8","<ul class=\"unilist\">", "<ul class=\"page_down\">","<a href=\"", "\" target=\"_blank\">",
    			"0405","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm218");
    }
    
    @Scheduled(cron="0 21 14 * * ?") 
    public void pm221PerDay(){
    	//新华08-债券
    	crawler("http://bond.xinhua08.com/qtzq/","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0406","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm221");
    }
    
    @Scheduled(cron="0 24 14 * * ?") 
    public void pm224PerDay(){
    	//新华08-期货	
		crawler("http://futures.xinhua08.com/","utf-8","<div class=\"rsubwidth\">", "<h4>国内期货行情</h4>","<a href=\"", "\" target=\"_blank\">",
    			"0407","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm224");
    }
    
    @Scheduled(cron="0 27 14 * * ?") 
    public void pm227PerDay(){
    	//新华08-国际财经-独家
    	crawler("http://app.xinhua08.com/prop.php?pid=2&cid=5273","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0401","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm227");
    }
    
    @Scheduled(cron="0 30 14 * * ?") 
    public void pm230PerDay(){
    	//新华08-国内财经-产业经济
    	crawler("http://app.xinhua08.com/prop.php?pid=43","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0401","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm230");
    }
    
    @Scheduled(cron="0 33 14 * * ?") 
    public void pm233PerDay(){
		//新华-国内财经
    	crawler("http://www.xinhuanet.com/fortune/gn.htm","utf-8","<!---->", "<td width=\"260\" align=\"right\">","<a href=\"","<a href=", "\" target=\"_blank\">",
    			"0401","新华","<h1 id=\"title\">","</h1>","<div class=\"article\">","<!--文章操作-->","pm233");
    }
    
    //@Scheduled(cron="0 36 14 * * ?") 
    public void pm236PerDay(){
    	//新华-国际财经
    	crawler("http://www.xinhuanet.com/fortune/guojicaijing.htm","utf-8","<div class=\"conTitle\">", "<p>","<a href=\"", "\" target=\"_blank\">",
    			"0401","新华","<h1 id=\"title\">","</h1>","<div id=\"content\">","</div>","pm236");
    }
    
    @Scheduled(cron="0 39 14 * * ?") 
    public void pm239PerDay(){
    	//新华-债券
    	crawler("http://www.xinhuanet.com/finance/zhaiquan.htm","utf-8","<table width=\"990\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"," <table width=\"990\" height=\"68\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">","<a href=\"", "\" target=\"_blank\"",
    			"0406","新华","<h1 id=\"title\">","</h1>","<span id=\"content\">","</span>","pm239");
    }
    
    @Scheduled(cron="0 42 14 * * ?") 
    public void pm242PerDay(){
    	//泉州网-泉州新闻
    	crawler_qzxw("http://news.qzwb.com/gb/node/node_538.htm","utf-8","<div class=\"news_c_2\">", "<div id=\"displaypagenum\"","<a href=", " target=\"_blank\">",
    			"0402","泉州网","<li class=\"bt\" id=\"div_title_article\">","</li>","<div id=\"id_content\">","<!--/enpcontent--></div>", "http://news.qzwb.com/gb/node/","pm242");  
    }
    
    //@Scheduled(cron="0 45 14 * * ?") 
    public void pm245PerDay(){
    	//泉州理财-泉州财经
    	crawler("http://www.qzlc.net/node_6220.htm","utf-8","<td align=\"center\" valign=\"top\">", "<div id=\"displaypagenum\"","<a href=", " target=\"_blank\" class=heise14>",
    			"0402","泉州理财网","<div align=\"center\" class=\"lvword3\" id=\"div_title_article\">","</div>","<span class=\"songti1\"> <!--enpcontent-->","<!--/enpcontent-->", "http://www.qzlc.net/","pm245");
    }
    
    //@Scheduled(cron="0 48 14 * * ?") 
    public void pm248PerDay(){
    	//泉州网-泉州财经
    	crawler("http://www.qzlc.net/node_6219.htm","utf-8","<td align=\"center\" valign=\"top\">", "<div id=\"displaypagenum\"","<a href=", " target=\"_blank\" class=heise14>",
    			"0402","泉州理财网","<div align=\"center\" class=\"lvword3\" id=\"div_title_article\">","</div>","<span class=\"songti1\"> <!--enpcontent-->","<!--/enpcontent-->", "http://www.qzlc.net/","pm248"); 
    }
    
    //@Scheduled(cron="0 51 14 * * ?") 
    public void pm251PerDay(){
    	//新浪网-新浪债券
    	crawler("http://roll.finance.sina.com.cn/finance/zq2/zsscdt/index.shtml","gb2312","<div class=\"hs01\"></div>", "<div class=\"pagebox\">","<a href=\"", "\" target=\"_blank\"",
    			"0406","新浪网","<title>","</title>","<!--单图 end--> ","<!-- publish_helper_end -->","pm251");    	
    }
    
    //@Scheduled(cron="0 54 14 * * ?") 
    public void pm254PerDay(){
		//新浪-新浪财经-银行
    	crawler("http://finance.sina.com.cn/money/bank/","utf-8","<div class=\"blk05_cont\">", "<!-- blk05 end -->","<a class=\"fblue\" href=\"", "\" target=\"_blank\">",
    			"0401","新浪财经","<title>","</title>","<!-- 正文内容 begin -->","<!-- publish_helper_end -->","pm254"); 
    }
    
    //@Scheduled(cron="0 57 14 * * ?") 
    public void pm257PerDay(){
		//新浪-新浪财经-全球市场滚动
    	crawler("http://roll.finance.sina.com.cn/s/channel.php?ch=03#col=205&spec=&type=&ch=03&k=&offset_page=0&offset_num=0&num=60&asc=&page=1","utf-8","<div class=\"d_list_txt\" id=\"d_list\">", "<div class=\"pagebox\">","<a href=\"", "\" target=\"_blank\">",
    			"0401","新浪财经","<title>","</title>","<!-- 正文内容 begin -->","<!-- publish_helper_end -->","pm257"); 
    }
    
    //@Scheduled(cron="0 0 15 * * ?") 
    public void pm300PerDay(){
		//新浪-新浪财经-股票
    	crawler("http://finance.sina.com.cn/stock/","utf-8","<div class=\"p01_m fl\" id=\"directad00\" data-sudaclick=\"blk_yw\">", "<div class=\"p01_r fr\">","<a target=\"_blank\" href=\"", "\">",
    			"0403","新浪财经","<title>","</title>","<!--单图 end-->","<!-- publish_helper_end -->","pm300"); 
    }
    
    //@Scheduled(cron="0 3 15 * * ?") 
    public void pm303PerDay(){
		//新浪-新浪财经-外汇
    	crawler("http://finance.sina.com.cn/forex/","utf-8","<div class=\"ListB\"><ul data-client=\"scroll\">", "<div class=\"Right\">","<a href=\"", "\" target=\"_blank\">",
    			"0404","新浪财经","<title>","</title>","<!--单图 end-->","<!-- publish_helper_end -->","pm303"); 
    }
    
    //@Scheduled(cron="0 6 15 * * ?") 
    public void pm306PerDay(){
		//新浪-新浪财经-期货
    	crawler("http://futures.eastmoney.com/","utf-8","<div id=\"newsContent1\"", "<div id=\"newsContent2\"","<a href=\"", "\" target=\"_blank\"",
    			"0407","东方财富网","<h1>","</h1>","<div id=\"ContentBody\" class=\"Body\">","<div class=\"BodyEnd\">","pm306"); 
    } 
	
    @Scheduled(cron="0 10 15 * * ?") 
    public void pm1310clear(){
		//清除重复记录
      removeDuplicateArticles();
    } 

    /**
     * 每天晚上7点执行一次采集
     */
    @Scheduled(cron="0 10 19 * * ?") 
    public void pm710PerDay(){ 
    	Lock.setLock(false);//开锁
    }    
    
    @Scheduled(cron="0 12 19 * * ?") 
    public void pm712PerDay(){
    	//新华08-股票要闻
    	crawler("http://stock.xinhua08.com/zlyj/","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0403","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm712");
    }
    
    @Scheduled(cron="0 15 19 * * ?") 
    public void pm715PerDay(){
    	//新华08-外汇-美联储
    	crawler("http://forex.xinhua08.com/yhdt/mlc/","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0404","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm715");
    }
    
    @Scheduled(cron="0 18 19 * * ?") 
    public void pm718PerDay(){
    	//新华08-人民币
    	crawler("http://www.xinhua08.com/list/s307/","utf-8","<ul class=\"unilist\">", "<ul class=\"page_down\">","<a href=\"", "\" target=\"_blank\">",
    			"0405","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm718");
    }
    
    @Scheduled(cron="0 21 19 * * ?") 
    public void pm721PerDay(){
    	//新华08-债券
    	crawler("http://bond.xinhua08.com/qtzq/","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0406","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm721");
    }
    
    @Scheduled(cron="0 24 19 * * ?") 
    public void pm724PerDay(){
    	//新华08-期货	
		crawler("http://futures.xinhua08.com/","utf-8","<div class=\"rsubwidth\">", "<h4>国内期货行情</h4>","<a href=\"", "\" target=\"_blank\">",
    			"0407","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm724");
    }
    
    @Scheduled(cron="0 27 19 * * ?") 
    public void pm727PerDay(){
    	//新华08-国际财经-独家
    	crawler("http://app.xinhua08.com/prop.php?pid=2&cid=5273","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0401","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm727");
    }
    
    @Scheduled(cron="0 30 19 * * ?") 
    public void pm730PerDay(){
    	//新华08-国内财经-产业经济
    	crawler("http://app.xinhua08.com/prop.php?pid=43","utf-8","<div class=\"mainContent\">", "<ul class=\"page_down\">","<a href=\"", "\">",
    			"0401","新华08","<h1>","</h1>","<p class=\"abstract\"><em>","<div class=\"left bhome\">","pm730");
    }
    
    @Scheduled(cron="0 33 19 * * ?") 
    public void pm733PerDay(){
		//新华-国内财经
    	crawler("http://www.xinhuanet.com/fortune/gn.htm","utf-8","<!---->", "<td width=\"260\" align=\"right\">","<a href=\"","<a href=", "\" target=\"_blank\">",
    			"0401","新华","<h1 id=\"title\">","</h1>","<div class=\"article\">","<!--文章操作-->","pm733");
    }
    
    //@Scheduled(cron="0 36 19 * * ?") 
    public void pm736PerDay(){
    	//新华-国际财经
    	crawler("http://www.xinhuanet.com/fortune/guojicaijing.htm","utf-8","<div class=\"conTitle\">", "<p>","<a href=\"", "\" target=\"_blank\">",
    			"0401","新华","<h1 id=\"title\">","</h1>","<div id=\"content\">","</div>","pm736");
    }
    
    @Scheduled(cron="0 39 19 * * ?") 
    public void pm739PerDay(){
    	//新华-债券
    	crawler("http://www.xinhuanet.com/finance/zhaiquan.htm","utf-8","<table width=\"990\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"," <table width=\"990\" height=\"68\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">","<a href=\"", "\" target=\"_blank\"",
    			"0406","新华","<h1 id=\"title\">","</h1>","<span id=\"content\">","</span>","pm739");
    }
    
    @Scheduled(cron="0 42 19 * * ?") 
    public void pm742PerDay(){
    	//泉州网-泉州新闻
    	crawler_qzxw("http://news.qzwb.com/gb/node/node_538.htm","utf-8","<div class=\"news_c_2\">", "<div id=\"displaypagenum\"","<a href=", " target=\"_blank\">",
    			"0402","泉州网","<li class=\"bt\" id=\"div_title_article\">","</li>","<div id=\"id_content\">","<!--/enpcontent--></div>", "http://news.qzwb.com/gb/node/","pm742");  
    }

    //@Scheduled(cron="0 45 19 * * ?") 
    public void pm745PerDay(){
    	//泉州网-泉州财经
    	crawler("http://www.qzlc.net/node_6219.htm","utf-8","<td align=\"center\" valign=\"top\">", "<div id=\"displaypagenum\"","<a href=", " target=\"_blank\" class=heise14>",
    			"0402","泉州理财网","<div align=\"center\" class=\"lvword3\" id=\"div_title_article\">","</div>","<span class=\"songti1\"> <!--enpcontent-->","<!--/enpcontent-->", "http://www.qzlc.net/","pm745");  
    }
    
   // @Scheduled(cron="0 48 19 * * ?") 
    public void pm748PerDay(){
		//泉州理财网-泉州财经
    	crawler("http://www.qzlc.net/node_6220.htm","utf-8","<td align=\"center\" valign=\"top\">", "<div id=\"displaypagenum\"","<a href=", " target=\"_blank\" class=heise14>",
    			"0402","泉州理财网","<div align=\"center\" class=\"lvword3\" id=\"div_title_article\">","</div>","<span class=\"songti1\"> <!--enpcontent-->","<!--/enpcontent-->", "http://www.qzlc.net/","pm748");    	
    }
    
    //@Scheduled(cron="0 51 19 * * ?") 
    public void pm751PerDay(){
    	//新浪网-新浪债券
    	crawler("http://roll.finance.sina.com.cn/finance/zq2/zsscdt/index.shtml","gb2312","<div class=\"hs01\"></div>", "<div class=\"pagebox\">","<a href=\"", "\" target=\"_blank\"",
    			"0406","新浪网","<title>","</title>","<!--单图 end--> ","<!-- publish_helper_end -->","pm751");    	
    }
    
    //@Scheduled(cron="0 54 19 * * ?") 
    public void pm754PerDay(){
		//新浪-新浪财经-银行
    	crawler("http://finance.sina.com.cn/money/bank/","utf-8","<div class=\"blk05_cont\">", "<!-- blk05 end -->","<a class=\"fblue\" href=\"", "\" target=\"_blank\">",
    			"0401","新浪财经","<title>","</title>","<!-- 正文内容 begin -->","<!-- publish_helper_end -->","pm754"); 
    }
    
    //@Scheduled(cron="0 57 19 * * ?") 
    public void pm757PerDay(){
		//新浪-新浪财经-全球市场滚动
    	crawler("http://roll.finance.sina.com.cn/s/channel.php?ch=03#col=205&spec=&type=&ch=03&k=&offset_page=0&offset_num=0&num=60&asc=&page=1","utf-8","<div class=\"d_list_txt\" id=\"d_list\">", "<div class=\"pagebox\">","<a href=\"", "\" target=\"_blank\">",
    			"0401","新浪财经","<title>","</title>","<!-- 正文内容 begin -->","<!-- publish_helper_end -->","pm757"); 
    }
    
    //@Scheduled(cron="0 0 20 * * ?") 
    public void pm800PerDay(){
		//新浪-新浪财经-股票
    	crawler("http://finance.sina.com.cn/stock/","utf-8","<div class=\"p01_m fl\" id=\"directad00\" data-sudaclick=\"blk_yw\">", "<div class=\"p01_r fr\">","<a target=\"_blank\" href=\"", "\">",
    			"0403","新浪财经","<title>","</title>","<!--单图 end-->","<!-- publish_helper_end -->","pm800"); 
    }
    
    //@Scheduled(cron="0 3 20 * * ?") 
    public void pm803PerDay(){
		//新浪-新浪财经-外汇
    	crawler("http://finance.sina.com.cn/forex/","utf-8","<div class=\"ListB\"><ul data-client=\"scroll\">", "<div class=\"Right\">","<a href=\"", "\" target=\"_blank\">",
    			"0404","新浪财经","<title>","</title>","<!--单图 end-->","<!-- publish_helper_end -->","pm803"); 
    }
    
    @Scheduled(cron="0 6 20 * * ?") 
    public void pm806PerDay(){
		//东方财富-期货
    	crawler("http://futures.eastmoney.com/","utf-8","<div id=\"newsContent1\"", "<div id=\"newsContent2\"","<a href=\"", "\" target=\"_blank\"",
    			"0407","东方财富网","<h1>","</h1>","<div id=\"ContentBody\" class=\"Body\">","<div class=\"BodyEnd\">","pm806"); 
    }  
	
    @Scheduled(cron="0 10 20 * * ?") 
    public void pm2210clear(){
		//清除重复记录
      removeDuplicateArticles();
    } 
    
    /**
     * 每天1点执行一次重建索引
     * */
    @Scheduled(cron="0 0 1 * * ?") 
    public void oneOClockPerDay(){
    	try{
	    	if(articleService == null){
	    		ApplicationContext ac = new ClassPathXmlApplicationContext("spring-mvc-ibatis.xml");
				articleService = (ArticleService)ac.getBean("articleService");
				settingService =(SettingService)ac.getBean("settingService");
			}
	    	buildIndex(false);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }
     

	private boolean contains(String keyWords, String title, String content) {
		String[] sa =  keyWords.split(";");
		for(int i=0,len=sa.length;i<len;i++){
			if(title.indexOf(sa[i].trim())>-1){
				return true;
			}
			if(content.indexOf(sa[i].trim())>-1){
				return true;
			}
		}
		return false;
	}
	
    private void crawler(String url, String encode, String sf, String ef, String sa, String ea,
    		String columnId, String author, String titleSf, String titleEf,
    		String contentSf, String contentEf, String taskId
    		){
    	if(!Lock.isLock()){
    		Lock.setLock(true);
    	try{
	    	if(articleService == null){
	    		ApplicationContext ac = new ClassPathXmlApplicationContext("spring-mvc-ibatis.xml");
				articleService = (ArticleService)ac.getBean("articleService");
				if(settingService == null)
					settingService =(SettingService)ac.getBean("settingService");
			}
	    	String state = articleService.getCralerTaskState(taskId);
	    	if(!state.equals("0")){ 
	    		articleService.setCralerTaskStart(taskId);
				List<String> list2 = Crawlers.getList(url, encode, sf, ef,sa, ea);
				
				List<Article> list = articleService.findByColumnId3(columnId);
				StringBuffer sb = new StringBuffer();
				for(int i=0,len=list.size();i<len;i++){
					sb.append(list.get(i).getTitle());
				}
				for(int i=list2.size()-1;i>-1;i--){
					try{
						String href = list2.get(i);
						String title = Crawlers.getText(href,encode,titleSf,titleEf);
						if(sb.indexOf(title)<0){
							String content = Crawlers.getText(href,encode,contentSf,contentEf);
							if(!StringUtil.isEmpty(content)){
								Article a = new Article();			
								a.setAuthor(author);
								a.setColumnId(columnId);//股票
								a.setTitle(title);
								a.setContent(content);
								a.setSummary(Tools.getTextFromHtml(contentSf+content, 200));
								
								String keyWords = settingService.get("crawl_except_key_words").getValue();
								if(!contains(keyWords, title, content)){
									articleService.insertSpider(a);
								}
							}
						}
					}catch(Exception e){
						//e.printStackTrace();
					}
				}
		    	articleService.setCralerTaskEnd(taskId);
	    	}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	Lock.setLock(false);
    	}
    }
   
    private void crawler(String url, String encode, String sf, String ef, String sa, String ea,
    		String columnId, String author, String titleSf, String titleEf,
    		String contentSf, String contentEf, String preurl, String taskId
    		){
    	if(!Lock.isLock()){ 		
    		Lock.setLock(true);
    	try{
	    	if(articleService == null){
	    		ApplicationContext ac = new ClassPathXmlApplicationContext("spring-mvc-ibatis.xml");
				articleService = (ArticleService)ac.getBean("articleService");
				if(settingService == null)
					settingService =(SettingService)ac.getBean("settingService");
			}
	    	String state = articleService.getCralerTaskState(taskId);
	    	if(!state.equals("0")){ 
	    		articleService.setCralerTaskStart(taskId);
				List<String> list2 = Crawlers.getList(url, encode, sf, ef,sa, ea);
				
				List<Article> list = articleService.findByColumnId3(columnId);
				StringBuffer sb = new StringBuffer();
				for(int i=0,len=list.size();i<len;i++){
					sb.append(list.get(i).getTitle());
				}
				for(int i=list2.size()-1;i>-1;i--){
					try{
						String href = list2.get(i);
						String title = Crawlers.getText(preurl+href,encode,titleSf,titleEf);
						if(sb.indexOf(title)<0){
							String content = Crawlers.getText(preurl+href,encode,contentSf,contentEf);
							if(!StringUtil.isEmpty(content)){
								Article a = new Article();			
								a.setAuthor(author);
								a.setColumnId(columnId);//股票
								a.setTitle(title);
								a.setContent(content);
								a.setSummary(Tools.getTextFromHtml(contentSf+content, 200));
								
								String keyWords = settingService.get("crawl_except_key_words").getValue();
								if(!contains(keyWords, title, content)){
									articleService.insertSpider(a);
								}
							}
						}
					}catch(Exception e){
						//e.printStackTrace();
					}
				}
		    	articleService.setCralerTaskEnd(taskId);
	    	}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	Lock.setLock(false);
    	}
    }
    //泉州新闻-处理图片路径有问题
    private void crawler_qzxw(String url, String encode, String sf, String ef, String sa, String ea,
    		String columnId, String author, String titleSf, String titleEf,
    		String contentSf, String contentEf, String preurl, String taskId
    		){
    	if(!Lock.isLock()){
    		Lock.setLock(true);
    	try{
	    	if(articleService == null){
	    		ApplicationContext ac = new ClassPathXmlApplicationContext("spring-mvc-ibatis.xml");
				articleService = (ArticleService)ac.getBean("articleService");
				if(settingService == null)
					settingService =(SettingService)ac.getBean("settingService");
			}
	    	String state = articleService.getCralerTaskState(taskId);
	    	if(!state.equals("0")){ 
	    		articleService.setCralerTaskStart(taskId);
				List<String> list2 = Crawlers.getList(url, encode, sf, ef,sa, ea);
				
				List<Article> list = articleService.findByColumnId3(columnId);
				StringBuffer sb = new StringBuffer();
				for(int i=0,len=list.size();i<len;i++){
					sb.append(list.get(i).getTitle());
				}
				for(int i=list2.size()-1;i>-1;i--){
					try{
						String href = list2.get(i);
						String title = Crawlers.getText(preurl+href,encode,titleSf,titleEf);
						if(sb.indexOf(title)<0){
							String content = Crawlers.getText(preurl+href,encode,contentSf,contentEf);
							if(!StringUtil.isEmpty(content)){
								Article a = new Article();			
								a.setAuthor(author);
								a.setColumnId(columnId);//股票
								a.setTitle(title);
								a.setContent(content.replaceAll("../../../img/attachement", "http://news.qzwb.com/gb/img/attachement"));
								a.setSummary(Tools.getTextFromHtml(contentSf+content, 200));
								
								String keyWords = settingService.get("crawl_except_key_words").getValue();
								if(!contains(keyWords, title, content)){
									articleService.insertSpider(a);
								}
							}
						}
					}catch(Exception e){
						//e.printStackTrace();
					}
				}
		    	articleService.setCralerTaskEnd(taskId);
	    	}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	Lock.setLock(false);
    	}
    }
    
    private void removeDuplicateArticles(){
    	try{
	    	if(articleService == null){
	    		ApplicationContext ac = new ClassPathXmlApplicationContext("spring-mvc-ibatis.xml");
				articleService = (ArticleService)ac.getBean("articleService");
				settingService =(SettingService)ac.getBean("settingService");
			} 
	    	articleService.removeDuplicateArticles();
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	
    }
    
    private void buildIndex(boolean create) {
        Date start = new Date();
        try {
          System.out.println("正在建立目录索引 '" + Global.INDEX_PATH + "'...");

          Directory dir = FSDirectory.open(new File(Global.INDEX_PATH));
          Analyzer analyzer = new IKAnalyzer();
          IndexWriterConfig iwc = new IndexWriterConfig(Version.LUCENE_36, analyzer);

          if (create) {
            iwc.setOpenMode(OpenMode.CREATE);
          } else {
            iwc.setOpenMode(OpenMode.CREATE_OR_APPEND);
          }

          IndexWriter writer = new IndexWriter(dir, iwc);
          indexDocs(writer);

          writer.close();

          Date end = new Date();
          System.out.println("建立索引总共使用" + (end.getTime() - start.getTime()) + " 毫秒");

        } catch (IOException e) {
          System.out.println(" caught a " + e.getClass() +
           "\n with message: " + e.getMessage());
        }
      }

      private void indexDocs(IndexWriter writer) throws IOException {
            try {
              List<Article> list = articleService.findWithoutIndex();
              for(int i=0,len=list.size();i<len;i++){
            	  Article a = list.get(i);
                  Document doc = new Document();
                  Field idField = new Field("id", a.getId(), Field.Store.YES, Field.Index.NOT_ANALYZED_NO_NORMS);
                  idField.setIndexOptions(IndexOptions.DOCS_ONLY);
                  doc.add(idField);
                  doc.add(new Field("author", a.getAuthor(), Field.Store.YES, Field.Index.NOT_ANALYZED_NO_NORMS));
                  doc.add(new Field("columnId", a.getColumnId(), Field.Store.YES, Field.Index.NOT_ANALYZED_NO_NORMS));
                  doc.add(new Field("publishTime", DateUtils.date2Str(a.getPublishTime(), DateUtils.yyyymmddhhmmss), Field.Store.YES, Field.Index.NOT_ANALYZED_NO_NORMS));
                  doc.add(new Field("title", a.getTitle(), Field.Store.YES, Field.Index.ANALYZED));
                  doc.add(new Field("content", Tools.getTextFromHtml(a.getContent(), -1), Field.Store.YES, Field.Index.ANALYZED));

                  if (writer.getConfig().getOpenMode() == OpenMode.CREATE) {
                    // New index, so we just add the document (no old document can be there):
                    //System.out.println("adding " + a.getTitle());
                    writer.addDocument(doc);
                  } else {
                    // Existing index (an old copy of this document may have been indexed) so 
                    // we use updateDocument instead to replace the old one matching the exact 
                    // path, if present:
                    //System.out.println("updating " + a.getTitle());
                    writer.updateDocument(new Term("id", a.getId()), doc);
                  } 
            	  articleService.updateIndex(a.getId());
              }
            } catch(Exception e){
            	e.printStackTrace();
            } finally {
              //fis.close();
            }
      }
    
    
	public static void main(String[] args){	

    	//crawler("http://roll.finance.sina.com.cn/s/channel.php?ch=03#col=205&spec=&type=&ch=03&k=&offset_page=0&offset_num=0&num=60&asc=&page=1","utf-8","<div class=\"d_list_txt\" id=\"d_list\">", "<div class=\"pagebox\">","<a href=\"", "\" target=\"_blank\">",
    		//	"0401","新浪财经","<title>","</title>","<!-- 正文内容 begin -->","<!-- publish_helper_end -->","am757"); 
		List<String> list2 = Crawlers.getList("http://roll.finance.sina.com.cn/s/channel.php?ch=03#col=205&spec=&type=&ch=03&k=&offset_page=0&offset_num=0&num=60&asc=&page=1","utf-8","<div class=\"d_list_txt\" id=\"d_list\">", "<div class=\"pagebox\">","<a href=\"", "\" target=\"_blank\">");
		System.out.println(list2.size());
		for(int i=list2.size()-1;i>-1;i--){
			try{
				String title = Crawlers.getText(list2.get(i),"gb2312","<meta property=\"og:title\" content=\"","\" />");
				System.out.println(list2.get(i));
				System.out.println(title);
				//String content = Crawlers.getText(list2.get(i),"utf-8","<!-- 正文内容 begin -->","<!-- publish_helper_end -->");
				//System.out.println(content);
			}catch(Exception e){
				//e.printStackTrace();
			}
		}
		
	}
    /**
     * 每天早上8点发送手机报
    @Scheduled(cron="0 0 8 * * ?") 
    public void sendOrderPerDay(){
    	try{
    		//泉州理财网-热点聚焦
			URL url = new URL("http://www.qzjrfw.com/sendOrderController.do?SendAll"); 
			URLConnection urlcon = url.openConnection();  
			urlcon.getInputStream();
    	}catch(Exception e){
    	}
    }
     */
    
    /**
     * 每天早上8点10发送手机报
    @Scheduled(cron="0 10 8 * * ?") 
    public void sendMsgPerDay(){
    	try{
			URL url = new URL("http://www.qzjrfw.com/sendOrderController.do?SendMsg"); 
			URLConnection urlcon = url.openConnection();  
			urlcon.getInputStream();
    	}catch(Exception e){
    	}
    }
     */
}