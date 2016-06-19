package songhu.system.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ckfinder.connector.utils.FileUtils;
import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;
import com.weixin.core.model.Page;
import com.weixin.core.util.SystemPath;

import songhu.system.pojo.Depart;
import songhu.system.service.DepartService;
import songhu.system.vo.Tree;
import songhu.util.Extool;

@Controller
@RequestMapping("/departController")
public class DepartController extends BaseController {

	@Autowired
	private DepartService departService;
	
	@RequestMapping(params = "findByParent")
	@ResponseBody
	public List<Tree> findByParent(String id)throws Exception{
		List<Tree> list = departService.findByParent(id);
		return list;	
	}
	//新增或修改
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(Depart depart,String cz, 
			HttpServletRequest request) throws Exception{
		String msg="";
		AjaxJson j = new AjaxJson();		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获得文件：   
		MultipartFile file = multipartRequest.getFile("myUpload");  
		// 获得文件：   
		MultipartFile file1 = multipartRequest.getFile("myUpload1");  
		if(file.getSize()>0){
			// 获得文件名：   
			String filename = file.getOriginalFilename();
			String path = SystemPath.getSysPath()+"images\\org\\big\\";
			String localfilename = depart.getDeptid()+"."+FileUtils.getFileExtension(filename);
			// 写入文件   
			File source = new File(path+localfilename);   
			file.transferTo(source);
		} 
		if(file1.getSize()>0){
			// 获得文件名：   
			String filename1 = file1.getOriginalFilename();
			String path1 = SystemPath.getSysPath()+"images\\org\\";
			String localfilename1 = depart.getDeptid()+"."+FileUtils.getFileExtension(filename1);
			// 写入文件   
			File source1 = new File(path1+localfilename1);   
			file1.transferTo(source1);
		} 
		if(cz.equals("1"))
	    {   
			Depart d = departService.getById(depart.getDeptid());
			if(d==null)
				msg = departService.insert(depart);
			else{
				msg = "机构编号已存在！ ";
				j.setSuccess(false);
			}
	    }else{	    	
	    	msg = departService.update(depart);
	    }
		j.setMsg(msg);
		return j;
	}
	
	//获取
	@RequestMapping(params = "get")
	@ResponseBody
	public AjaxJson get(String id) throws Exception{
		Depart g = this.departService.getById(id);
		AjaxJson j = new AjaxJson();
		j.setData(g);
		return j;
	}
	//删除
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete(String gwList) throws Exception{
		String[] tmp = gwList.split(",");
		String path = SystemPath.getSysPath()+"images\\org\\big\\";
		String path1 = SystemPath.getSysPath()+"images\\org\\";
		for(int i=0,len=tmp.length;i<len;i++){
			this.departService.delete(tmp[i]);
			File file = new File(path+tmp[i]+".png");
			file.delete();
			File file1 = new File(path1+tmp[i]+".png");
			file1.delete();
		}
		AjaxJson j = new AjaxJson();
	    return j;
	}
	
	//初始化显示所有信息
	@RequestMapping(params = "find")
	@ResponseBody
	public Page find(Depart depart,int start,int limit) throws Exception{
		Page page=departService.find(depart, start, limit);
		return page;
	}
}
