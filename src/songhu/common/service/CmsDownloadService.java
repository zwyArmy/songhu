package songhu.common.service;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;

import songhu.common.pojo.CmsDownload;

public interface CmsDownloadService {
	String insert(CmsDownload cmsDownload) throws Exception;

	String update(CmsDownload cmsDownload) throws Exception;

	String delete(String id) throws Exception;

	CmsDownload getByPrimaryKey(String id) throws Exception;

	Page find(CmsDownload cmsDownload, RowSelection row) throws Exception;
}