package songhu.common.service;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;

import songhu.common.pojo.MallUser;

public interface MallUserService {
	String insert(MallUser mallUser) throws Exception;

	String update(MallUser mallUser) throws Exception;

	String delete(String id) throws Exception;

	MallUser getByPrimaryKey(String id) throws Exception;

	Page find(MallUser mallUser, RowSelection row) throws Exception;
}