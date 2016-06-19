package songhu.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.common.pojo.Xyrz;
import songhu.common.service.XyrzService;

@Service("xyrzService")
@Transactional
public class XyrzServiceImpl extends CommonServiceImpl implements XyrzService {

	private String domain = "cmsXyrz";

	public String insert(Xyrz xyrz) throws Exception {
		this.getCommonDao().insert(domain, "insert", xyrz);
		return "添加成功！";
	}

	public String update(Xyrz xyrz) throws Exception {
		this.getCommonDao().update(domain, "updateByPrimaryKeySelective", xyrz);
		return "更新成功！";
	}

	public String delete(String id) throws Exception {
		this.getCommonDao().delete(domain, "deleteByPrimaryKey", id);
		return "删除成功！ ";
	}

	public Xyrz getByPrimaryKey(String id) throws Exception {
		List<Xyrz> list = this.getCommonDao().find(domain, "getByPrimaryKey",
				id);
		return list.size() > 0 ? list.get(0) : null;
	}

	public Page find(Xyrz xyrz, RowSelection row) throws Exception {
		List<Xyrz> list = this.getCommonDao().find(domain, "find", xyrz, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

}
