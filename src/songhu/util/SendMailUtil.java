package songhu.util;

import freemarker.template.Configuration;
import freemarker.template.Template;
import java.io.File;
import java.net.URL;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

public class SendMailUtil
{
  private String from = StartOnLoadService.parameterMap.get("webemail");
  private String fromName = "厦门嵩湖环保有限公司";
  private String charSet = "utf-8";
  private String username = StartOnLoadService.parameterMap.get("webemail");
  private String password = StartOnLoadService.parameterMap.get("emailpwd");

  private static Map<String, String> hostMap = new HashMap();

  static {
    hostMap.put("smtp.126", "smtp.126.com");

    hostMap.put("smtp.qq", "smtp.qq.com");

    hostMap.put("smtp.163", "smtp.163.com");

    hostMap.put("smtp.sina", "smtp.sina.com.cn");

    hostMap.put("smtp.tom", "smtp.tom.com");

    hostMap.put("smtp.263", "smtp.263.net");

    hostMap.put("smtp.yahoo", "smtp.mail.yahoo.com");

    hostMap.put("smtp.hotmail", "smtp.live.com");

    hostMap.put("smtp.gmail", "smtp.gmail.com");
    hostMap.put("smtp.port.gmail", "465");
  }

  public String getFrom()
  {
    return this.from;
  }

  public void setFrom(String from) {
    this.from = from;
  }

  public String getFromName() {
    return this.fromName;
  }

  public void setFromName(String fromName) {
    this.fromName = fromName;
  }

  public String getUsername() {
    return this.username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return this.password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public static String getHost(String email)
    throws Exception
  {
    Pattern pattern = Pattern.compile("\\w+@(\\w+)(\\.\\w+){1,2}");
    Matcher matcher = pattern.matcher(email);
    String key = "unSupportEmail";
    if (matcher.find()) {
      key = "smtp." + matcher.group(1);
    }
    if (hostMap.containsKey(key)) {
      return (String)hostMap.get(key);
    }
    throw new Exception("unSupportEmail");
  }

  public static int getSmtpPort(String email) throws Exception
  {
    Pattern pattern = Pattern.compile("\\w+@(\\w+)(\\.\\w+){1,2}");
    Matcher matcher = pattern.matcher(email);
    String key = "unSupportEmail";
    if (matcher.find()) {
      key = "smtp.port." + matcher.group(1);
    }
    if (hostMap.containsKey(key)) {
      return Integer.parseInt((String)hostMap.get(key));
    }
    return 25;
  }

  /**
   * 发送模板邮件
   *
   * @param toMailAddr
   *            收信人地址
   * @param subject
   *            email主题
   * @param templatePath
   *            模板地址
   * @param map
   *            模板map
   */
  public void sendFtlMail(String toMailAddr, String subject, String templatePath, Map<String, Object> map)
  {
    Template template = null;
    Configuration freeMarkerConfig = null;
    HtmlEmail hemail = new HtmlEmail();
    try
    {
      hemail.setHostName(getHost(this.from));
      hemail.setSmtpPort(getSmtpPort(this.from));

      hemail.setCharset(this.charSet);
      hemail.addTo(toMailAddr);
      hemail.setFrom(this.from, this.fromName);
      hemail.setAuthentication(this.username, this.password);
      hemail.setSubject(subject);
      freeMarkerConfig = new Configuration();
      freeMarkerConfig.setDirectoryForTemplateLoading(new File(getFilePath()));

      // 获取模板
      template = freeMarkerConfig.getTemplate(getFileName(templatePath), new Locale("Zh_cn"), "UTF-8");
      
      // 模板内容转换为string
      String htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(template, map);
      System.out.println(htmlText);
      hemail.setMsg(htmlText);
      hemail.send();
      System.out.println("email send true!");
    } catch (Exception e) {
      e.printStackTrace();
      System.out.println("email send error!");
    }
  }

  /**
   * 发送普通邮件
   *
   * @param toMailAddr
   *            收信人地址
   * @param subject
   *            email主题
   * @param message
   *            发送email信息
   */
  public void sendCommonMail(String toMailAddr, String subject, String message)
  {
    HtmlEmail hemail = new HtmlEmail();
    try
    {
      hemail.setHostName(getHost(this.from));
      hemail.setSmtpPort(getSmtpPort(this.from));

      hemail.setCharset(this.charSet);
      hemail.addTo(toMailAddr);
      hemail.setFrom(this.from, this.fromName);
      hemail.setAuthentication(this.username, this.password);
      hemail.setSubject(subject);
      hemail.setMsg(message);
      hemail.send();
      System.out.println("email send true!");
    } catch (Exception e) {
      e.printStackTrace();
      System.out.println("email send error!");
    }
  }

  public static String getHtmlText(String templatePath, Map<String, Object> map)
  {
    Template template = null;
    String htmlText = "";
    try {
      Configuration freeMarkerConfig = null;
      freeMarkerConfig = new Configuration();
      freeMarkerConfig.setDirectoryForTemplateLoading(new File(getFilePath()));

      template = freeMarkerConfig.getTemplate(getFileName(templatePath), new Locale("Zh_cn"), "UTF-8");

      htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(template, map);
      System.out.println(htmlText);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return htmlText;
  }

  private static String getFilePath()
  {
    String path = getAppPath(SendMailUtil.class);
    path = path + File.separator + "mailtemplate" + File.separator;
    path = path.replace("\\", "/");
    System.out.println(path);
    return path;
  }

  private static String getFileName(String path) {
    path = path.replace("\\", "/");
    System.out.println(path);
    return path.substring(path.lastIndexOf("/") + 1);
  }

  public static String getAppPath(Class cls)
  {
    if (cls == null)
      throw new IllegalArgumentException("参数不能为空！");
    ClassLoader loader = cls.getClassLoader();

    String clsName = cls.getName() + ".class";

    Package pack = cls.getPackage();
    String path = "";

    if (pack != null) {
      String packName = pack.getName();

      if ((packName.startsWith("java.")) || (packName.startsWith("javax."))) {
        throw new IllegalArgumentException("不要传送系统类！");
      }
      clsName = clsName.substring(packName.length() + 1);

      if (packName.indexOf(".") < 0) {
        path = packName + "/";
      } else {
        int start = 0; int end = 0;
        end = packName.indexOf(".");
        while (end != -1) {
          path = path + packName.substring(start, end) + "/";
          start = end + 1;
          end = packName.indexOf(".", start);
        }
        path = path + packName.substring(start) + "/";
      }
    }

    URL url = loader.getResource(path + clsName);

    String realPath = url.getPath();

    int pos = realPath.indexOf("file:");
    if (pos > -1) {
      realPath = realPath.substring(pos + 5);
    }
    pos = realPath.indexOf(path + clsName);
    realPath = realPath.substring(0, pos - 1);

    if (realPath.endsWith("!")) {
      realPath = realPath.substring(0, realPath.lastIndexOf("/"));
    }

    try
    {
      realPath = URLDecoder.decode(realPath, "utf-8");
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
    System.out.println("realPath----->" + realPath);
    return realPath;
  }

  public static void main(String[] args)
  {
    SendMailUtil sm = new SendMailUtil();
    sm.setFromName("厦门嵩湖环保有限公司");
    sm.sendCommonMail("1186043895@qq.com", "测试测试", "sendemail test!");
  }
}