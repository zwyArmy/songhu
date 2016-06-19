package songhu.system.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;

import songhu.system.pojo.Setting;
import songhu.system.service.SettingService;
import songhu.util.SendMsg;
@Controller
@RequestMapping("/settingController")
public class SettingController extends BaseController {

	@Autowired
	private SettingService settingService;
	//新增或修改
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(Setting setting) throws Exception{
		String msg="";	
	    msg = settingService.update(setting);
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}
	
	//获取
	@RequestMapping(params = "get")
	@ResponseBody
	public AjaxJson get(String key) throws Exception{
		AjaxJson j = new AjaxJson();
		try{
		Setting g = this.settingService.get(key);
		j.setData(g);
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg(e.toString());
		}
		return j;
	}
	//初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(Setting setting,int start,int limit) throws Exception{
		Page page=settingService.find(setting, start, limit);
		return page;
	}
	@RequestMapping(params = "sendMsg")
	@ResponseBody
	public void sendMsg(String mobile,String content) throws Exception{
		SendMsg msg = new SendMsg();
		msg.sendSM(mobile,java.net.URLDecoder.decode(content,"utf-8"));
	}
}
