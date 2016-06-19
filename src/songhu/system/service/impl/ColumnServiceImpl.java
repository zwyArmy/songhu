package songhu.system.service.impl;

import java.util.List;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.system.pojo.Column;
import songhu.system.pojo.Depart;
import songhu.system.service.ColumnService;
import songhu.system.vo.Tree;


@Service("columnService")
@Transactional
public class ColumnServiceImpl extends CommonServiceImpl  implements ColumnService {

	private String domain = "Column";
	@CacheEvict(value="column",allEntries=true)
	public String delete(String id) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().delete(domain,"deleteByPrimaryKey",id);
		return "删除成功！ ";
	}

	public Page find(Column column, int start, int limit) throws Exception {
		// TODO Auto-generated method stub
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Column> list = this.getCommonDao().find(domain, "find", column, row);
		Page page =  new Page(row.getTotalRows(),list);
		return page;
	}
	
	public List<Tree> findByParent(String id) throws Exception {
		// TODO Auto-generated method stub
		List<Tree> list = this.getCommonDao().find(domain, "findByParent", id);
		return list;
	}

	public Column getById(String id) throws Exception {
		// TODO Auto-generated method stub
		List<Column> list = this.getCommonDao().find(domain, "getByPrimaryKey", id);
		return list.size()>0?list.get(0):null;
	}
	@CacheEvict(value="column",allEntries=true)
	public String insert(Column column) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().insert(domain,"insert",column);
		return "添加成功！ ";
	}
	@CacheEvict(value="column",allEntries=true)
	public String update(Column column) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().update(domain,"updateByPrimaryKeySelective",column);
		return "更新成功！ ";
	}

}
