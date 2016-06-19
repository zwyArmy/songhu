package songhu.system.service.impl;

import java.util.List;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.system.pojo.Setting;
import songhu.system.service.SettingService;



@Service("settingService")
@Transactional
public class SettingServiceImpl extends CommonServiceImpl implements SettingService {

	private String domain ="gSetting";
	public Page find(Setting setting, int start, int limit) throws Exception {
		// TODO Auto-generated method stub
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Setting> list = this.getCommonDao().find(domain, "find",setting ,row);
		Page page =  new Page(row.getTotalRows(),list);
		return page;
	}
	
	public Setting get(String key) throws Exception {
		// TODO Auto-generated method stub
		List<Setting> list = this.getCommonDao().find(domain, "getByPrimaryKey", key);
		return list.size()>0?list.get(0):null;
	}
	@CacheEvict(value="article",allEntries=true)
	public String update(Setting setting) throws Exception {
		// TODO Auto-generated method stub
		this.getCommonDao().update(domain,"updateByPrimaryKeySelective",setting);
		return "更新成功！ ";
	}

	@Cacheable(value = "default",key="#key")  
	public List<Setting> getSetting(String key) throws Exception {
		List<Setting> list = this.getCommonDao().find(domain, "getByPrimaryKey",key);
		return list;
	}

}
