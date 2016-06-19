package songhu.util.aop;

import java.lang.reflect.Array;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


/**
 * \
 * 
 * @Aspect 实现spring aop 切面（Aspect）：
 *         一个关注点的模块化，这个关注点可能会横切多个对象。事务管理是J2EE应用中一个关于横切关注点的很好的例子。 在Spring
 *         AOP中，切面可以使用通用类（基于模式的风格） 或者在普通类中以 @Aspect 注解（@AspectJ风格）来实现。
 * 
 *         AOP代理（AOP Proxy）： AOP框架创建的对象，用来实现切面契约（aspect contract）（包括通知方法执行等功能）。
 *         在Spring中，AOP代理可以是JDK动态代理或者CGLIB代理。 注意：Spring
 *         2.0最新引入的基于模式（schema-based
 *         ）风格和@AspectJ注解风格的切面声明，对于使用这些风格的用户来说，代理的创建是透明的。
 * @author q
 * 
 */
@Component
@Aspect
public class LogService {

	public LogService() {
		System.out.println("Aop");
	}

	/**
	 * 在Spring
	 * 2.0中，Pointcut的定义包括两个部分：Pointcut表示式(expression)和Pointcut签名(signature
	 * )。让我们先看看execution表示式的格式：
	 * 括号中各个pattern分别表示修饰符匹配（modifier-pattern?）、返回值匹配（ret
	 * -type-pattern）、类路径匹配（declaring
	 * -type-pattern?）、方法名匹配（name-pattern）、参数匹配（(param
	 * -pattern)）、异常类型匹配（throws-pattern?），其中后面跟着“?”的是可选项。
	 * 
	 * @param point
	 * @throws Throwable
	 */

	@Pointcut("@annotation(excms.util.aop.MethodLog)")
	public void methodCachePointcut() {

	}

	// // @Before("execution(* com.wssys.controller.*(..))")
	// public void logAll(JoinPoint point) throws Throwable {
	// System.out.println("打印========================");
	// }
	//
	// // @After("execution(* com.wssys.controller.*(..))")
	// public void after() {
	// System.out.println("after");
	// }

	@Before("execution(* excms.system.controller.*.*(..))")
	public void beforeMethod(JoinPoint joinPoint) throws Exception {
		String temp = joinPoint.getStaticPart().toShortString();
		String longTemp = joinPoint.getStaticPart().toLongString();
		joinPoint.getStaticPart().toString();
		String classType = joinPoint.getTarget().getClass().getName();
		String methodName = temp.substring(10, temp.length() - 1);
		Class<?> className = Class.forName(classType);
		Class[] args = new Class[joinPoint.getArgs().length];
		String[] sArgs = (longTemp.substring(longTemp.lastIndexOf("(") + 1,
				longTemp.length() - 2)).split(",");
		for (int i = 0; i < args.length; i++) {
			if (sArgs[i].endsWith("String[]")) {
				args[i] = Array.newInstance(Class.forName("java.lang.String"),
						1).getClass();
			} else if (sArgs[i].endsWith("Long[]")) {
				args[i] = Array.newInstance(Class.forName("java.lang.Long"), 1)
						.getClass();
			} else if (sArgs[i].indexOf(".") == -1) {
				if (sArgs[i].equals("int")) {
					args[i] = int.class;
				} else if (sArgs[i].equals("char")) {
					args[i] = char.class;
				} else if (sArgs[i].equals("float")) {
					args[i] = float.class;
				} else if (sArgs[i].equals("long")) {
					args[i] = long.class;
				}
			} else {
				args[i] = Class.forName(sArgs[i]);
			}
		}
		Method method = className.getMethod(
				methodName.substring(methodName.indexOf(".") + 1,
						methodName.indexOf("(")), args);

	}
	
	
	// 方法执行的前后调用
	@Around("execution(* excms.system.controller.*.*(..))")
	//@Around("execution(* excms.common.controller.*(..))")
	// @Around("execution(* org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter.handle(..))")
	//@Around("methodCachePointcut()")
	public Object around(ProceedingJoinPoint point) throws Throwable {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss E");
		Calendar ca = Calendar.getInstance();
		String operDate = df.format(ca.getTime());

		String methodRemark = getMthodRemark(point);
		String methodName = point.getSignature().getName();
		String packages = point.getThis().getClass().getName();
		if (packages.indexOf("$$EnhancerByCGLIB$$") > -1) { // 如果是CGLIB动态生成的类
			try {
				packages = packages.substring(0, packages.indexOf("$$"));
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		String operatingcontent = "";
		Object[] method_param = null;

		Object object;
		try {
			method_param = point.getArgs();	//获取方法参数 
			// String param=(String) point.proceed(point.getArgs());
			object = point.proceed();
		} catch (Exception e) {
			// 异常处理记录日志..log.error(e);
			throw e;
		}
		Syslog sysLog = new Syslog();
		sysLog.setIpAddress("127.0.0.1");
		sysLog.setLoginName("test");
		sysLog.setMethodName(packages + "." + methodName);
		sysLog.setMethodRemark(methodRemark);
		sysLog.setOperDate(operDate);
		//这里有点纠结 就是不好判断第一个object元素的类型 只好通过  方法描述来 做一一  转型感觉 这里 有点麻烦 可能是我对 aop不太了解  希望懂的高手在回复评论里给予我指点
		//有没有更好的办法来记录操作参数  因为参数会有 实体类 或者javabean这种参数怎么把它里面的数据都解析出来?
		/*if (StringUtil.stringIsNull(monthRemark).equals("会员新增")) {
			PusFrontUser pfu = (PusFrontUser) method_param[0];
			sysLog.setOperatingcontent("新增会员:" + pfu.getAccount());
		} else if (StringUtil.stringIsNull(monthRemark).equals("新增角色")) {
			PusRole pr = (PusRole) method_param[0];
			sysLog.setOperatingcontent("新增角色:" + pr.getName());
		} else if (StringUtil.stringIsNull(monthRemark).equals("用户登录")) {
			PusSysUser currUser = (PusSysUser) method_param[0];
			sysLog.setOperatingcontent("登录帐号:" + currUser.getAccount());
		} else if (StringUtil.stringIsNull(monthRemark).equals("用户退出")) {
			sysLog.setOperatingcontent("具体请查看用户登录日志");
		} else if (StringUtil.stringIsNull(monthRemark).equals("角色名称修改")) {
			PusRole pr = (PusRole) method_param[0];
			sysLog.setOperatingcontent("修改角色:" + pr.getName());
		} else if (StringUtil.stringIsNull(monthRemark).equals("新增后台用户")) {
			PusSysUser psu = (PusSysUser) method_param[0];
			sysLog.setOperatingcontent("新增后台用户:" + psu.getAccount());
		} else if (StringUtil.stringIsNull(monthRemark).equals("更新菜单")) {
			PusMenu pm = (PusMenu) method_param[0];
			sysLog.setOperatingcontent("更新菜单:" + pm.getName());
		} else if (StringUtil.stringIsNull(monthRemark).equals("保存菜单")) {
			PusMenu pm = (PusMenu) method_param[0];
			sysLog.setOperatingcontent("保存菜单:" + pm.getName());
		} else if (StringUtil.stringIsNull(monthRemark).equals("修改公司")) {
			ComPanyForm ciform = (ComPanyForm) method_param[0];
			sysLog.setOperatingcontent("修改公司:" + ciform.getName());
		} else if (StringUtil.stringIsNull(monthRemark).equals("联系人更新")) {
			Companycontacts ct = (Companycontacts) method_param[0];
			sysLog.setOperatingcontent("联系人更新:" + ct.getName());
		} else if (StringUtil.stringIsNull(monthRemark).equals("修改货物")) {
			GoodsForm goodsForm = (GoodsForm) method_param[0];
			sysLog.setOperatingcontent("修改货物（货物id/编号）:" + goodsForm.getId());
		} else if (StringUtil.stringIsNull(monthRemark).equals("打印出库单")) {
			DeliverBean owh= (DeliverBean) method_param[0];
			sysLog.setOperatingcontent("出库单单号:" + owh.getCknum());
		} else if (StringUtil.stringIsNull(monthRemark).equals("打印提单")) {
			BolBean bol= (BolBean) method_param[0];
			sysLog.setOperatingcontent("提货单号:" + bol.getBolnum());
		} else if (StringUtil.stringIsNull(monthRemark).equals("系统左侧菜单查询")) {
			sysLog.setOperatingcontent("无");
		} else {
			sysLog.setOperatingcontent("操作参数:" + method_param[0]);
		}

		syslogDao.save(sysLog);*/
		System.out.println("==================="+sysLog.getMethodRemark());
		return object;
	}

	// 方法运行出现异常时调用	
	// @AfterThrowing(pointcut = "execution(* com.wssys.controller.*(..))",
	// throwing = "ex")
	public void afterThrowing(Exception ex) {
		System.out.println("afterThrowing");
		System.out.println(ex);
	}

	// 获取方法的中文备注____用于记录用户的操作日志描述
	public static String getMthodRemark(ProceedingJoinPoint joinPoint)
			throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();

		Class targetClass = Class.forName(targetName);
		Method[] method = targetClass.getMethods();
		String methode = "";
		for (Method m : method) {
			if (m.getName().equals(methodName)) {
				Class[] tmpCs = m.getParameterTypes();
				if (tmpCs.length == arguments.length) {
					MethodLog methodCache = m.getAnnotation(MethodLog.class);
					if (methodCache != null) {
						methode = methodCache.remark();
					}
					break;
				}
			}
		}
		return methode;
	}


}


