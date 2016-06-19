package songhu.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.system.pojo.Httpsession;
import songhu.system.service.HttpsessionService;

import net.sf.json.JSONObject;
@Service("httpsessionService")
@Transactional
public class HttpsessionServiceImpl extends CommonServiceImpl implements
		HttpsessionService {
	private String domain = "gsHttpsession";
	public int deleteByPrimaryKey(String sessionid) throws Exception {
		int row = getCommonDao().delete(domain, "deleteByPrimaryKey", sessionid);
		return row;
	}

	public Httpsession getByPrimaryKey(String sessionid) throws Exception {
		List<Httpsession> list = this.getCommonDao().find(domain, "getByPrimaryKey", sessionid);
		return list.size()>0?list.get(0):null;
	}

	public void insert(Httpsession httpsession) throws Exception {
		this.getCommonDao().insert(domain, "insert", httpsession);
	}

	public int updateByPrimaryKey(Httpsession httpsession) throws Exception {
		int row = getCommonDao().update(domain, "updateByPrimaryKey", httpsession);
		return row;
	}

	public int updateByPrimaryKeySelective(Httpsession httpsession)
			throws Exception {
		int row = getCommonDao().update(domain, "updateByPrimaryKeySelective", httpsession);
		return row;
	}

	public String find(Httpsession httpsession, int start, int limit)
			throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Httpsession> list = this.getCommonDao().find(domain, "find", httpsession, row);
		Page page = new Page(row.getTotalRows(), list);
		return JSONObject.fromObject(page).toString();
	}

	public void deleteAll() throws Exception {
		getCommonDao().delete(domain, "deleteAll" , "");		
	}

}
