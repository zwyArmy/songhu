package songhu.system.service;

import java.util.List;

import com.weixin.core.model.Page;

import songhu.system.pojo.Depart;
import songhu.system.vo.Tree;

public interface DepartService {

	List<Tree> findByParent(String id) throws Exception;
	//插入
	String insert(Depart depart) throws Exception;
	//更改
	String update(Depart depart) throws Exception;
	//删除
	String delete(String id) throws Exception;
	
	Depart  getById(String id) throws Exception;
	
	Page find(Depart depart,int start,int limit) throws Exception;
}
