package importVenuePhoto;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import com.venue.model.VenueJDBCDAO;
import com.venue.model.VenueVO;

public class GetPicureIntoDBByURL{
	
	public static byte[] getPictureByUrlString(String myUrl){
		if(checkUrlIsOK(myUrl)) {
			try {
				String urlStringEncoder = encodeUrlAboutChinese(myUrl);
				URL url = new URL(urlStringEncoder);
				HttpURLConnection httpcon = (HttpURLConnection)url.openConnection();
				httpcon.setRequestProperty("uesr-agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko");
				httpcon.setRequestMethod("GET");
				httpcon.setUseCaches(false);
				httpcon.setConnectTimeout(5000);
				InputStream is = httpcon.getInputStream();
				ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				
				byte[] b = new byte[4096];
				int bytesRead;
				while((bytesRead = is.read(b))!=-1) {
					outputStream.write(b, 0, bytesRead);
				}
				byte[] byteArray = outputStream.toByteArray();
				outputStream.close();
				is.close();
				httpcon.disconnect();
				return byteArray;
			}catch (IOException e) {
				e.printStackTrace();
				return null;
			}
		}else {
			return null;
		}
	}
	
	public static String encodeUrlAboutChinese(String myUrl) {
		StringBuffer stringBuffer = new StringBuffer(myUrl.substring(0,myUrl.lastIndexOf("/")));
		String includeChineseString = myUrl.substring(myUrl.lastIndexOf("/"), myUrl.length());
		try {
			stringBuffer.append(java.net.URLEncoder.encode(includeChineseString,"UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
		return stringBuffer.toString();
	}
	
	public static boolean checkUrlIsOK(String myUrl) {
		if(myUrl!=null) {
			if(myUrl.substring(myUrl.lastIndexOf(".")+1, myUrl.length()).length()<=10) {
				return true;
			}
		}
		return false;
	}
	
	
	
	public static void main(String[] args) throws IOException {
//		String url = "https://az804957.vo.msecnd.net/photofunc/20140613120609_籃球場1.JPG";
//		//getPictureByUrlString(url);
//		System.out.println(url);
//		System.out.println(url.substring(url.lastIndexOf(".")+1,url.length())); // JPG

		// 說明: 因為有些連結有問題(所謂的髒資料)，所以並沒有全部都有圖片
		
		VenueJDBCDAO venueJDBCDAO = new VenueJDBCDAO();
		List<VenueVO> list = venueJDBCDAO.getAll();
		System.out.println("---------------input_photo1_start");
		for(int i = 0 ; i<list.size();i++) {
			String myUrl = list.get(i).getV_photo1_url();
			System.out.println("myUrl_"+i+" : "+myUrl);
			list.get(i).setV_photo1(getPictureByUrlString(myUrl));
			if(list.get(i).getV_photo1()==null) {
				continue;
			}
			list.get(i).setV_photo1_ext(myUrl.substring(myUrl.lastIndexOf(".") , myUrl.length()));
			if(i%5==0) {
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			venueJDBCDAO.update(list.get(i));
			System.out.println("+++++++++++++++++END");
		}
		System.out.println("---------------input_photo1_end");
//		System.out.println("---------------input_photo2_start");
//		for(int i = 0 ; i<list.size();i++) {
//			String myUrl = list.get(i).getV_photo2_url();
//			System.out.println("myUrl_"+i+" : "+myUrl);
//			list.get(i).setV_photo2(getPictureByUrlString(myUrl));
//			if(list.get(i).getV_photo2()==null) {
//				continue;
//			}
//			list.get(i).setV_photo2_ext(myUrl.substring(myUrl.lastIndexOf(".") , myUrl.length()));
//			if(i%5==0) {
//				try {
//					Thread.sleep(1000);
//				} catch (InterruptedException e) {
//					e.printStackTrace();
//				}
//			}
//			venueJDBCDAO.update(list.get(i));
//			System.out.println("+++++++++++++++++END");
//		}
		System.out.println("---------------input_photo2_end");
		
		
		
		
	}
	
}
