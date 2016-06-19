package songhu.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import songhu.common.pojo.Hzlj;
import songhu.common.service.HzljService;

import com.weixin.core.controller.BaseController;
import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;

@Controller
@RequestMapping("/hzljController")
public class HzljController extends BaseController {
	@Autowired
	private HzljService hzljService;
	
	// 初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(Hzlj hzlj, int start, int limit) throws Exception {
		RowSelection row = new RowSelection();
		row.setFirstRow(start);
		row.setFetchSize(limit);
		Page page = hzljService.find(hzlj, row);
		return page;
	}
	
	// 新增或修改
	@RequestMapping(params = "save", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson save(Hzlj hzlj, String cz) throws Exception {
		AjaxJson j = new AjaxJson();
		String msg = "";
		try {
			if (cz.equals("1")) {
				msg = hzljService.insert(hzlj);
			} else {
				msg = hzljService.update(hzlj);
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.toString();
			j.setSuccess(false);
		}
		j.setMsg(msg);
		return j;
	}
	
	// 删除
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String id) throws Exception {
		AjaxJson j = new AjaxJson();
		String msg = "";
		msg = hzljService.delete(id);
		j.setMsg(msg);
		return j;
	}
	
	@RequestMapping(params = "xgzt")
	@ResponseBody
	public AjaxJson xgzt(Hzlj hzlj) throws Exception {
		AjaxJson j = new AjaxJson();
		String msg = "";
		try {
			msg = hzljService.update(hzlj);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.toString();
			j.setSuccess(false);
		}
		j.setMsg(msg);
		return j;
	}
	
}
