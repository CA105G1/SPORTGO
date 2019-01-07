package com.scheduler.venue;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.region.model.RegDAO_interface;
import com.region.model.RegJDBCDAO;
import com.region.model.RegVO;
import com.venue.model.VenueDAO_interface;
import com.venue.model.VenueJDBCDAO;
import com.venue.model.VenueVO;
import com.venuetype.model.VenueTypeDAO_interface;
import com.venuetype.model.VenueTypeJDBCDAO;
import com.venuetype.model.VenueTypeVO;

public class GetVenueDataByCity {
	/// 此檔案只抓與中央大學有關DATA
	private static int iii = 0;
	private static int jjj = 0;
	private static int kkk = 0;
	private static int mmm = 0;
	private static final int TEST_HOW_MANY_DATA_TODO = jjj; // if = jjj means for all;
	private static int nnn = 0;
	private static int countConnect = 0;
	// version 1
	// this version no image into DB
	public static void main(String[] args) {
		long startTime = System.currentTimeMillis();
		System.out.println("++++++ "+(++iii)+" ++++++"); // 1
//		GymService gymService = new GymService();
//		GymDAO_interface gymDAO = new GymJDBCDAO();
		List<String> gymObjectJSONStringList = new ArrayList<>();
		
		/// 從網路取得jsonOject
//		List<Integer> colleciotnGymID = gymDAO.getAllGymID();
		Set<Integer> colleciotnGymID = GetGymIDByCity.getGymIdByCity("桃園市");
		System.out.println(colleciotnGymID.size());
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(2785)));	//	中央大學附屬中壢高中自強館
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(13573)));	//	中央大學羽球場(館)
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(13633)));	//	中央大學依仁堂
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(5518)));	//	中央大學附屬中壢高中田徑場
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(5534)));	//	中央大學附屬中壢高中籃球場
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(5584)));	//	中央大學附屬中壢高中網球場(館)
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(13782)));	//	中央大學簡易棒球場
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(13919)));	//	中央大學籃球場
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(14104)));	//	中央大學排球場
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(2785)));	//	中央大學附屬中壢高中自強館
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(13573)));	//	中央大學羽球場(館)
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(13633)));	//	中央大學依仁堂
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(5518)));	//	中央大學附屬中壢高中田徑場
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(5534)));	//	中央大學附屬中壢高中籃球場
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(5584)));	//	中央大學附屬中壢高中網球場(館)
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(13782)));	//	中央大學簡易棒球場
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(13919)));	//	中央大學籃球場
		System.out.println("移除 : "+colleciotnGymID.remove(new Integer(14104)));	//	中央大學排球場
		System.out.println(colleciotnGymID.size());

		
		long stepTime = 0;
		stepTime = System.currentTimeMillis();
		System.out.println("花費多少毫秒 : "+(stepTime-startTime));
		startTime = stepTime;
		System.out.println("++++++ "+(++iii)+" ++++++"); // 2
		
		for(Integer gym_id : colleciotnGymID) {
			VenueVOJSONString venueJSONString = new VenueVOJSONString(gym_id);
			String string = venueJSONString.getVenueSetJSONStringByUrl();
			gymObjectJSONStringList.add(string);
			jjj++;
			if(jjj==TEST_HOW_MANY_DATA_TODO) {
				break;
			}
		}
		
		stepTime = System.currentTimeMillis();
		System.out.println("花費多少毫秒 : "+(stepTime-startTime));
		startTime = stepTime;
		System.out.println("++++++ "+(++iii)+" ++++++"); // 3
		
		/// jsionArray to VenueVO Object and collection it by HashMap
		Map<String, VenueVO> venueVOCollectionMap = new HashMap<String, VenueVO>();
		try {
			for(String gymObjectJSONString : gymObjectJSONStringList) {
				countConnect++;
				if(countConnect%10==0) {
					try {
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				collectAndTransJSONStringToVenueVO(gymObjectJSONString, venueVOCollectionMap);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		System.out.println("venueVOCollectionMap.size() : "+venueVOCollectionMap.size());

		stepTime = System.currentTimeMillis();
		System.out.println("花費多少毫秒 : "+(stepTime-startTime));
		startTime = stepTime;
		System.out.println("++++++ "+(++iii)+" ++++++"); // 4
		
		/// VenueVO into DB but no image
//		VenueService venueService = new VenueService();
		VenueDAO_interface venueDAO = new VenueJDBCDAO();
		
		Set<String> set = venueVOCollectionMap.keySet();
		for(String venuePK:set) {
			VenueVO venueVO = venueVOCollectionMap.get(venuePK);
			try {
			venueDAO.insert(venueVO);
			System.out.println("第"+(++nnn)+"筆輸入DB成功");
			}catch (Exception e) {
				// TODO: handle exception
			}
		}

		stepTime = System.currentTimeMillis();
		System.out.println("花費多少毫秒 : "+(stepTime-startTime));
		startTime = stepTime;
		System.out.println("++++++ "+(++iii)+" ++++++END");  // 5
		
	}
	
	
	public static void collectAndTransJSONStringToVenueVO(String gymObjectJSONString, Map<String, VenueVO> venueVOCollectionMap) throws JSONException{
		//System.out.println(gymObjectJSONString);
		JSONObject jsonObject = new JSONObject(gymObjectJSONString);
		JSONArray jsonArray = jsonObject.getJSONArray("GymFuncData");
		for(int i = 0 ; i<jsonArray.length(); i++) {
			kkk++;
			if(kkk%8==0) {
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			System.out.println("............第"+(++mmm)+"筆設施........................");
			/// 先解析運動場地是否府和條件
			JSONObject data = jsonArray.getJSONObject(i);
//			System.out.println();
//			System.out.println("data.getString(\"GymType\") : "+data.getString("GymType"));
			if(kkk%8==0) {
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			Map<Boolean, String> map = null;
			if((map = checkVt_noIsOK(data.getString("GymType"))).size()==0) {
				continue;
			}
			System.out.println("............第"+(kkk)+"筆轉換為物件........................");
			/// 確認後開始生產物件
			VenueVO venueVO = new VenueVO();
			/// must have
			venueVO.setV_name(jsonObject.getString("Name"));
			venueVO.setVt_no(map.get(true));
			venueVO.setV_address(jsonObject.getString("Addr"));
			venueVO.setReg_no(getReg_noFromAddress(venueVO.getV_address()));
			
			/// normal
			try {
			venueVO.setV_weburl(jsonObject.getString("WebUrl"));
			venueVO.setV_parktype(jsonObject.getString("ParkType"));
			venueVO.setV_introduction(jsonObject.getString("Introduction"));
			venueVO.setV_phoneno(jsonObject.getString("OperationTel"));
			venueVO.setV_lat(jsonObject.getDouble("Lat"));
			venueVO.setV_long(jsonObject.getDouble("Lng"));
			
			
			venueVO.setV_inout(data.getString("InOut"));
			
			venueVO.setV_fitall(data.getBoolean("FitAll")?"Y":"N");
			venueVO.setV_fitinter(data.getBoolean("FitInter")?"Y":"N");
			
			venueVO.setOpen_state(data.getString("OpenState"));
			venueVO.setOpen_time(data.getString("OpenTime"));
			venueVO.setOpenday_mon(data.getBoolean("OpenDayMon")?"Y":"N");
			venueVO.setOpenday_tue(data.getBoolean("OpenDayTue")?"Y":"N");
			venueVO.setOpenday_wed(data.getBoolean("OpenDayWed")?"Y":"N");
			venueVO.setOpenday_thu(data.getBoolean("OpenDayThu")?"Y":"N");
			venueVO.setOpenday_fri(data.getBoolean("OpenDayFri")?"Y":"N");
			venueVO.setOpenday_sat(data.getBoolean("OpenDaySat")?"Y":"N");
			venueVO.setOpenday_sun(data.getBoolean("OpenDaySun")?"Y":"N");
			
			venueVO.setV_photo1(null);
			venueVO.setV_photo1_ext(null);
			venueVO.setV_photo2(null);
			venueVO.setV_photo2_ext(null);
			venueVO.setV_photo1_url(data.getString("Photo1"));
			venueVO.setV_photo2_url(data.getString("Photo2"));
	//		venueVO.setV_photo1_ext("Photo1");
	//		venueVO.setV_photo2("Photo2");
	//		venueVO.setV_photo1("Photo1");
	//		venueVO.setV_photo2_ext("Photo2");
			venueVOCollectionMap.put(venueVO.getV_name()+venueVO.getVt_no(), venueVO);
			System.out.println("............第"+kkk+"筆成功轉換為物件....map : "+venueVOCollectionMap.size()+"....................");
			
			}catch (Exception e) {
				System.err.println("venueVO.getV_name() : "+venueVO.getV_name());
				
			}
			
			
		}
	}
	
	private static List<VenueTypeVO> listVenueType = null;
	static {
//		listVenueType = new VenueTypeService().getAll();
		listVenueType = new VenueTypeJDBCDAO().getAll();
	}
	private static Map<Boolean, String> checkVt_noIsOK(String dataJSONGymType) {
		String vt_name = null;
		String vt_no = "";
		Map<Boolean, String> map = new HashMap<>();
		for(int i = 0 ; i<listVenueType.size() ; i++) {
		
			vt_name = listVenueType.get(i).getVt_name();
//			VenueTypeService venueTypeService = new VenueTypeService();
			VenueTypeDAO_interface venueTypeDAO = new VenueTypeJDBCDAO();
			if(i%3==0) {
				try {
					Thread.sleep(200);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(venueTypeDAO.isVenueType(dataJSONGymType, vt_name)) {
				vt_no = listVenueType.get(i).getVt_no();
				map.put(true, vt_no);
				return map;
			}
		}
		return map;
	}
	
	private static Integer getReg_noFromAddress(String address) {
		System.out.println("address : "+ address);
//		RegService regService = new RegService();
//		RegVO regVO = regService.getRegVOFromAddress(address);
		RegDAO_interface regDAO = new RegJDBCDAO();
		RegVO regVO = regDAO.getRegVOFromAddress(address);
		if(regVO==null) {
			System.err.println("address : "+ address);
			return new Integer(999);
		}
		return regVO.getReg_no();
	}
	
}
