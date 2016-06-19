package songhu.system.controller;

import java.lang.management.ManagementFactory;
import java.net.InetAddress;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.util.QMap;
import com.sun.management.OperatingSystemMXBean;

import songhu.system.pojo.Httpsession;
import songhu.system.service.HttpsessionService;

@Controller
@RequestMapping("/httpsessionController")
public class HttpsessionController extends BaseController {
	@Autowired
	private HttpsessionService httpsessionService;
	private Httpsession httpsession;
	
	@RequestMapping(params = "find")
	public void find(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String jsondata = this.httpsessionService.find(httpsession, start, limit);
		write(jsondata , response);
	}
	
	@RequestMapping(params = "serverInfo")
	@ResponseBody
	public AjaxJson serverInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QMap serverInfo = new QMap(); 
		OperatingSystemMXBean osmxb = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
		InetAddress localhost = InetAddress.getLocalHost();
		ServletContext servletContext = request.getSession().getServletContext(); 
		
		serverInfo.put("a.操作系统",System.getProperty("os.name") + "_" + System.getProperty("os.arch"));
		serverInfo.put("b.主机IP",""+localhost.getHostAddress());
		serverInfo.put("c.应用服务器", servletContext.getServerInfo());
		serverInfo.put("d.监听端口", ""+request.getServerPort());
		serverInfo.put("e.Web根路径", servletContext.getRealPath("/"));
		serverInfo.put("f.Servlet版本", servletContext.getMajorVersion() + "."
				+ servletContext.getMinorVersion());
		serverInfo.put("g.JVM版本", System.getProperty("java.version"));
		serverInfo.put("h.JVM提供商", System.getProperty("java.vendor"));
		serverInfo.put("i.JVM安装路径", System.getProperty("java.home"));
		serverInfo.put("j.主机物理内存", osmxb.getTotalPhysicalMemorySize() / 1024 / 1024 + "M");
		serverInfo.put("k.JVM可用最大内存", Runtime.getRuntime().maxMemory() / 1024 / 1024 + "M");
		AjaxJson j = new AjaxJson();
		j.setAttributes(serverInfo);
		return j;
	}
	
	public Httpsession getHttpsession() {
		return httpsession;
	}

	public void setHttpsession(Httpsession httpsession) {
		this.httpsession = httpsession;
	}
	
}
