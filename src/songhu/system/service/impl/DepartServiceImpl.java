package songhu.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;
import songhu.system.pojo.Depart;
import songhu.system.service.DepartService;
import songhu.system.vo.Tree;

@Service("departService")
@Transactional
public class DepartServiceImpl extends CommonServiceImpl implements
		DepartService {
	private String domain = "Depart";
	
	public List<Tree> findByParent(String id) throws Exception {
		List<Tree> list = this.getCommonDao().find(domain, "findByParent", id);
		return list;
	}

	public String insert(Depart depart) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().insert(domain,"insert",depart);
		return "添加成功！ ";
	}

	public String update(Depart depart) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().update(domain,"updateByPrimaryKeySelective",depart);
		return "更新成功！ ";
	}

	public String delete(String id) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().delete(domain,"deleteByPrimaryKey",id);
		return "删除成功！ ";
	}

	public Depart getById(String id) throws Exception {
		// TODO Auto-generated method stub
		List<Depart> list = this.getCommonDao().find(domain, "getByPrimaryKey", id);
		return list.size()>0?list.get(0):null;
	}

	public Page find(Depart depart, int start, int limit) throws Exception {
		// TODO Auto-generated method stub
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Depart> list = this.getCommonDao().find(domain, "find", depart, row);
		Page page =  new Page(row.getTotalRows(),list);
		return page;
	}

}
