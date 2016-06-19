package songhu.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import songhu.common.pojo.Lxfs;
import songhu.common.service.LxfsService;

import com.weixin.core.controller.BaseController;
import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;

@Controller
@RequestMapping("/lxfsController")
public class LxfsController extends BaseController {
	@Autowired
	private LxfsService lxfsService;
	
	// 初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(Lxfs lxfs, int start, int limit) throws Exception {
		RowSelection row = new RowSelection();
		row.setFirstRow(start);
		row.setFetchSize(limit);
		Page page = lxfsService.find(lxfs, row);
		return page;
	}
	
	// 修改
	@RequestMapping(params = "update", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson update(Lxfs lxfs, String cz) throws Exception {
		AjaxJson j = new AjaxJson();
		String msg = "";
		try {
			msg = lxfsService.update(lxfs);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.toString();
			j.setSuccess(false);
		}
		j.setMsg(msg);
		return j;
	}
	
	@RequestMapping(params = "xgzt")
	@ResponseBody
	public AjaxJson xgzt(Lxfs lxfs) throws Exception {
		AjaxJson j = new AjaxJson();
		String msg = "";
		try {
			msg = lxfsService.update(lxfs);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.toString();
			j.setSuccess(false);
		}
		j.setMsg(msg);
		return j;
	}
	
}
