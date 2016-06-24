package songhu.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import songhu.system.service.SettingService;

public class StartOnLoadService {
	public static Map<String,List> dictionaryInfoMap = new HashMap<String, List>();
	public static Map<String,String> parameterMap = new HashMap<String, String>();
	
	@Autowired
	private SettingService settingService;	
	
	public void loadData() {
		try{
			String webemail = settingService.get("webemail").getValue();
			parameterMap.put("webemail", webemail);
			
			String emailpwd = settingService.get("emailpwd").getValue();
			parameterMap.put("emailpwd", emailpwd);		
			
			String webaddress = settingService.get("webaddress").getValue();
			parameterMap.put("webaddress", webaddress);	
			
			String webphone = settingService.get("webphone").getValue();
			parameterMap.put("webphone", webphone);
			
		}catch(Exception e){
			
		}
	}
}
