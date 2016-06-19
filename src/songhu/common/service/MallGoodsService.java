package songhu.common.service;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;

import songhu.common.pojo.MallGoods;

public interface MallGoodsService {
	String insert(MallGoods mallGoods) throws Exception;

	String update(MallGoods mallGoods) throws Exception;

	String delete(String id) throws Exception;

	MallGoods getByPrimaryKey(String id) throws Exception;

	Page find(MallGoods mallGoods, RowSelection row) throws Exception;
}