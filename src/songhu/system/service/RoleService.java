package songhu.system.service;

import java.util.Map;

import com.weixin.core.model.Page;

import songhu.system.pojo.Role;

public interface RoleService {
    void insert(Role role) throws Exception;

    int updateByPrimaryKey(Role role) throws Exception;

    int updateByPrimaryKeySelective(Role role) throws Exception;

    int deleteByPrimaryKey(String dmGw) throws Exception;

    Role getByPrimaryKey(String dmGw) throws Exception;
    
    Page find(Role role, int start, int limit) throws Exception;
    
    Page find2(Role role, int start, int limit) throws Exception;
    
    void insertGwqx(Map map)throws Exception ;

    int deleteGwqx(Map map)throws Exception ;
    
    void insertCzrygw(Map map)throws Exception ;

    int deleteCzrygw(Map map)throws Exception ;

}
