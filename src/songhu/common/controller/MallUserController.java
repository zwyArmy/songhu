package songhu.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;
import com.weixin.core.dao.support.RowSelection;

import songhu.common.pojo.MallUser;
import songhu.common.service.MallUserService;
import songhu.util.RegexValidateUtil;

@Controller
@RequestMapping("/mallUserController")
public class MallUserController {
	@Autowired
	private MallUserService mallUserService;

	// 初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(MallUser mallUser, int start, int limit) throws Exception {
		RowSelection row = new RowSelection();
		row.setFirstRow(start);
		row.setFetchSize(limit);
		Page page = mallUserService.find(mallUser, row);
		return page;
	}

	// 新增或修改
	@RequestMapping(params = "insert", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson insert(MallUser mallUser) throws Exception {
		AjaxJson j = new AjaxJson();
		try {
			if(!RegexValidateUtil.checkEmail(mallUser.getEmail())){
				j.setSuccess(false);
				return j;
			}
			if(!RegexValidateUtil.checkCellphone(mallUser.getPhone()))
			{
				j.setSuccess(false);
				return j;
			}
			mallUserService.insert(mallUser);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.toString());
		}
		return j;
	}

	// 删除
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String id) throws Exception {
		AjaxJson j = new AjaxJson();
		try {
			j.setMsg(mallUserService.delete(id));
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.toString());
		}
		return j;
	}

}
