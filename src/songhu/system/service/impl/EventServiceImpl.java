package songhu.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weixin.core.dao.support.RowSelection;
import com.weixin.core.model.Page;
import com.weixin.core.service.impl.CommonServiceImpl;
import com.weixin.core.util.Tools;

import songhu.system.pojo.Event;
import songhu.system.service.EventService;

import net.sf.json.JSONObject;

@Service("eventService")
@Transactional
public class EventServiceImpl extends CommonServiceImpl implements EventService {
	private String domain = "gEvent";
	public void deleteAll() throws Exception {
		getCommonDao().delete(domain, "deleteAll" , "");
	}

	public int deleteByPrimaryKey(Event event) throws Exception {
		int row = getCommonDao().delete(domain, "deleteByPrimaryKey", event);
		return row;
	}

	public String find(Event event, int start, int limit) throws Exception {
		RowSelection row = new RowSelection();
		row.setFetchSize(limit);
		row.setFirstRow(start);
		List<Event> list = this.getCommonDao().find(domain, "find", event, row);
		Page page = new Page(row.getTotalRows(), list);
		return JSONObject.fromObject(page).toString();
	}

	public Event getByPrimaryKey(String eventid) throws Exception {
		Event e = (Event)this.getBo(domain, "getByPrimaryKey", eventid);
		return e;
	}

	public void insert(Event event) throws Exception {
		event.setEventid(Tools.getUUID());
		this.getCommonDao().insert(domain, "insert", event);
	}

	public int updateByPrimaryKey(Event event) throws Exception {
		int row = getCommonDao().update(domain, "updateByPrimaryKey", event);
		return row;
	}

	public int updateByPrimaryKeySelective(Event event) throws Exception {
		int row = getCommonDao().update(domain, "updateByPrimaryKeySelective", event);
		return row;
	}

}
