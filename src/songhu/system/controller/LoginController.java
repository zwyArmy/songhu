package songhu.system.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weixin.core.constant.Global;
import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.util.ContextHolderUtils;
import com.weixin.core.util.PasswordUtil;
import com.weixin.core.util.QMap;
import com.weixin.core.vo.SessionInfo;
import com.weixin.core.vo.User;

import songhu.system.pojo.Operator;
import songhu.system.service.OperatorService;
import songhu.util.aop.MethodLog;

/**
 * 登陆初始化控制器
 * 
 * 
 */
@Controller
@RequestMapping("/loginController")
public class LoginController extends BaseController {
	@Autowired
	private OperatorService operatorService;
	/**
	 * 用户登录
	 * @param operator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params = "login")
	@ResponseBody
	@MethodLog(remark = "会员新增") 
	public AjaxJson login(Operator operator) throws Exception {
		HttpSession session = ContextHolderUtils.getSession();
		AjaxJson j = new AjaxJson();
		String user = operator.getDmCzy();
		String password = operator.getKl();
		byte[] salt = PasswordUtil.getStaticSalt();
		String ciphertext = PasswordUtil.encrypt(user, password, salt);
		operator.setKl(ciphertext);
		User u = operatorService.checkUserExits(operator);
		if (u != null) {
			SessionInfo sessionInfo = new SessionInfo();
			sessionInfo.setUser(u);
			session.setMaxInactiveInterval(60 * 30);
			session.setAttribute(Global.USER_SESSION, sessionInfo);
			QMap map = new QMap("userId",u.getUserId());
			j.setAttributes(map);
		} else {
			j.setMsg("用户名或密码错误!");
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 退出系统
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "logout")
	@ResponseBody
	public AjaxJson logout(HttpServletRequest request) {
		HttpSession session = ContextHolderUtils.getSession();
		// 判断用户是否为空不为空则清空session中的用户object
		session.removeAttribute(Global.USER_SESSION);// 注销该操作用户
		AjaxJson j = new AjaxJson();
		return j;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)  
	public String loginForm(){
		return "/back/login";
	}
}
