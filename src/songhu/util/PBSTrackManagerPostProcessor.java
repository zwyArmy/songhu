package songhu.util;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;

public class PBSTrackManagerPostProcessor implements BeanPostProcessor {

	@Override
	public Object postProcessAfterInitialization(Object obj, String arg1)
			throws BeansException {
		if(obj instanceof StartOnLoadService) {  
			System.out.println("==========加载系统参数=========");
            ((StartOnLoadService)obj).loadData(); //调用方法加载数据  
        }  
        return obj; 
	}

	@Override
	public Object postProcessBeforeInitialization(Object arg0, String arg1)
			throws BeansException {
		return arg0;
	}

}
