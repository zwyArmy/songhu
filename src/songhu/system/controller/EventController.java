package songhu.system.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weixin.core.controller.BaseController;
import com.weixin.core.model.AjaxJson;

import songhu.system.pojo.Event;
import songhu.system.service.EventService;

@Controller
@RequestMapping("/eventController")
public class EventController extends BaseController {
	@Autowired
	private EventService eventService;
	private Event event;
	
	@RequestMapping(params = "findByParent")
	public void find(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String jsondata = this.eventService.find(event, start, limit);
		write(jsondata , response);
	}
	
	@RequestMapping(params = "deleteAll")
	@ResponseBody
	public AjaxJson deleteAll() throws  Exception {
		this.eventService.deleteAll();
		AjaxJson j = new AjaxJson();
		return j;
	}
	
	@RequestMapping(params = "delete")
	@ResponseBody
	public AjaxJson delete() throws  Exception {
		this.eventService.deleteByPrimaryKey(event);
		AjaxJson j = new AjaxJson();
		return j;
	}
	public Event getEvent() {
		return event;
	}

	public void setEvent(Event event) {
		this.event = event;
	}

}
