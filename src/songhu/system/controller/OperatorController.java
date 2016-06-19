package songhu.system.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;
import com.weixin.core.util.PasswordUtil;
import com.weixin.core.util.StringUtil;
import com.weixin.core.vo.User;

import songhu.system.pojo.Operator;
import songhu.system.service.OperatorService;

@Controller
@RequestMapping("/operatorController")
public class OperatorController extends BaseController{
	@Autowired
	private OperatorService operatorService;
	
	
	//初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(HttpServletResponse response, Operator operator) throws Exception {
		Page page = operatorService.find(operator, start, limit);
		return page;
	}
	//新增
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(Operator operator,String cz) throws Exception {
		String msg="";
		if(!StringUtil.isEmpty(operator.getKl())) {
			byte[] salt = PasswordUtil.getStaticSalt();
			String user = operator.getDmCzy();
			String password = operator.getKl();
			String ciphertext = PasswordUtil.encrypt(user, password, salt);
			operator.setKl(ciphertext);
		}
		if(cz.equals("1")){//新增
			msg = operatorService.insert(operator);
		}else{
			msg = operatorService.updateByPrimaryKeySelective(operator);
		}
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}
	//删除
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String dmCzy) throws Exception {
		this.operatorService.deleteByPrimaryKey(dmCzy);
		AjaxJson j = new AjaxJson();
		return j;
	}

	//删除
	@RequestMapping(params = "updatePwd")
	@ResponseBody
	public AjaxJson updatePwd(String account, String kl, String password) throws Exception {
		AjaxJson j = new AjaxJson();
		Operator o = new Operator();
		byte[] salt = PasswordUtil.getStaticSalt();
		String ciphertext = PasswordUtil.encrypt(account, kl, salt);
		o.setDmCzy(account);
		o.setKl(ciphertext);
		User u = operatorService.checkUserExits(o);
		if(u == null){
			j.setMsg("旧密码有误！");
			j.setSuccess(false);
		}else{
			ciphertext = PasswordUtil.encrypt(account, password, salt);
			o.setKl(ciphertext);
			operatorService.updateByPrimaryKeySelective(o);
			j.setMsg("密码保存更改成功！下次登录请使用新密码。");
		}
		return j;
		
	}
}
