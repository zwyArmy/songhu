package songhu.util;

import com.jasson.im.api.APIClient;

public class SendMsg {
	private String host = "211.143.167.185";
	private long smId = 1;
	private String dbName = "mas";
	private String apiId ="api";
	private String name ="test";
	private String pwd ="123";
	private APIClient handler = new APIClient();
	public void init()
	{
		int connectRe = handler.init(host, name, pwd, apiId, dbName);
		if(connectRe == APIClient.IMAPI_SUCC)
        	System.out.println("初始化成功");
        else if(connectRe == APIClient.IMAPI_CONN_ERR)
        	System.out.println("连接失败");
        else if(connectRe == APIClient.IMAPI_API_ERR)
        	System.out.println("apiID不存在");
        if(connectRe != APIClient.IMAPI_SUCC)
        {
        	System.out.println("apiID不存在");
        }
	}
	public void sendSM(String mobile,String content)
	{
		init();
		int result=0;
		result = handler.sendSM(mobile.split(","), content, smId);
		if(result==APIClient.IMAPI_SUCC){
		System.out.println("发送成功!");
		}
	}
	public static void main(String[] args){
		SendMsg msg = new SendMsg();
		msg.sendSM("13012345678", "http://t.cn/8FF5OlH");
	}
}
