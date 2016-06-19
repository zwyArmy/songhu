package songhu.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.common.pojo.MallUser;
import songhu.common.service.MallUserService;

@Service("mallUserService")
@Transactional
public class MallUserServiceImpl extends CommonServiceImpl implements
		MallUserService {

	private String domain = "mallUser";

	public String insert(MallUser mallUser) throws Exception {
		this.getCommonDao().insert(domain, "insert", mallUser);
		return "添加成功！";
	}

	public String update(MallUser mallUser) throws Exception {
		this.getCommonDao().update(domain, "updateByPrimaryKeySelective",
				mallUser);
		return "更新成功！";
	}

	public String delete(String id) throws Exception {
		this.getCommonDao().delete(domain, "deleteByPrimaryKey", id);
		return "删除成功！ ";
	}

	public MallUser getByPrimaryKey(String id) throws Exception {
		List<MallUser> list = this.getCommonDao().find(domain,
				"getByPrimaryKey", id);
		return list.size() > 0 ? list.get(0) : null;
	}

	public Page find(MallUser mallUser, RowSelection row) throws Exception {
		List<MallUser> list = this.getCommonDao().find(domain, "find",
				mallUser, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

}
