package songhu.common.service;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;

import songhu.common.pojo.Hzlj;

public interface HzljService {
Page find(Hzlj hzlj, RowSelection row) throws Exception;
	
    String insert(Hzlj hzlj) throws Exception;

    String update(Hzlj hzlj) throws Exception;

    String delete(String id) throws Exception;

    Hzlj getByPrimaryKey(String id) throws Exception;
}