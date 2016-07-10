package songhu.common.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;
import com.weixin.core.util.StringUtil;

import songhu.common.pojo.Appendix;
import songhu.common.pojo.Article;
import songhu.common.pojo.Column;
import songhu.common.pojo.Crumb;
import songhu.common.service.ArticleService;

@Service("articleService")
@Transactional
public class ArticleServiceImpl extends CommonServiceImpl implements
		ArticleService {
	private String domain = "cmsArticle";

	@Cacheable(value = "article", key = "#map")
	public List<Article> findByColumnId(Map map, RowSelection row)
			throws Exception {
		List<Article> list = this.getCommonDao().find(domain, "findByColumnId",
				map, row);
		return list;
	}

	public List<Article> findByHot(Map map, RowSelection row) throws Exception {
		List<Article> list = this.getCommonDao().find(domain, "findByHot", map,
				row);
		return list;
	}

	public Crumb getCrumb(String id) throws Exception {
		List<Crumb> list = this.getCommonDao().find(domain, "getCrumb", id);
		return list.size() > 0 ? list.get(0) : null;
	}

	public List<Article> findWithBLOBs() throws Exception {
		List<Article> list = this.getCommonDao().find(domain, "findWithBLOBs",
				"");
		return list;
	}

	public Article getById(String id) throws Exception {
		List<Article> list = this.getCommonDao().find(domain,
				"getByPrimaryKey", id);
		return list.size() > 0 ? list.get(0) : null;
	}

	public Page find(Article article, int start, int limit) throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Article> list = this.getCommonDao().find(domain, "find", article,
				row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

	// 插入
	@CacheEvict(value = "article", allEntries = true)
	public String insert(Article article) throws Exception {
		this.getCommonDao().insert(domain, "insert", article);
		return "添加成功！ ";
	}

	public String insertSpider(Article article) throws Exception {
		this.getCommonDao().insert(domain, "insertSpider", article);
		return "添加成功！ ";
	}

	// 获取
	public Article getByPrimaryKey(String id) throws Exception {
		List<Article> list = this.getCommonDao().find(domain,
				"getByPrimaryKey", id);
		return list.size() > 0 ? list.get(0) : null;
	}

	// 更改
	@CacheEvict(value = "article", allEntries = true)
	public String updateBLOBs(Article article) throws Exception {
		this.getCommonDao().update(domain, "updateByPrimaryKeySelective",
				article);
		return "更新成功！ ";
	}

	// 删除
	@CacheEvict(value = "article", allEntries = true)
	public String delete(Article article) throws Exception {
		this.getCommonDao().delete(domain, "deleteByPrimaryKey", article);
		return "删除成功！ ";
	}

	public int countByColumnId(String columnId) throws Exception {
		List<String> list = this.getCommonDao().find(domain, "count", columnId);
		int c = Integer.parseInt(list.get(0));
		return c;
	}

	public List<Article> findByVertical(List<String> param, int start,
			int limit, String columnId) throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		return this.getCommonDao().find(domain, "findByVertical" + columnId,
				param, row);
	}

	public int countByVertical(List<String> param, String columnId)
			throws Exception {
		List<String> list = this.getCommonDao().find(domain,
				"countByVertical" + columnId, param);
		return Integer.parseInt(list.get(0));
	}

	public Page findWithBLOBs2(Article article, int start, int limit)
			throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Article> list = this.getCommonDao().find(domain, "findWithBLOBs2",
				article, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

	@Cacheable(value = "column", key = "#parentId")
	public List<Column> listColumnByParent(String parentId) throws Exception {
		List<Column> list = this.getCommonDao().find(domain,
				"listColumnByParent", parentId);
		return list;
	}

	public List<Article> findWithoutIndex() throws Exception {
		List<Article> list = this.getCommonDao().find(domain,
				"findWithoutIndex", "");
		return list;
	}

	public void updateIndex(String articleId) throws Exception {
		this.getCommonDao().update(domain, "updateIndex", articleId);

	}

	// 判断抓取的文章是否已经存在
	public int countByTitle(String title) throws Exception {
		List<Integer> list = this.getCommonDao().find(domain, "countByTitle",
				title);
		return list.get(0);
	}

	public List<Article> getByColumnId(String columnId) throws Exception {
		List<Article> list = this.getCommonDao().find(domain, "getByColumnId",
				columnId);
		return list;
	}

	public Article findId(String columnId) throws Exception {
		List<Article> list = this.getCommonDao().find(domain, "findId",
				columnId);
		return list.size() > 0 ? list.get(0) : null;
	}

	// 附件功能
	public Appendix getAppendix(String id) throws Exception {
		List<Appendix> list = this.getCommonDao().find(domain, "getAppendix",
				id);
		return list.size() > 0 ? list.get(0) : null;
	}

	public Appendix getAppendixByArticleId(String articleId) throws Exception {
		List<Appendix> list = this.getCommonDao().find(domain,
				"getAppendixByArticleId", articleId);
		return list.size() > 0 ? list.get(0) : null;
	}

	public Page findAppendix(Appendix appendix, int start, int limit)
			throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Appendix> list = this.getCommonDao().find(domain, "findAppendix",
				appendix, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

	public String insertAppendix(Appendix appendix) throws Exception {
		this.getCommonDao().insert(domain, "insertAppendix", appendix);
		return "添加成功！ ";
	}

	public String updateAppendix(Appendix appendix) throws Exception {
		this.getCommonDao().update(domain, "updateAppendix", appendix);
		return "更新成功！ ";
	}

	public String deleteAppendix(String id) throws Exception {
		this.getCommonDao().delete(domain, "deleteAppendix", id);
		return "删除成功！ ";
	}

	public String deleteAll(String articleId) throws Exception {
		this.getCommonDao().delete(domain, "deleteAll", articleId);
		return "删除成功！ ";
	}

	public List<Appendix> listPath(String articleId) throws Exception {
		List<Appendix> list = this.getCommonDao().find(domain, "listPath",
				articleId);
		return list.size() > 0 ? list : null;
	}

	public void updateAppendix2(Map map) throws Exception {
		this.getCommonDao().update(domain, "updateAppendix2", map);

	}

	public Article getByPrimaryKey2(String wordPath) throws Exception {
		List<Article> list = this.getCommonDao().find(domain,
				"getByPrimaryKey2", wordPath);
		return list.size() > 0 ? list.get(0) : null;
	}

	public void deleteAppendix2(String articleId) throws Exception {
		this.getCommonDao().delete(domain, "deleteAppendix2", articleId);

	}

	public void updateState(String articleId) throws Exception {
		this.getCommonDao().update(domain, "updateState", articleId);

	}

	public void deleteAppendix3() throws Exception {
		this.getCommonDao().delete(domain, "deleteAppendix3", "");

	}

	public List<Appendix> listArticleId() throws Exception {
		List<Appendix> list = this.getCommonDao().find(domain, "findArticleId",
				"");
		return list.size() > 0 ? list : null;
	}

	public List<Appendix> listPath2(String articleId) throws Exception {
		List<Appendix> list = this.getCommonDao().find(domain, "listPath2",
				articleId);
		return list.size() > 0 ? list : null;
	}

	public List<Appendix> listPath3(String articleId) throws Exception {
		List<Appendix> list = this.getCommonDao().find(domain, "listPath3",
				articleId);
		return list;
	}

	public void updateState2(String articleId) throws Exception {
		this.getCommonDao().update(domain, "updateState2", articleId);

	}

	public int findState(String articleId) throws Exception {
		int state = 1;
		if (StringUtil.isNotEmpty(this.getCommonDao()
				.find(domain, "findState", articleId).toString())) {
			state = 0;
		}
		return state;
	}

	@Cacheable(value = "article", key = "#map")
	public List<Article> findByColumnId2(Map map, RowSelection row)
			throws Exception {
		List<Article> list = this.getCommonDao().find(domain,
				"findByColumnId2", map, row);
		return list;
	}

	public List<Article> findByColumnId3(String columnId) throws Exception {
		List<Article> list = this.getCommonDao().find(domain,
				"findByColumnId3", columnId);
		return list;
	}

	public void removeDuplicateArticles() throws Exception {
		this.getCommonDao().find(domain, "removeDuplicateArticles", "");
	}

	public List<Article> listMore(String id, RowSelection row) throws Exception {
		List<Article> list = this.getCommonDao().find(domain, "listMore", id,
				row);
		return list;
	}

	public String getCralerTaskState(String taskId) {
		try {
			List<String> list = this.getCommonDao().find(domain,
					"getCralerTaskState", taskId);
			return list.size() > 0 ? list.get(0) : null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public void setCralerTaskEnd(String taskId) {
		try {
			this.getCommonDao().update(domain, "setCralerTaskEnd", taskId);
		} catch (Exception e) {

		}
	}

	public void setCralerTaskStart(String taskId) {
		try {
			this.getCommonDao().update(domain, "setCralerTaskStart", taskId);
		} catch (Exception e) {

		}
	}

	public List<Article> findByPaging(Map map, RowSelection row)
			throws Exception {
		List<Article> list = this.getCommonDao().find(domain, "findByColumnId",
				map, row);
		return list;
	}
}
