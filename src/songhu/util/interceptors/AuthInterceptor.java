package songhu.util.interceptors;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.weixin.core.constant.Global;
import com.weixin.core.util.ContextHolderUtils;
import com.weixin.core.vo.SessionInfo;

import songhu.util.Extool;


/**
 * 权限拦截器
 * 
 * @author
 * 
 */
public class AuthInterceptor implements HandlerInterceptor {
	 
	private static final Logger logger = Logger.getLogger(AuthInterceptor.class);
	private List<String> excludeUrls;

	public List<String> getExcludeUrls() {
		return excludeUrls;
	}

	public void setExcludeUrls(List<String> excludeUrls) {
		this.excludeUrls = excludeUrls;
	}

	/**
	 * 在controller后拦截
	 */
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, Exception exception) throws Exception {
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object object, ModelAndView modelAndView) throws Exception {

	}

	/**
	 * 在controller前拦截
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
		String requestPath = Extool.getRequestPath(request);// 用户访问的资源地址
		HttpSession session = ContextHolderUtils.getSession();
		SessionInfo sessioninfo = (SessionInfo) session.getAttribute(Global.USER_SESSION);

		if(contain(excludeUrls,requestPath)){
			return true;
		} else {
			if (sessioninfo != null && sessioninfo.getUser()!=null ) {
				
				//----------------------------------------------------------------
				//update-start--Author:邢双阳  Date:20130525 for[105]：菜单权限控制
				//----------------------------------------------------------------
				/*
				 
				 if(!hasMenuAuth(request)){
					 response.sendRedirect("loginController.do?noAuth");
					//request.getRequestDispatcher("webpage/common/noAuth.jsp").forward(request, response);
					return false;
				} 
				//----------------------------------------------------------------
				//update-end--Author:邢双阳  Date:20130525 for[105]：菜单权限控制
				//----------------------------------------------------------------
				
				
				//----------------------------------------------------------------
				//update-start--Author:anchao  Date:20130415 for：按钮权限控制
				//----------------------------------------------------------------
				String functionId=oConvertUtils.getString(request.getParameter("clickFunctionId"));
				if(!oConvertUtils.isEmpty(functionId)){
					Set<String> operationCodes = systemService.getOperationCodesByUserIdAndFunctionId(sessioninfo.getUser().getId(), functionId);
					request.setAttribute("operationCodes", operationCodes);
				 
				}*/
				//----------------------------------------------------------------
				//update-end--Author:anchao  Date:20130415 for：按钮权限控制
				//----------------------------------------------------------------
				return true;
			} else {
				//update-begin--Author:anchao  Date:20130325 for：session 失效跳转
				//forword(request);
				//update-end--Author:anchao  Date:20130325 for：session 失效跳转
				//update-begin--Author:zhaojunfu  Date:20130330 for：session 失效跳转(要进行2次跳转，才能将主页面一起跳转)
				forward(request, response);
				return false;
				//update-end--Author:zhaojunfu  Date:20130330 for：session 失效跳转(要进行2次跳转，才能将主页面一起跳转)
				//throw new SessionTimeoutException();
			}

		}
		// String requestPath = ContextHolderUtils.getRequestPath(request);// 用户访问的资源地址
		/*
		 * if (sessionInfo == null) {// 没有登录系统，或登录超时 forward("您没有登录或登录超时，请重新登录！", request, response); return false; }
		 */
		/*
		 * String requestPath = ContextHolderUtils.getRequestPath(request);// 用户访问的资源地址
		 * 
		 * List<TFunction> functions=systemService.findByProperty(TFunction.class,"functionurl",requestPath); if ( functions.size()<1) { forward("请修复数据库！数据库缺失【" + requestPath + "】资源！", request, response); return false; } TUser user = sessionInfo.getUser();
		 * 
		 * // 验证当前用户是否有权限访问此资源 List<TFunction> loginActionlist = new ArrayList();//已有权限菜单 List<TRoleUser> TRoleUsers=user.getTRoleUsers(); for (TRoleUser ru:TRoleUsers) { TRole role =ru.getTRole(); Set<TRoleFunction> roleFunctionList=role.getTRoleFunctions(); if(roleFunctionList.size()>0){ for(TRoleFunction roleFunction :roleFunctionList) { TFunction function=(TFunction)roleFunction.getTFunction(); loginActionlist.add(function); } } } boolean b=false; if (loginActionlist.size()>0) { for (TFunction f:loginActionlist) { if(f.getFunctionurl().equals(requestPath)){ b = true; break; } } if (b) { return true;// 当前访问资源地址是不需要验证的资源 } }else{ forward("您没有【" + requestPath + "】权限，请联系管理员给您赋予相应权限！", request, response); return false; }
		 */
	}
	//update-start--Author:邢双阳  Date:20130525 for[105]：菜单权限控制
	/*private boolean hasMenuAuth(HttpServletRequest request){
		 
		String requestPath = ResourceUtil.getRequestPath(request);// 用户访问的资源地址
		//update-start--Author:邢双阳  Date:20130528 for：菜单权限控制排除Ajax请求判断
		String funcid=oConvertUtils.getString(request.getParameter("clickFunctionId"));
		 
		if(requestPath.indexOf("loginController.do")!=-1||funcid.length()==0){
			return true;
		} 
		//update-start--Author:邢双阳  Date:20130528 for：菜单权限控制排除Ajax请求判断
		SessionInfo sessioninfo = (SessionInfo) ContextHolderUtils.getSession().getAttribute(Globals.USER_SESSION);
		String userid = sessioninfo.getUser().getId();
		//requestPath=requestPath.substring(0, requestPath.indexOf("?")+1);
		String sql = "SELECT DISTINCT f.id FROM t_s_function f,t_s_role_function  rf,t_s_role_user ru " +
				" WHERE f.id=rf.functionid AND rf.roleid=ru.roleid AND " +
				"ru.userid='"+userid+"' AND f.functionurl like '"+requestPath+"%'"; 
		List list = this.systemService.findListbySql(sql);
		if(list.size()==0){
			return false;
		}else{
			return true;
		}
		 
	}*/
	//update-end--Author:邢双阳  Date:20130525 for[105]：菜单权限控制
	/**
	 * 转发
	 * 
	 * @param user
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "forword")
	public ModelAndView forword(HttpServletRequest request) {

		return new ModelAndView(new RedirectView("loginController.do?login"));
	}

	private void forward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//update-begin--Author:zhaojunfu  Date:20130330 for：session 失效跳转(要进行2次跳转，才能将主页面一起跳转)
		//request.getRequestDispatcher("back/login.jsp").forward(request, response);
		//update-end--Author:zhaojunfu  Date:20130330 for：session 失效跳转(要进行2次跳转，才能将主页面一起跳转)
		String ctxPath = request.getContextPath();
		String requestUri = request.getRequestURI();
		String uri = requestUri.substring(ctxPath.length());
		if (request.getHeader("x-requested-with") != null
				&& request.getHeader("x-requested-with").equalsIgnoreCase(
						"XMLHttpRequest")) {
			response.setHeader("sessionstatus", "timeout");
		} else {
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			int n = count(uri, '/');
			String depth = "";
			for (int i = 1; i < n; i++)
				depth += "../";
			String out = "<link rel=\"stylesheet\" type=\"text/css\" href=\"" + depth + "resource/extjs/resources/css/ext-all.css\" />\n";
			out += "<script type=\"text/javascript\" src=\"" + depth + "resource/extjs/adapter/ext/ext-base.js\"></script>\n";
			out += "<script type=\"text/javascript\" src=\"" + depth + "resource/extjs/ext-all.js\"></script>\n";
			out += "<script type=\"text/javascript\" src=\"" + depth + "resource/extjs/src/locale/ext-lang-zh_CN.js\"></script>\n";
			out += "<script type=\"text/javascript\">Ext.onReady(function(){"
					+ "Ext.QuickTips.init();"
					+ "Ext.Msg.alert('提示','会话超时,请求已被强制重定向到了登录页面... ', function(btn, text){"
					+ "if (btn == 'ok'){"
					+ (uri.equals("/back/complex.jsp") ? "document.location.href='"
							: "getRootWin().location.href='")
					+ ctxPath
					+ "/back/';"
					+ "}"
					+ "});"
					+ "});"
					+ "function getRootWin(){"
					+ "var win = window; "
					+ "while (win != win.parent){"
					+ "win = win.parent;"
					+ "return win; }}" 
					+ "</script>";
			response.getWriter().write(out);
			response.getWriter().flush();
			response.getWriter().close();
		}
	}
	
	private static int count(String string, char character) {
		int n = 0;
		for (int i = 0; i < string.length(); i++)
			if (string.charAt(i) == character)
				n++;

		return n;
	}

	
	private static boolean contain(List<String> list, String wd){
		for(int i=0, len = list.size(); i < len; i++ ){
			if(wd.indexOf(list.get(i))>-1){
				return true;
			}
		}
		return false;
	}

}
