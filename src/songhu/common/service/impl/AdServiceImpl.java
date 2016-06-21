package songhu.common.service.impl;

import java.util.List;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.common.pojo.Ad;
import songhu.common.service.AdService;

@Service("adService")
@Transactional
public class AdServiceImpl extends CommonServiceImpl implements AdService {

	private String domain = "cmsAd";
	

	@CacheEvict(value = "ad", allEntries = true)
	public String delete(String id) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().delete(domain, "deleteByPrimaryKey", id);
		return "删除成功！ ";
	}

	public Page find(Ad ad, int start, int limit) throws Exception {
		// TODO Auto-generated method stub
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Ad> list = this.getCommonDao().find(domain, "find", ad, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

	public Ad get(Ad ad) throws Exception {
		// TODO Auto-generated method stub
		List<Ad> list = this.getCommonDao().find(domain, "getByPrimaryKey", ad);
		return list.size() > 0 ? list.get(0) : null;
	}

	@CacheEvict(value = "ad", allEntries = true)
	public String insert(Ad ad) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().insert(domain, "insert", ad);
		return "添加成功！";
	}

	@CacheEvict(value = "ad", allEntries = true)
	public String update(Ad ad) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().update(domain, "updateByPrimaryKeySelective", ad);
		return "更新成功！";
	}

	@Cacheable(value = "ad", key = "#columnId")
	public List listByColumnId(String columnId) throws Exception {
		List<Ad> list = this.getCommonDao().find(domain, "listByColumnId",
				columnId);
		return list;
	}

}
