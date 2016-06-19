package songhu.system.service;

import songhu.system.pojo.Event;

public interface EventService {
    void insert(Event event) throws Exception;

    int updateByPrimaryKey(Event event) throws Exception;

    int updateByPrimaryKeySelective(Event event) throws Exception;

    int deleteByPrimaryKey(Event event) throws Exception;
    
    void deleteAll() throws Exception;

    Event getByPrimaryKey(String eventid) throws Exception;
    
    String find(Event event, int start, int limit) throws Exception;

}
