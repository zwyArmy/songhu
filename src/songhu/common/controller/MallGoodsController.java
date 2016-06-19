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
import com.weixin.core.util.StringUtil;
import com.weixin.core.util.SystemPath;
import com.weixin.core.vo.User;
import com.weixin.core.dao.support.RowSelection;

import songhu.common.pojo.MallGoods;
import songhu.common.service.MallGoodsService;
import songhu.util.Extool;

@Controller
@RequestMapping("/mallGoodsController")
public class MallGoodsController extends BaseController {
	@Autowired
	private MallGoodsService mallGoodsService;

	// 初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(MallGoods mallGoods, int start, int limit)
			throws Exception {
		RowSelection row = new RowSelection();
		row.setFirstRow(start);
		row.setFetchSize(limit);
		Page page = mallGoodsService.find(mallGoods, row);
		return page;
	}

	// 新增或修改
	@RequestMapping(params = "save", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson save(MallGoods mallGoods, String cz,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String msg = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获得文件：
		MultipartFile file = multipartRequest.getFile("myUpload");
		User user = BaseController.getSessionUser();
		AjaxJson j = new AjaxJson();
		try {
			if (file.getSize() > 0) {
				// 获得文件名：
				String filename = file.getOriginalFilename();
				String path = "";
				path = SystemPath.getSysPath() + "songhu/goods/";
				String localfilename = Extool.getRandName() + "."
						+ FileUtils.getFileExtension(filename);
				// 写入文件
				File source = new File(path + localfilename);
				file.transferTo(source);
				// 删除旧文件
				if (StringUtil.isNotEmpty(mallGoods.getPicture())) {
					File old = new File(path + mallGoods.getPicture());
					old.delete();
				}
				mallGoods.setPicture(localfilename);
			}
			if (cz.equals("1")) {
				msg = mallGoodsService.insert(mallGoods);
			} else {
				msg = mallGoodsService.update(mallGoods);
			}
		} catch (Exception e) {
			msg = e.toString();
			j.setSuccess(false);
		}
		j.setMsg(msg);
		return j;
	}

	// 删除
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String id, String picture) throws Exception {
		mallGoodsService.delete(id);
		File old = new File(SystemPath.getSysPath() + "songhu/goods/" + picture);
		old.delete();
		AjaxJson j = new AjaxJson();
		return j;
	}

	@RequestMapping(params = "xgzt")
	@ResponseBody
	public AjaxJson xgzt(MallGoods mallGoods) throws Exception {
		AjaxJson j = new AjaxJson();
		String msg = "";
		try {
			msg = mallGoodsService.update(mallGoods);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.toString();
			j.setSuccess(false);
		}
		j.setMsg(msg);
		return j;
	}
}
