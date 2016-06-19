package songhu.util.interceptors;

import java.util.Date;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

import com.weixin.core.interceptors.DateConvertEditor;

public class MyWebBinding
  implements WebBindingInitializer
{
  public void initBinder(WebDataBinder binder, WebRequest request)
  {
    binder.registerCustomEditor(Date.class, new DateConvertEditor());
  }
}