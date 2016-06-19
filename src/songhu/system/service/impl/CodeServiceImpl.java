package songhu.system.service.impl;

import java.util.List;
import java.util.Map;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;

import songhu.system.pojo.Code;
import songhu.system.service.CodeService;
import songhu.system.vo.TreeCode;

@Service("codeService")
@Transactional
public class CodeServiceImpl extends CommonServiceImpl implements CodeService {
	private String domain = "gDm";
	public String  deleteByPrimaryKey(Code code) throws Exception {
		getCommonDao().delete(domain, "deleteByPrimaryKey", code);
		return "删除成功！ ";
	}

	public Code getByPrimaryKey(Code code)
			throws Exception {
		List<Code> list = getCommonDao().find(domain, "getByPrimaryKey", code);
		return list.size()>0?list.get(0):null;
	}
		
	public String insert(Code code) throws Exception {
		getCommonDao().insert(domain, "insert", code);
		return "插入成功！ ";

	}

	public int updateByPrimaryKey(Code code) throws Exception {
		int i = getCommonDao().update(domain, "updateByPrimaryKey", code);
		return i;
	}

	public String  updateByPrimaryKeySelective(Code code)
			throws Exception {
		getCommonDao().update(domain, "updateByPrimaryKeySelective", code);
		return "更新成功！ ";
	}

	public List<TreeCode> findZldm() throws Exception {
		List<TreeCode> list = getCommonDao().find(domain, "findZldm", "");
		return list;
	}

	public List<TreeCode> findByZldm(String zldm) throws Exception {
		List<TreeCode> list = getCommonDao().find(domain, "findByZldm", zldm);
		return list;
	}

	public String deleteZldm(String zldm) throws Exception {
		getCommonDao().delete(domain, "deleteZldm1", zldm);
		getCommonDao().delete(domain, "deleteZldm2", zldm);
		return "删除成功！ ";
	}

	public String insertZldm(Code code) throws Exception {
		getCommonDao().insert(domain, "insertZldm", code);
		return "添加成功！ ";
		
	}

	public String updateZldm(Code code) throws Exception {
		getCommonDao().update(domain, "updateZldm", code);
		return "更新成功！ ";
	}

	public Page find(Code code, int start, int limit) throws Exception {
		// TODO Auto-generated method stub
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Code> list = this.getCommonDao().find(domain, "find", code, row);
		Page page =  new Page(row.getTotalRows(),list);
		return page;
	}

	public Page findBytoZldm(String zldm, int start, int limit)
			throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Code> list = this.getCommonDao().find(domain, "findBytoZldm", zldm, row);
		Page page =  new Page(row.getTotalRows(),list);
		return page;
	}
	
	public List<TreeCode> findByZldm(Map map, RowSelection row)
			throws Exception {
		List<TreeCode> list = this.getCommonDao().find(domain, "findByZldm2",map,row);
		return list;
	}

	public String findByToKz(String kz) throws Exception {
		List<Code> list = getCommonDao().find(domain, "findBytoKz", kz);
		return list.size()>0?list.get(0).getDm():null;
	}
	public List<TreeCode> findByZldm2(Map map)
			throws Exception {
		List<TreeCode> list = this.getCommonDao().find(domain, "findByZldm3",map);
		return list;
	}
}
