package songhu.common.controller;

import java.io.File;

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
import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;
import com.weixin.core.util.SystemPath;

import songhu.common.pojo.Ad;
import songhu.common.service.AdService;
import songhu.util.Extool;

@Controller
@RequestMapping("/adController")
public class AdController extends BaseController {
	@Autowired
	private AdService adService;

	// 初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(Ad ad, int start, int limit) throws Exception {

		Page page = adService.find(ad, start, limit);
		return page;
	}

	// 新增或修改
	@RequestMapping(params = "save", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson save(Ad ad, String cz, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String msg = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获得文件：
		MultipartFile file = multipartRequest.getFile("myUpload");
		if (file.getSize() > 0) {
			// 获得文件名：
			String filename = file.getOriginalFilename();
			String path = "";
			if (ad.getColumnId().endsWith("18")) {
				path = SystemPath.getSysPath() + "excms/hot/";
			} else {
				path = SystemPath.getSysPath() + "excms/ad/";
			}
			String localfilename = Extool.getRandName() + "."
					+ FileUtils.getFileExtension(filename);
			// 写入文件
			File source = new File(path + localfilename);
			file.transferTo(source);
			// 删除旧文件
			File old = new File(path + ad.getPicPath());
			old.delete();
			ad.setPicPath(localfilename);
		}

		AjaxJson j = new AjaxJson();
		if (cz.equals("1")) {
			Ad a = adService.get(ad);
			if (a == null)
				msg = adService.insert(ad);
			else {
				msg = "位置编码已存在！";
				j.setSuccess(false);
			}
		} else {
			msg = adService.update(ad);
		}
		j.setMsg(msg);
		return j;
	}

	// 删除
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String id, String picPath) throws Exception {
		this.adService.delete(id);
		String path = "";
		path = SystemPath.getSysPath() + "excms/hot/";
		File old1 = new File(path + picPath);
		old1.delete();
		path = SystemPath.getSysPath() + "excms/ad/";
		File old2 = new File(path + picPath);
		old2.delete();
		AjaxJson j = new AjaxJson();
		return j;
	}
}
