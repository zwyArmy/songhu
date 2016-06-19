package songhu.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;
import com.weixin.core.util.StringUtil;

import songhu.system.pojo.Column;
import songhu.system.service.ColumnService;
import songhu.system.vo.Tree;
import songhu.system.service.MenuService;
import songhu.system.pojo.Menu;
@Controller
@RequestMapping("/columnController")
public class ColumnController extends BaseController {

	@Autowired
	private ColumnService columnService;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(params = "findByParent")
	@ResponseBody
	public List<Tree> findByParent(String id)throws Exception{
		List<Tree> list = columnService.findByParent(id);
		return list;	
	}
	
	//新增或修改
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(Column column,String cz) throws Exception{
		AjaxJson j = new AjaxJson();
		String msg="";
		try{
		if(cz.equals("1"))
	    {   
			
			msg = columnService.insert(column);
	    }else{
	    	msg = columnService.update(column);
	    	Menu menu = new Menu();
	    	menu.setBhCd(column.getId());
	    	menu.setMc(column.getColName());
	    	menuService.updateByPrimaryKeySelective(menu); 	
	    }}catch(Exception e){
	    	msg = e.toString();
	    	j.setSuccess(false);
	    }
		j.setMsg(msg);
		return j;
	}
	
	//获取
	@RequestMapping(params = "get")
	@ResponseBody
	public AjaxJson get(String id) throws Exception{
		Column g = this.columnService.getById(id);
		AjaxJson j = new AjaxJson();
		j.setData(g);
		return j;
	}
	//删除
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String gwList) throws Exception{
		String[] tmp = gwList.split(",");
		for(int i=0,len=tmp.length;i<len;i++){
			this.columnService.delete(tmp[i]);
		}
		AjaxJson j = new AjaxJson();
	    return j;
	}
	
	//初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(Column column,int start,int limit) throws Exception{
		Page page=columnService.find(column, start, limit);
		return page;
	}
}
