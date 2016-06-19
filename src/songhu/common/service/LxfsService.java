package songhu.common.service;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;

import songhu.common.pojo.Lxfs;

public interface LxfsService {
	Page find(Lxfs lxfs, RowSelection row) throws Exception;
	
    String insert(Lxfs lxfs) throws Exception;

    String update(Lxfs lxfs) throws Exception;

    String delete(String id) throws Exception;

    Lxfs getByPrimaryKey(String id) throws Exception;
}