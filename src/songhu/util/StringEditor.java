package songhu.util;

public class StringEditor {
	static public String RemoveBr(String res) {
		if(res==null)
			return null;
		return res.replaceAll("<br[^>]*>", "").replaceAll("<br[^>]*/>", "")
				.replaceAll("<BR[^>]*>", "").replaceAll("<BR[^/>]*>", "").replace("\n", "");
	}
}
