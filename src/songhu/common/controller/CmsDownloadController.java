package songhu.common.controller;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ckfinder.connector.utils.FileUtils;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;
import com.weixin.core.util.SystemPath;
import com.weixin.core.vo.User;
import com.weixin.core.controller.BaseController;
import com.weixin.core.dao.support.RowSelection;

import songhu.common.pojo.CmsDownload;
import songhu.common.service.CmsDownloadService;

@Controller
@RequestMapping("/cmsDownloadController")
public class CmsDownloadController extends BaseController{
	@Autowired
	private CmsDownloadService cmsDownloadService;

	// 初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(CmsDownload cmsDownload, int start, int limit) throws Exception {
		RowSelection row = new RowSelection();
		row.setFirstRow(start);
		row.setFetchSize(limit);
		Page page = cmsDownloadService.find(cmsDownload, row);
		return page;
	}

	// 新增
	@RequestMapping(params = "insert", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson insert(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		AjaxJson j = new AjaxJson();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("myUpload");
			if (file.getSize() > 0) {
				String filename = file.getOriginalFilename();
				String path = SystemPath.getSysPath().replace("%20", " ")
						+ "songhu/download/";
				String nm = java.util.UUID.randomUUID().toString();
				String hz = FileUtils.getFileExtension(filename).toLowerCase();
				String localfilename = nm + "." + hz;
				File source = new File(path + localfilename);
				file.transferTo(source);
				CmsDownload cmsDownload = new CmsDownload();
				cmsDownload.setPath(localfilename);
				cmsDownload.setMc(filename.split("/.")[0]);
				cmsDownload.setformat(hz);
				cmsDownload.setScsj(new Date());
				User user = BaseController.getSessionUser();
				cmsDownload.setScry(user.getUserId());
				cmsDownload.setState("0");
				cmsDownloadService.insert(cmsDownload);
			}
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
		}
		return j;
	}

	// 删除
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String id,String path) throws Exception {
		AjaxJson j = new AjaxJson();
		try {
			j.setMsg(cmsDownloadService.delete(id));
			File f = new File(SystemPath.getSysPath().replace("%20", " ")
					+ "songhu/download/"+path);
			f.delete();
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.toString());
		}
		return j;
	}
	
}
