package songhu.system.service;

import java.util.List;

import com.weixin.core.model.Page;

import songhu.system.pojo.Setting;

public interface SettingService {
	//更改
	String update(Setting setting) throws Exception;
	//获取
	Setting  get(String key) throws Exception;
	//查找
	Page find(Setting setting,int start,int limit) throws Exception;
	
	List<Setting> getSetting(String key) throws Exception;

}
