package songhu.system.service;

import java.util.List;
import java.util.Map;

import songhu.system.pojo.Menu;
import songhu.system.vo.Tree;
import songhu.system.vo.TreeCheck;
import songhu.system.vo.TreeMenu;

public interface MenuService {
    void insert(Menu menu)throws Exception ;

    int updateByPrimaryKey(Menu menu)throws Exception ;

    int updateByPrimaryKeySelective(Menu menu)throws Exception ;

    int deleteByPrimaryKey(Menu menu)throws Exception ;

    Menu getByPrimaryKey(Menu menu)throws Exception ;
    
    List<TreeMenu> findByParent(String fbh)throws Exception ;
    
    List<Tree> findByNode(Map map)throws Exception ;
    
    List<TreeCheck> findByGrant(Map map)throws Exception ;
    
    List<TreeCheck> findCzryForGw(Map map)throws Exception ;
    
    List<TreeCheck> findGwForCzry(Map map)throws Exception ;
    
    List<TreeCheck> findWithQx(Map map)throws Exception ;
    
    List<TreeCheck> findWithoutQx(Map map)throws Exception ;
    
    List<TreeCheck> findByAll(String fbh)throws Exception ;
    
    List<Tree> findByNode2(Map map) throws Exception;
}