package songhu.common.service;

import java.util.List;
import java.util.Map;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;

import songhu.common.pojo.Article;
import songhu.common.pojo.Column;
import songhu.common.pojo.Crumb;
import songhu.common.pojo.Appendix;

public interface ArticleService {

	List<Article> findByColumnId(Map map, RowSelection row) throws Exception;

	List<Article> findByColumnId2(Map map, RowSelection row) throws Exception;

	List<Article> findByColumnId3(String columnId) throws Exception;

	List<Article> findByPaging(Map map, RowSelection row) throws Exception;

	List<Article> findByHot(Map map, RowSelection row) throws Exception;

	List<Article> listMore(String id, RowSelection row) throws Exception;

	Crumb getCrumb(String id) throws Exception;

	List<Article> findWithBLOBs() throws Exception;

	Article getById(String id) throws Exception;

	Appendix getAppendixByArticleId(String articleId) throws Exception;

	// 查找
	Page find(Article article, int start, int limit) throws Exception;

	// 插入
	String insert(Article article) throws Exception;

	String insertSpider(Article article) throws Exception;

	// 更改
	String updateBLOBs(Article article) throws Exception;

	// 获取
	Article getByPrimaryKey(String id) throws Exception;

	// 删除
	String delete(Article article) throws Exception;

	// 垂直查询
	List<Article> findByVertical(List<String> param, int start, int limit,
			String columnId) throws Exception;

	int countByVertical(List<String> param, String columnId) throws Exception;

	Page findWithBLOBs2(Article article, int start, int limit) throws Exception;

	// 文章篇数
	int countByColumnId(String columnId) throws Exception;

	List<Column> listColumnByParent(String parentId) throws Exception;

	List<Article> findWithoutIndex() throws Exception;

	void updateIndex(String articleId) throws Exception;

	int countByTitle(String title) throws Exception;

	List<Article> getByColumnId(String columnId) throws Exception;

	Article findId(String columnId) throws Exception;

	// 附件功能
	Appendix getAppendix(String id) throws Exception;

	Page findAppendix(Appendix appendix, int start, int limit) throws Exception;

	String insertAppendix(Appendix appendix) throws Exception;

	String updateAppendix(Appendix appendix) throws Exception;

	String deleteAppendix(String id) throws Exception;

	String deleteAll(String articleId) throws Exception;

	List<Appendix> listPath(String articleId) throws Exception;

	List<Appendix> listPath2(String articleId) throws Exception;

	List<Appendix> listPath3(String articleId) throws Exception;

	void updateAppendix2(Map map) throws Exception;

	Article getByPrimaryKey2(String wordPath) throws Exception;

	void deleteAppendix2(String articleId) throws Exception;

	void updateState(String articleId) throws Exception;

	void deleteAppendix3() throws Exception;

	List<Appendix> listArticleId() throws Exception;

	void updateState2(String articleId) throws Exception;

	int findState(String articleId) throws Exception;

	void removeDuplicateArticles() throws Exception;

	String getCralerTaskState(String taskId);

	void setCralerTaskStart(String taskId);

	void setCralerTaskEnd(String taskId);
}
