package songhu.system.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.util.ConvertUtils;
import com.weixin.core.util.QMap;
import com.weixin.core.vo.User;

import songhu.system.pojo.Menu;
import songhu.system.service.MenuService;
import songhu.system.vo.Tree;
import songhu.system.vo.TreeCheck;
import songhu.system.vo.TreeMenu;

@Controller
@RequestMapping("/menuController")
public class MenuController extends BaseController {
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(params = "findByParent")
	@ResponseBody
	public List<TreeMenu> findByParent(String fbh) throws Exception {
		List<TreeMenu> list = this.menuService.findByParent(fbh);
		return list;
	}
	
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(Menu menu,String cz,String path) throws Exception {	
		if(cz.equals("1"))
			menuService.insert(menu);
		else if(cz.equals("2"))
			menuService.updateByPrimaryKeySelective(menu);
		AjaxJson j = new AjaxJson();
		QMap map = new QMap("path", path);
		j.setAttributes(map);
		return j;
	}
	
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(Menu menu, String path) throws Exception {
		menuService.deleteByPrimaryKey(menu);
		AjaxJson j = new AjaxJson();
		QMap map = new QMap("path", path);
		j.setAttributes(map);
		return j;
	}
	
	@RequestMapping(params = "get")
	@ResponseBody
	public AjaxJson get(Menu menu) throws Exception {
		Menu m = menuService.getByPrimaryKey(menu);
		AjaxJson j = new AjaxJson();
		j.setData(m);
		if(m==null){
			j.setSuccess(false);
		}
		return j;
	}
	
	@RequestMapping(params = "findByNode")
	@ResponseBody
	public List<Tree> findByNode(String fbh) throws Exception {
		User user = BaseController.getSessionUser();
		String czy = user.getUserId();
		fbh=fbh==null?"###":fbh;
		QMap map = new QMap("fbh",fbh,"czy",czy);
		List<Tree> list = this.menuService.findByNode(map);
		return list;
	}
	
	/**
	 * 岗位权限授权树（已授权checked:true,未授权checked:false）
	 */
	@RequestMapping(params = "findByGrant")
	@ResponseBody
	public List<TreeCheck> findByGrant(String fbh,String gw) throws Exception {
		User user = BaseController.getSessionUser();
		String czy = user.getUserId();
		String rightLevel = user.getRigthLevel();
		String dmCzy = rightLevel.equals("3")?null:czy;
		QMap map = new QMap("fbh",fbh,"gw",gw,"dmCzy",dmCzy);
		List<TreeCheck> list = this.menuService.findByGrant(map);
		return list;
	}
	
	/**
	 * 人员授权树（已授权checked:true,未授权checked:false）
	 */
	@RequestMapping(params = "findCzryForGw")
	@ResponseBody
	public List<TreeCheck> findCzryForGw(String fbh,String gw) throws Exception {
		if(!ConvertUtils.isEmpty(gw)){
			QMap map = new QMap("fbh",fbh,"gw",gw);
			List<TreeCheck> list = this.menuService.findCzryForGw(map);
			return list;
		}
		return null;
	}	

	/**
	 * 岗位授权树（已授权checked:true,未授权checked:false）
	 */
	@RequestMapping(params = "findGwForCzry")
	@ResponseBody
	public List<TreeCheck> findGwForCzry(String fbh,String czy) throws Exception {
		if(!ConvertUtils.isEmpty(czy)){
			QMap map = new QMap("fbh",fbh,"czy",czy);
			List<TreeCheck> list = this.menuService.findGwForCzry(map);
			return list;
		}
		return null;
	}	
	
	
	/**
	 * 已授权树
	 */
	@RequestMapping(params = "findWithQx")
	@ResponseBody
	public List<TreeCheck> findWithQx(String fbh,String gw,String qxlb) throws Exception {
		if(!ConvertUtils.isEmpty(gw)){
			QMap map = new QMap("fbh",fbh,"gw",gw,"qxlb",qxlb.equals("*")?"":qxlb);
			List<TreeCheck> list = this.menuService.findWithQx(map);
			return list;
		}
		return null;
	}
	
	/**
	 * 未授权树
	 */
	@RequestMapping(params = "findWithoutQx")
	@ResponseBody
	public List<TreeCheck> findWithoutQx(String fbh,String gw,String qxlb) throws Exception {
		if(!ConvertUtils.isEmpty(gw)){
			QMap map = new QMap("fbh",fbh,"gw",gw,"qxlb",qxlb.equals("*")?"":qxlb);
			List<TreeCheck> list = this.menuService.findWithoutQx(map);
			return list;
		}
		return null;
	}
	
	@RequestMapping(params = "findByNode2")
	@ResponseBody
	public List<Tree> findByNode2(String parentId) throws Exception {
		User user = BaseController.getSessionUser();
		String czy = user.getUserId();
		QMap map = new QMap("parentId",parentId,"czy",czy);
		List<Tree> list = this.menuService.findByNode2(map);
		return list;
	}
		
}
