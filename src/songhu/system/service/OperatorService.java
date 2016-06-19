package songhu.system.service;

import java.util.Map;

import com.weixin.core.model.Page;
import com.weixin.core.vo.User;

import songhu.system.pojo.Operator;


public interface OperatorService {
	//查找
	Page find(Operator operator, int start, int limit) throws Exception;
	//插入
	String insert(Operator operator) throws Exception;
	//获取
	Operator getByPrimaryKey(String dmCzy) throws Exception;
	//更改
	String updateByPrimaryKeySelective(Operator operator) throws Exception;
	//删除
	int deleteByPrimaryKey(String dmCzy) throws Exception;

	User checkUserExits(Operator operator) throws Exception;
	
	boolean isSetRole(Map map) throws Exception;
}
