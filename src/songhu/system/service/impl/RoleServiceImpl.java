package songhu.system.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.system.pojo.Operator;
import songhu.system.pojo.Role;
import songhu.system.service.RoleService;

@Service("roleService")
@Transactional
public class RoleServiceImpl extends CommonServiceImpl implements RoleService {
	private String domain = "gGw";
	public int deleteByPrimaryKey(String dmGw) throws Exception {
		int i = this.getCommonDao().delete(domain, "deleteByPrimaryKey1", dmGw);
		this.getCommonDao().delete(domain, "deleteByPrimaryKey2", dmGw);
		this.getCommonDao().delete(domain, "deleteByPrimaryKey3", dmGw);
		return i;
	}

	public Page find(Role role, int start, int limit) throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Operator> list = this.getCommonDao().find(domain, "find", role, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

	public Role getByPrimaryKey(String dmGw) throws Exception {
		List<Role> list = this.getCommonDao().find(domain, "getByPrimaryKey", dmGw);
		return list.size()>0?list.get(0):null;
	}

	public void insert(Role role) throws Exception {
		this.getCommonDao().insert(domain, "insert", role);
	}

	public int updateByPrimaryKey(Role role) throws Exception {
		int i = getCommonDao().update(domain, "updateByPrimaryKey", role);
		return i;
	}

	public int updateByPrimaryKeySelective(Role role) throws Exception {
		int i = getCommonDao().update(domain, "updateByPrimaryKeySelective", role);
		return i;
	}

	public int deleteGwqx(Map map) throws Exception {
		int i = getCommonDao().delete(domain, "deleteGwqx", map);
		return i;
	}

	public void insertGwqx(Map map) throws Exception {
		getCommonDao().insert(domain, "insertGwqx", map);
		
	}
	
	public int deleteCzrygw(Map map) throws Exception {
		int i = getCommonDao().delete(domain, "deleteCzrygw", map);
		return i;
	}

	public void insertCzrygw(Map map) throws Exception {
		getCommonDao().insert(domain, "insertCzrygw", map);
	}

	public Page find2(Role role, int start, int limit) throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Operator> list = this.getCommonDao().find(domain, "find2", role, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

}
