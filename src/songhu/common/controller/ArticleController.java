package songhu.common.controller;

import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;
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
import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;
import com.weixin.core.util.QMap;
import com.weixin.core.util.SystemPath;
import com.weixin.core.util.Tools;
import com.weixin.core.vo.User;
import com.weixin.core.util.StringUtil;

import songhu.common.pojo.Appendix;
import songhu.common.pojo.Article;
import songhu.common.service.ArticleService;
import songhu.util.Extool;
import songhu.util.ImageScale;

@Controller
@RequestMapping("/articleController")
public class ArticleController extends BaseController {
	@Autowired
	private ArticleService articleService;

	@RequestMapping(params = "listByColumnId")
	@ResponseBody
	public List<Article> listByColumnId(String columnId, int start, int limit)
			throws Exception {
		QMap map = new QMap("columnId", columnId);
		RowSelection row = new RowSelection();
		row.setFirstRow(start);
		row.setFetchSize(limit);
		List<Article> list = this.articleService.findByColumnId(map, row);
		return list;
	}

	@RequestMapping(params = "getByArticleId")
	@ResponseBody
	public Article getByArticleId(String id) throws Exception {
		Article article = this.articleService.getById(id);
		return article;
	}

	// 初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(Article article, int start, int limit) throws Exception {
		Page page = articleService.find(article, start, limit);
		return page;
	}

	// 新增或修改
	@RequestMapping(params = "save", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson save(Article article, String cz, String sjc,
			String isPhoto, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		AjaxJson j = new AjaxJson();
		try {
			String msg = "";
			if (isPhoto != null && isPhoto.equals("true")) {
				String path = SystemPath.getSysPath();
				String imgurl = Extool.getImageURL(article.getContent());
				if (null != imgurl) {
					//imgurl = imgurl.substring(imgurl.indexOf("songhu")+6);

					BufferedImage image1 = ImageIO
							.read(new File(path , imgurl));
					ImageScale is = new ImageScale();
					BufferedImage image2 = is.imageZoomOut(image1, 360, 260);
					String ext = FileUtils.getFileExtension(imgurl);
					String filename = Extool.getRandName() + "." + ext;
					ImageIO.write(image2, ext, new File(path
							, "userfiles/images/thumbs/" + filename));

					// 首页幻灯片
					BufferedImage image3 = is.imageZoomOut(image1, 331, 306);
					ImageIO.write(image3, ext, new File(path
							, "userfiles/images/slide/" + filename));
					article.setTnPath(filename);
				}

			}
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			// 获得文件：
			MultipartFile file = multipartRequest.getFile("myUpload");
			if (StringUtil.isNotEmpty(file)) {
				if (file.getSize() > 0) {
					// 获得文件名：
					String filename = file.getOriginalFilename();
					String path = SystemPath.getSysPath() + "songhu/article/";
					String localfilename = Extool.getRandName() + "."
							+ FileUtils.getFileExtension(filename);
					// 写入文件
					File source = new File(path + localfilename);
					file.transferTo(source);
					article.setWordPath(localfilename);
					article.setFilename(file.getOriginalFilename().split("/.")[0]);
				}
			}
			User user = BaseController.getSessionUser();
			if (cz.equals("1")) {// 新增
				article.setState("1");
				article.setCreator(user.getUserId());
				article.setSummary(Tools.getTextFromHtml(article.getContent(),
						200));
				article.setWordPath(sjc);
				msg = articleService.insert(article);
				Article article2 = new Article();
				article2 = articleService.getByPrimaryKey2(sjc);
				QMap map = new QMap("articleId", article2.getId(), "sjc", sjc);
				articleService.updateAppendix2(map);
				articleService.updateState(article2.getId());
			} else {
				if (article.getState().equals("1")) {
					article.setAuditTime(new Date());
					article.setAuditor(user.getUserId());
				}
				if (StringUtil.isNotEmpty(article.getWordPath())) {
					String path2 = SystemPath.getSysPath() + "songhu/article/";
					File old = new File(path2 + article.getWordPath());
					old.delete();
				}
				article.setSummary(Tools.getTextFromHtml(article.getContent(),
						200));
				msg = articleService.updateBLOBs(article);
				articleService.updateState(article.getId());
			}
			j.setMsg(msg);
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("操作失败，请联系系统管理员<br>错误代码：" + e.toString());
		}
		return j;
	}

	@RequestMapping(params = "update")
	@ResponseBody
	public AjaxJson update(Article article) throws Exception {
		String msg = articleService.updateBLOBs(article);
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}

	// 更新summary
	@RequestMapping(params = "updateSummary")
	@ResponseBody
	public AjaxJson updateSummary() throws Exception {
		List<Article> list = articleService.findWithBLOBs();
		for (int i = 0, len = list.size(); i < len; i++) {
			Article a = new Article();
			a.setSummary(Tools.getTextFromHtml(list.get(i).getContent(), 200));
			a.setId(list.get(i).getId());
			articleService.updateBLOBs(a);
		}
		AjaxJson j = new AjaxJson();
		j.setMsg("Success!");
		return j;
	}

	// 获取
	@RequestMapping(params = "get")
	@ResponseBody
	public AjaxJson get(String id) throws Exception {
		Article a = this.articleService.getById(id);
		AjaxJson j = new AjaxJson();
		j.setData(a);
		return j;
	}

	// 删除
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String id) throws Exception {
		Article a = this.articleService.getById(id);
		this.articleService.delete(a);
		String f = a.getTnPath();
		String path = SystemPath.getSysPath() + "songhu/article/";
		if (StringUtil.isNotEmpty(a.getWordPath())) {
			File Wordold = new File(path + a.getWordPath());
			Wordold.delete();
		}
		String path1 = SystemPath.getSysPath() + "userfiles/images/thumbs/";
		String path2 = SystemPath.getSysPath() + "userfiles/images/slide/";
		File old = new File(path1 + f);
		old.delete();
		File old1 = new File(path2 + f);
		old1.delete();
		AjaxJson j = new AjaxJson();
		j.setData(a);
		// 删除附件
		try {
			List<Appendix> list = articleService.listPath(id);
			for (int i = 0; i < list.size(); i++) {
				File old3 = new File(SystemPath.getSysPath()
						+ "songhu/article/appendix/" + list.get(i).getPath());
				old3.delete();
			}
			articleService.deleteAll(id);
		} catch (Exception e) {
		}
		return j;
	}

	@RequestMapping(params = "find2")
	@ResponseBody
	public Page find2(Article article, int start, int limit) throws Exception {
		Page page = articleService.findWithBLOBs2(article, start, limit);
		return page;
	}

	@RequestMapping(params = "download")
	@ResponseBody
	public void download(String id, HttpServletResponse response)
			throws IOException {
		OutputStream os = response.getOutputStream();
		try {
			Article g = articleService.getById(id);
			String fileName = g.getFilename() + "."
					+ FileUtils.getFileExtension(g.getWordPath());
			fileName = new String(fileName.getBytes("gbk"), "iso8859-1");
			String path = SystemPath.getSysPath() + "excms/article/";
			File f = new File(path + g.getWordPath());
			if (f != null) {
				FileInputStream fis = new FileInputStream(f);
				if (fis != null) {
					int len = fis.available();
					byte[] data = new byte[len];
					fis.read(data);
					response.reset();
					response.setHeader("Content-Disposition",
							"attachment; filename=\"" + fileName + "\"");
					response.addHeader("Content-Length", "" + data.length);
					response.setContentType("application/octet-stream;charset=UTF-8");
					OutputStream outputStream = new BufferedOutputStream(os);
					outputStream.write(data);
					outputStream.flush();
					outputStream.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (os != null) {
				os.close();
			}
		}
	}

	@RequestMapping(params = "download1")
	@ResponseBody
	public void download1(String id, HttpServletResponse response)
			throws IOException {
		OutputStream os = response.getOutputStream();
		try {
			Appendix g = articleService.getAppendixByArticleId(id);
			String fileName = g.getFilename();
			fileName = new String(fileName.getBytes("gbk"), "iso8859-1");
			String path = SystemPath.getSysPath() + "excms/letter/";
			File f = new File(path + g.getPath());
			if (f != null) {
				FileInputStream fis = new FileInputStream(f);
				if (fis != null) {
					int len = fis.available();
					byte[] data = new byte[len];
					fis.read(data);
					response.reset();
					response.setHeader("Content-Disposition",
							"attachment; filename=\"" + fileName + "\"");
					response.addHeader("Content-Length", "" + data.length);
					response.setContentType("application/octet-stream;charset=UTF-8");
					OutputStream outputStream = new BufferedOutputStream(os);
					outputStream.write(data);
					outputStream.flush();
					outputStream.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (os != null) {
				os.close();
			}
		}
	}

	@RequestMapping(params = "findAppendix")
	@ResponseBody
	public Page find(Appendix appendix, int start, int limit) throws Exception {
		Page page = articleService.findAppendix(appendix, start, limit);
		return page;
	}

	@RequestMapping(params = "deleteAppendix")
	@ResponseBody
	public AjaxJson deleteAppendix(String id, String path, String cz,
			String articleId) throws Exception {
		AjaxJson j = new AjaxJson();
		try {
			articleService.deleteAppendix(id);
			if (cz.equals("0")) {
				articleService.updateState2(articleId);
			}
			File old = new File(SystemPath.getSysPath()
					+ "songhu/article/appendix/" + path);
			old.delete();
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("删除失败!");
		}
		return j;
	}

	@RequestMapping(params = "deleteAll")
	@ResponseBody
	public AjaxJson deleteAll(String articleId, String cz) throws Exception {
		AjaxJson j = new AjaxJson();
		try {

			List<Appendix> list = articleService.listPath(articleId);
			for (int i = 0; i < list.size(); i++) {
				File old = new File(SystemPath.getSysPath()
						+ "songhu/article/appendix/" + list.get(i).getPath());
				old.delete();
			}
			articleService.deleteAll(articleId);
			if (cz.equals("0")) {
				articleService.updateState2(articleId);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("删除失败!");
		}
		return j;
	}

	@RequestMapping(params = "updateAppendix", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson updateAppendix(Appendix appendix,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获得文件：
		MultipartFile file = multipartRequest.getFile("myUpload");
		if (StringUtil.isNotEmpty(file)) {
			if (file.getSize() > 0) {
				// 获得文件名：
				String filename = file.getOriginalFilename();
				String path = SystemPath.getSysPath()
						+ "songhu/article/appendix/";
				String localfilename = Extool.getRandName() + "."
						+ FileUtils.getFileExtension(filename);
				// 写入文件
				File source = new File(path + localfilename);
				file.transferTo(source);
				appendix.setPath(localfilename);
				appendix.setFilename(file.getOriginalFilename().split("/.")[0]);
			}
		}
		if (StringUtil.isNotEmpty(appendix.getPath())) {
			String path2 = SystemPath.getSysPath() + "songhu/article/appendix/";
			File old = new File(path2 + appendix.getPath());
			old.delete();
		}
		String msg = articleService.updateAppendix(appendix);
		AjaxJson j = new AjaxJson();
		j.setMsg(msg);
		return j;
	}

	@RequestMapping(params = "deleteAppendix2")
	@ResponseBody
	public void deleteAppendix2() throws Exception {
		try {
			List<Appendix> list1 = articleService.listArticleId();
			for (int j = 0; j < list1.size(); j++) {
				List<Appendix> list = articleService.listPath2(list1.get(j)
						.getArticleId());
				for (int i = 0; i < list.size(); i++) {
					File old = new File(SystemPath.getSysPath()
							+ "songhu/article/appendix/" + list.get(i).getPath());
					old.delete();
				}
			}
			articleService.deleteAppendix3();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@RequestMapping(params = "download2")
	@ResponseBody
	public void download2(String id, HttpServletResponse response)
			throws IOException {
		OutputStream os = response.getOutputStream();
		try {
			Appendix g = articleService.getAppendix(id);
			String fileName = g.getFilename() + "."
					+ FileUtils.getFileExtension(g.getPath());
			fileName = new String(fileName.getBytes("gbk"), "iso8859-1");
			String path = SystemPath.getSysPath() + "songhu/article/appendix/";
			File f = new File(path + g.getPath());
			if (f != null) {
				FileInputStream fis = new FileInputStream(f);
				if (fis != null) {
					int len = fis.available();
					byte[] data = new byte[len];
					fis.read(data);
					response.reset();
					response.setHeader("Content-Disposition",
							"attachment; filename=\"" + fileName + "\"");
					response.addHeader("Content-Length", "" + data.length);
					response.setContentType("application/octet-stream;charset=UTF-8");
					OutputStream outputStream = new BufferedOutputStream(os);
					outputStream.write(data);
					outputStream.flush();
					outputStream.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (os != null) {
				os.close();
			}
		}
	}

	@RequestMapping(params = "findState")
	@ResponseBody
	public int findState(String articleId) throws Exception {
		return articleService.findState(articleId);
	}

	/*
	 * 2015-1-30文章栏目移动修改
	 */
	@RequestMapping(params = "moveColumn")
	@ResponseBody
	public AjaxJson moveColumn(Article article, String isPersist)
			throws Exception {
		try {
			String msg = "";
			if (isPersist.equals("0")) {
				msg = articleService.updateBLOBs(article);
			} else {
				Article art = new Article();
				art = articleService.getByPrimaryKey(article.getId());
				art.setColumnId(article.getColumnId());
				articleService.insert(art);
				msg = "更新成功！";
			}
			AjaxJson j = new AjaxJson();
			j.setMsg(msg);
			return j;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/*
	 * 多附件上传
	 */
	// 附件功能
	@RequestMapping(params = "multiupload", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson multiupload(String articleId, String columnId,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AjaxJson j = new AjaxJson();
		try {
			Appendix appendix = new Appendix();
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("myUpload");
			if (file.getSize() > 0) {
				String filename = file.getOriginalFilename();
				String path = SystemPath.getSysPath().replace("%20", " ")
						+ "songhu/article/appendix/";
				String nm = java.util.UUID.randomUUID().toString();
				String hz = FileUtils.getFileExtension(filename).toLowerCase();
				String localfilename = nm + "." + hz;
				File source = new File(path + localfilename);
				file.transferTo(source);
				appendix.setPath(localfilename);
				appendix.setArticleId(articleId);
				appendix.setColumnId(columnId);
				appendix.setCzsj(new Date());
				appendix.setFilename(filename.split("/.")[0]);
				User user = BaseController.getSessionUser();
				appendix.setCzry(user.getUserId());
				appendix.setState("0");
				articleService.insertAppendix(appendix);
			}
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("上传失败，请联系系统管理员！<br>错误代码：" + e.toString());
			e.printStackTrace();
		}
		return j;
	}
}
