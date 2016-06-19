package songhu.common.service;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;

import songhu.common.pojo.Xyrz;

public interface XyrzService {
	String insert(Xyrz xyrz) throws Exception;

	String update(Xyrz xyrz) throws Exception;

	String delete(String id) throws Exception;

	Xyrz getByPrimaryKey(String id) throws Exception;

	Page find(Xyrz xyrz, RowSelection row) throws Exception;
}