package songhu.util;

import java.io.File;
import java.io.FileOutputStream;

import java.io.IOException;

import java.io.InputStream;

import java.net.URL;

public class HTTPReader {

	public static void httpToFile(String strUrl, String savePath,String tempFile)
			throws IOException {

		File f = new File(tempFile);
		if(f.exists())
			f.delete();
		URL url = new URL(strUrl);
		FileOutputStream fout = new FileOutputStream(tempFile);
		InputStream Is = url.openStream();
		try {
			int i = 0;
			while ((i = Is.read()) >= 0) {
				fout.write(i);
			}
		} finally {
			fout.close();
			Is.close();
		}
		File f2 = new File(savePath);
		if(f2.exists())
			f2.delete();
		f.renameTo(f2);
	}

	public static void main(String[] args) throws IOException {
		String url = "http://www.baidu.com";
		httpToFile(url,"D:\\test.html","D:\\test2.tmp");
	}

}
