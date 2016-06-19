package songhu.system.service;

import java.util.List;

import com.weixin.core.model.Page;

import songhu.system.pojo.Column;
import songhu.system.vo.Tree;

public interface ColumnService {

	List<Tree> findByParent(String id) throws Exception;
	//插入
	String insert(Column column) throws Exception;
	//更改
	String update(Column column) throws Exception;
	//删除
	String delete(String id) throws Exception;
	
	Column  getById(String id) throws Exception;
	
	Page find(Column column,int start,int limit) throws Exception;
}
