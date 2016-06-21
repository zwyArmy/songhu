package songhu.common.bean;

import java.util.List;

import com.weixin.core.spring.BeanFactoryUtil;

import songhu.common.pojo.Ad;
import songhu.common.service.AdService;

public class AdBean {
	private static AdService adService;

	public AdBean() {
		super();
		if (adService == null)
			
			adService = (AdService) BeanFactoryUtil.getBean("adService");
	}

	public Ad getAd(String columnId, String posId) {
		try {
			Ad ad = new Ad();
			ad.setColumnId(columnId);
			ad.setPosId(posId);
			return adService.get(ad);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Ad> listByColumnId(String columnId) throws Exception {
		List<Ad> list = adService.listByColumnId(columnId);
		return list;
	}
}
