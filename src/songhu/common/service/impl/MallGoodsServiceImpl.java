package songhu.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.common.pojo.MallGoods;
import songhu.common.service.MallGoodsService;

@Service("mallGoodsService")
@Transactional
public class MallGoodsServiceImpl extends CommonServiceImpl implements
		MallGoodsService {

	private String domain = "mallGoods";

	public String insert(MallGoods mallGoods) throws Exception {
		this.getCommonDao().insert(domain, "insert", mallGoods);
		return "添加成功！";
	}

	public String update(MallGoods mallGoods) throws Exception {
		this.getCommonDao().update(domain, "updateByPrimaryKeySelective",
				mallGoods);
		return "更新成功！";
	}

	public String delete(String id) throws Exception {
		this.getCommonDao().delete(domain, "deleteByPrimaryKey", id);
		return "删除成功！ ";
	}

	public MallGoods getByPrimaryKey(String id) throws Exception {
		List<MallGoods> list = this.getCommonDao().find(domain,
				"getByPrimaryKey", id);
		return list.size() > 0 ? list.get(0) : null;
	}

	public Page find(MallGoods mallGoods, RowSelection row) throws Exception {
		List<MallGoods> list = this.getCommonDao().find(domain, "find",
				mallGoods, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

}
