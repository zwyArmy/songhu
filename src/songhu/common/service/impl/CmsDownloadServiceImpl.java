package songhu.common.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.common.pojo.CmsDownload;
import songhu.common.service.CmsDownloadService;

@Service("cmsDownloadService")
@Transactional
public class CmsDownloadServiceImpl extends CommonServiceImpl implements
       CmsDownloadService {

	private String domain = "cmsDownload";

	public String insert(CmsDownload cmsDownload) throws Exception {
		this.getCommonDao().insert(domain, "insert", cmsDownload);
		return "添加成功！";
	}

	public String update(CmsDownload cmsDownload) throws Exception {
		this.getCommonDao().update(domain, "updateByPrimaryKeySelective",
				cmsDownload);
		return "更新成功！";
	}

	public String delete(String id) throws Exception {
		this.getCommonDao().delete(domain, "deleteByPrimaryKey", id);
		return "删除成功！ ";
	}

	public CmsDownload getByPrimaryKey(String id) throws Exception {
		List<CmsDownload> list = this.getCommonDao().find(domain,
				"getByPrimaryKey", id);
		return list.size() > 0 ? list.get(0) : null;
	}

	public Page find(CmsDownload cmsDownload, RowSelection row) throws Exception {
		List<CmsDownload> list = this.getCommonDao().find(domain, "find",
				cmsDownload, row);
		Page page = new Page(row.getTotalRows(), list);
		return page;
	}

}
