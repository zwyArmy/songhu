package songhu.system.service;

import java.util.List;
import java.util.Map;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;

import songhu.common.pojo.Ad;
import songhu.system.pojo.Code;
import songhu.system.vo.TreeCode;

public interface CodeService {
    String insert(Code code)throws Exception ;
    
    String insertZldm(Code code)throws Exception ;

    int updateByPrimaryKey(Code code)throws Exception ;
    
    String updateZldm(Code code)throws Exception ;
  
    Page find(Code code,int start,int limit) throws Exception;
    
    Page findBytoZldm(String zldm,int start,int limit) throws Exception;
    
    String updateByPrimaryKeySelective(Code code)throws Exception ;

    String deleteByPrimaryKey(Code code)throws Exception ;
    
    String deleteZldm(String zldm)throws Exception ;

    Code getByPrimaryKey(Code code)throws Exception ;
    
    List<TreeCode> findZldm() throws Exception;
    
    List<TreeCode> findByZldm(String zldm) throws Exception;
	
    List<TreeCode> findByZldm2(Map map) throws Exception;
    
    List<TreeCode> findByZldm(Map map,RowSelection row) throws Exception;
    
    String findByToKz(String kz)throws Exception ;
}
