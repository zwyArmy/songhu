package songhu.system.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.service.impl.CommonServiceImpl;
import com.weixin.core.util.QMap;
import com.weixin.core.util.Tools;

import songhu.system.pojo.Menu;
import songhu.system.service.MenuService;
import songhu.system.vo.Tree;
import songhu.system.vo.TreeCheck;
import songhu.system.vo.TreeMenu;
@Service("menuService")
@Transactional
public class MenuServiceImpl extends CommonServiceImpl implements MenuService {
	private String domain = "gMenu";
	public int deleteByPrimaryKey(Menu menu)throws Exception {
		int i = getCommonDao().delete(domain, "deleteByPrimaryKey1", menu);
		this.getCommonDao().delete(domain, "deleteByPrimaryKey2", menu);
		return i;
	}

	public Menu getByPrimaryKey(Menu menu)throws Exception  {
		List<Menu> list = getCommonDao().find(domain, "getByPrimaryKey", menu);
		return list.size()>0?list.get(0):null;
	}

	public void insert(Menu menu)throws Exception  {
		menu.setBhCd(Tools.getUUID());
		getCommonDao().insert(domain, "insert", menu);

	}

	public int updateByPrimaryKey(Menu menu)throws Exception  {
		int i = getCommonDao().update(domain, "updateByPrimaryKey", menu);
		return i;
	}

	public int updateByPrimaryKeySelective(Menu menu)throws Exception  {
		int i = getCommonDao().update(domain, "updateByPrimaryKeySelective", menu);
		return i;
	}

	public List<TreeMenu> findByParent(String fbh) throws Exception {
		fbh = fbh.indexOf("xnode")==0?"###":fbh;
		List<TreeMenu> list = getCommonDao().find(domain, "findByParent", fbh);
		for(int i = 0,len = list.size();i<len;i++){
			List<TreeMenu> list1 = getCommonDao().find(domain, "findByParent", list.get(i).getId());
			list.get(i).setLeaf(list1.size()==0);
		}
		return list;
	}
	
	public List<Tree> findByNode(Map map)throws Exception {
		List<Tree> list = getCommonDao().find(domain, "findByNode", map);
		for(int i = 0,len = list.size();i<len;i++){
			QMap qmap = new QMap("fbh",list.get(i).getId(),"czy",map.get("czy"));
			List<Tree> list1 = getCommonDao().find(domain, "findByNode", qmap);
			list.get(i).setLeaf(list1.size()==0);
		}
		return list;
		
	}
	/**
	 * 已授权树
	 */
	public List<TreeCheck> findWithQx(Map map) throws Exception {
		List<TreeCheck> list = getCommonDao().find(domain, "findWithQx", map);
		for(int i = 0,len = list.size();i<len;i++){
			List<TreeCheck> list1 = findByAll(list.get(i).getId());
			list.get(i).setLeaf(list1.size()==0);
		}
		return list;
	}
	/**
	 * 未授权树
	 */
	public List<TreeCheck> findWithoutQx(Map map) throws Exception {
		List<TreeCheck> list = getCommonDao().find(domain, "findWithoutQx", map);
		for(int i = 0,len = list.size();i<len;i++){
			List<TreeCheck> list1 = findByAll(list.get(i).getId());
			list.get(i).setLeaf(list1.size()==0);
		}
		return list;
	}

	public List<TreeCheck> findByAll(String fbh) throws Exception {
		List<TreeCheck> list = getCommonDao().find(domain, "findByAll", fbh);
		return list;
	}

	public List<TreeCheck> findByGrant(Map map) throws Exception {
		List<TreeCheck> list = getCommonDao().find(domain, "findByGrant", map);
		for(int i = 0,len = list.size();i<len;i++){
			List<TreeCheck> list1 = findByAll(list.get(i).getId());
			list.get(i).setLeaf(list1.size()==0);
		}
		return list;
	}

	public List<TreeCheck> findCzryForGw(Map map) throws Exception {
		List<TreeCheck> list = getCommonDao().find(domain, "findCzryForGw", map);
		return list;
	}

	public List<TreeCheck> findGwForCzry(Map map) throws Exception {
		List<TreeCheck> list = getCommonDao().find(domain, "findGwForCzry", map);
		return list;
	}

 
	public List<Tree> findByNode2(Map map) throws Exception {
		List<Tree> list = getCommonDao().find(domain, "findByNode2", map);
		for(int i = 0,len = list.size();i<len;i++){
			QMap qmap = new QMap("parentId",list.get(i).getId(),"czy",map.get("czy"));
			List<Tree> list1 = getCommonDao().find(domain, "findByNode2", qmap);
			list.get(i).setLeaf(list1.size()==0);
		}
		return list;
	}

}
