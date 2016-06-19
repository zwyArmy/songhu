package songhu.common.service;

import java.util.List;
import com.weixin.core.model.Page;

import songhu.common.pojo.Ad;

public interface AdService {

	Ad get(Ad ad) throws Exception;

	Page find(Ad ad, int start, int limit) throws Exception;

	String insert(Ad ad) throws Exception;

	String update(Ad ad) throws Exception;

	String delete(String id) throws Exception;

	List listByColumnId(String columnId) throws Exception;
}
