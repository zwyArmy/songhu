package songhu.system.service;

import songhu.system.pojo.Httpsession;

public interface HttpsessionService {
    void insert(Httpsession httpsession) throws Exception;

    int updateByPrimaryKey(Httpsession httpsession) throws Exception;

    int updateByPrimaryKeySelective(Httpsession httpsession) throws Exception;

    int deleteByPrimaryKey(String sessionid) throws Exception;
    
    void deleteAll() throws Exception;

    Httpsession getByPrimaryKey(String sessionid) throws Exception;
    
    String find(Httpsession httpsession, int start, int limit) throws Exception;

}
