package songhu.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import songhu.common.pojo.Lxfs;
import songhu.common.service.LxfsService;

import com.weixin.core.service.impl.CommonServiceImpl;
import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;

@Service("lxfsService")
public class LxfsServiceImpl extends CommonServiceImpl implements LxfsService {

	private String domain = "lxfs";

	public Page find(Lxfs lxfs, RowSelection row) throws Exception {
		List<Lxfs> list = this.getCommonDao().find(domain, "find",
				lxfs, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}
	
    public String insert(Lxfs lxfs) throws Exception {
    	this.getCommonDao().insert(domain, "insert", lxfs);
		return "添加成功！";
    }
    
    public String update(Lxfs lxfs) throws Exception {
    	this.getCommonDao().update(domain, "update",
    			lxfs);
		return "更新成功！";
    }

    public String delete(String id) throws Exception {
    	this.getCommonDao().delete(domain, "delete", id);
		return "删除成功！ ";
    }

    public Lxfs getByPrimaryKey(String id) throws Exception {
    	List<Lxfs> list = this.getCommonDao().find(domain,
				"getByPrimaryKey", id);
		return list.size() > 0 ? list.get(0) : null;
    }


}