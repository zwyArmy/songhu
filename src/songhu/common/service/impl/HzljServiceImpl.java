package songhu.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import songhu.common.pojo.Hzlj;
import songhu.common.service.HzljService;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

@Service("hzljService")
public class HzljServiceImpl extends CommonServiceImpl implements HzljService {

	private String domain = "hzlj";

	public Page find(Hzlj hzlj, RowSelection row) throws Exception {
		List<Hzlj> list = this.getCommonDao().find(domain, "find",
				hzlj, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}
	
    public String insert(Hzlj hzlj) throws Exception {
    	this.getCommonDao().insert(domain, "insert", hzlj);
		return "添加成功！";
    }
    
    public String update(Hzlj hzlj) throws Exception {
    	this.getCommonDao().update(domain, "update",
    			hzlj);
		return "更新成功！";
    }

    public String delete(String id) throws Exception {
    	this.getCommonDao().delete(domain, "delete", id);
		return "删除成功！ ";
    }

    public Hzlj getByPrimaryKey(String id) throws Exception {
    	List<Hzlj> list = this.getCommonDao().find(domain,
				"getByPrimaryKey", id);
		return list.size() > 0 ? list.get(0) : null;
    }
    
}