package songhu.system.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;
import com.weixin.core.util.QMap;

import songhu.common.pojo.Ad;
import songhu.system.pojo.Code;
import songhu.system.service.CodeService;
import songhu.system.vo.TreeCode;

@Controller
@RequestMapping("/codeController")
public class CodeController extends BaseController {
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(params = "findByParent")
	@ResponseBody
	public List<TreeCode> findByParent(String zldm) throws Exception {
		List<TreeCode> list = new ArrayList<TreeCode>();
		if(zldm.indexOf("xnode")==0){
			list = this.codeService.findZldm();
		}
		else{
			list = this.codeService.findByZldm(zldm);
		}
		return list;
	}
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(Code code,int start,int limit) throws Exception{
		
		Page page=codeService.find(code, start, limit);
		return page;
	}
	@RequestMapping(params = "findBytoZldm")
	@ResponseBody
	public Page findBytoZldm(String zldm,int start,int limit) throws Exception{
		
		Page page=codeService.findBytoZldm(zldm, start, limit);
		return page;
	}
	
	@RequestMapping(params = "insertZldm")
	@ResponseBody
	public AjaxJson insertZldm(Code code) throws Exception {
		String msg="";
		msg = this.codeService.insertZldm(code);
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}
	
	@RequestMapping(params = "updateZldm")
	@ResponseBody
	public AjaxJson updateZldm(Code code) throws Exception {
		String msg="";
		msg = this.codeService.updateZldm(code);
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}
	@RequestMapping(params = "deleteZldm")
	@ResponseBody
	public AjaxJson deleteZldm(String zldm) throws Exception {
		String msg="";
		msg= this.codeService.deleteZldm(zldm);
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}
	@RequestMapping(params = "insert")
	@ResponseBody
	public AjaxJson insert(Code code) throws Exception {
		String msg="";
		msg = this.codeService.insert(code);
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}
	@RequestMapping(params = "update")
	@ResponseBody
	public AjaxJson update(Code code) throws Exception {
		String msg="";
		msg = this.codeService.updateByPrimaryKeySelective(code);
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(Code code) throws Exception {
		String msg="";
		msg= this.codeService.deleteByPrimaryKey(code);
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}
}
