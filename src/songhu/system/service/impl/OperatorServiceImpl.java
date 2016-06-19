package songhu.system.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;
import com.weixin.core.vo.User;

import songhu.system.pojo.Operator;
import songhu.system.service.OperatorService;
import songhu.system.vo.RoleOperator;

import net.sf.json.JSONObject;

@Service("operatorService")
@Transactional
public class OperatorServiceImpl extends CommonServiceImpl implements OperatorService {
	private String domain = "Operator";

	//显示初始化信息及查找
	@SuppressWarnings("unchecked")
	public Page find(Operator operator, int start, int limit) throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Operator> list = this.getCommonDao().find(domain, "find", operator, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}
	//插入
	@SuppressWarnings("unchecked")
	public String insert(Operator operator) throws Exception {
		if(!this.checkDm(operator)){
		    this.getCommonDao().insert(domain, "insert", operator);
            return "操作成功！ ";
		}else{
			return "已经存在重复人员代码,请重新输入! ";
		}    
	}
	//检查插入是否有已存在
	private boolean checkDm(Operator operator) throws Exception{
		List<String> list = this.getCommonDao().find(domain, "checkDm", operator);
		if(list.size()>0)
			return true;
		else
			return false;
		
	}
	//获取
	public Operator getByPrimaryKey(String dmCzy) throws Exception {
		List<Operator> list = this.getCommonDao().find(domain, "getByPrimaryKey", dmCzy);
		return list.size()>0?list.get(0):null;
	}
	//更改
	@SuppressWarnings("unchecked")
	public String updateByPrimaryKeySelective(Operator operator) throws Exception {
		this.getCommonDao().update(domain, "updateByPrimaryKeySelective", operator);
        return "操作成功！ ";
	}
	//删除
	public int deleteByPrimaryKey(String dmCzy) throws Exception {
        int row = this.getCommonDao().delete(domain, "deleteByPrimaryKey1", dmCzy);
        this.getCommonDao().delete(domain, "deleteByPrimaryKey2", dmCzy);
        return row;
	}

	public User checkUserExits(Operator operator) throws Exception {
		List<User> list = this.getCommonDao().find(domain, "checkUserExits", operator);
		return list.size()>0?list.get(0):null;
	}

	//判断账号是否有设置岗位
	public boolean isSetRole(Map map) throws Exception {
		List<String> list = this.getCommonDao().find(domain, "isSetRole", map);
		return !list.get(0).equals("0");
	}
   
}