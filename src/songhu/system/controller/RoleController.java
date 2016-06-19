package songhu.system.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;
import com.weixin.core.util.ConvertUtils;
import com.weixin.core.util.QMap;

import songhu.system.pojo.Role;
import songhu.system.service.RoleService;

@Controller
@RequestMapping("/roleController")
public class RoleController extends BaseController {
	@Autowired
	private RoleService roleService;

	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(HttpServletResponse response, Role role) throws Exception {
		if(role.getDmBm().equals("001")){
			Page page = roleService.find2(role, start, limit);
			return page;
		}else{
		Page page = roleService.find(role, start, limit);
		    return page;
		}
	}
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(Role role,String cz) throws Exception {
		if(cz.equals("1")){//新增
			this.roleService.insert(role);
		}else{
			this.roleService.updateByPrimaryKey(role);
		}
		AjaxJson j = new AjaxJson();
		return j;
	}
	
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String gwList) throws Exception {
		AjaxJson j = new AjaxJson();
		String[] tmp = gwList.split(",");
		try{
		for(int i=0,len=tmp.length;i<len;i++){
			this.roleService.deleteByPrimaryKey(tmp[i]);
		}}catch(Exception e){
			j.setMsg(e.toString());
		}
		
		return j;
	}
	
	
	/**
	 * 更新岗位权限
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params = "updateGwqx")
	@ResponseBody
	public AjaxJson updateGwqx(String gw,String qx) throws Exception {
		QMap map = new QMap("gw",gw,"qx",null);
		AjaxJson j = new AjaxJson();
		try{
		this.roleService.deleteGwqx(map);
		String[] tmp = qx.split(",");
		for(int i=0,len=tmp.length;i<len;i++){
			if(!ConvertUtils.isEmpty(tmp[i])){
				QMap map1 = new QMap("gw",gw,"qx",tmp[i]);
				this.roleService.insertGwqx(map1);
			}
		}}catch(Exception e){
			j.setMsg(e.toString());
		}
		
		return j;		
	}
	
	
	/**
	 * 更新操作人员岗位
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params = "updateCzrygw")
	@ResponseBody
	public AjaxJson updateCzrygw(String gwList,String czy) throws Exception {
		QMap map = new QMap("gw",null,"czy",czy);
		this.roleService.deleteCzrygw(map);
		String[] tmp = gwList.split(",");
		for(int i=0,len=tmp.length;i<len;i++){
			if(!ConvertUtils.isEmpty(tmp[i])){
				QMap map1 = new QMap("czy",czy,"gw",tmp[i]);
				this.roleService.insertCzrygw(map1);
			}
		}
		AjaxJson j = new AjaxJson();
		return j;		
	}

}
