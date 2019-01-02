package com.android.sg_info.model;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.android.sg_info.model.Sg_infoJDBCDAO_android;
import com.android.sg_info.model.Sg_infoVO_android;

public class Test {

	public static void main(String[] args) throws IOException {
		
		Sg_infoJDBCDAO_android dao = new Sg_infoJDBCDAO_android();
		
		
		
//insert測試 (但每個欄位都需要填值，如何解決?)
//		Sg_infoVO_Android vo3 = new Sg_infoVO_Android();
		
//		vo3.setMem_no("M014");
//		vo3.setSg_name("來來來哩來");
//		Timestamp ts = Timestamp.valueOf("2018-12-29 16:30:00");
//		vo3.setSg_date(ts);
//		Timestamp ts2 = new Timestamp(System.currentTimeMillis());
//		vo3.setApl_start(ts2);
//		Timestamp ts3 = Timestamp.valueOf("2018-12-20 00:00:00");
//		vo3.setApl_end(ts3);
//		vo3.setSg_fee(100);
//		File file = new File("WebContent/img/bb.png");
//		FileInputStream is = new FileInputStream(file);
//		byte[] b = new byte[is.available()];
//		is.read(b);
//		vo3.setSg_per("公開");
//		vo3.setSp_no("SP003");
//		vo3.setVenue_no("V000001");
//		vo3.setSg_maxno(5);
//		vo3.setSg_minno(2);
//		vo3.setSg_ttlapl(0);
//		vo3.setSg_chkno(0);
//		vo3.setSg_extrainfo("Hello JAVA!!");
//		vo3.setLoc_start_lat(0.0);
//		vo3.setLoc_start_lng(0.0);
//		vo3.setLoc_end_lat(0.0);
//		vo3.setLoc_end_lng(0.0);
//		is.close();
//		
//		dao.insert(vo3);
		

//update測試
//		Sg_infoVO_Android vo4 = new Sg_infoVO_Android();
//		
//		vo4.setSg_name("123456");
//		Timestamp t = Timestamp.valueOf("2018-12-29 16:30:00");
//		vo4.setSg_date(t);
//		Timestamp t2 = new Timestamp(System.currentTimeMillis());
//		vo4.setApl_start(t2);
//		Timestamp t3 = Timestamp.valueOf("2018-12-20 00:00:00");
//		vo4.setApl_end(t3);
//		vo4.setSg_fee(100);
//		File file2 = new File("WebContent/img/honda.jpeg");
//		FileInputStream is2 = new FileInputStream(file2);
//		byte[] b2 = new byte[is2.available()];
//		is2.read(b2);
//		vo4.setSg_pic(b2);
//		vo4.setSg_pic_ext("jpeg");
//		vo4.setSg_per("公開");
//		vo4.setsp_no("SP002");
//		vo4.setVenue_no("V000001");
//		vo4.setSg_maxno(10);
//		vo4.setSg_minno(3);
//		vo4.setSg_extrainfo("NO~~~~~");
//		vo4.setLoc_start_lat(0.0);
//		vo4.setLoc_start_lng(0.0);
//		vo4.setLoc_end_lat(0.0);
//		vo4.setLoc_end_lng(0.0);
//		vo4.setSg_no("S018");
//		is2.close();
//		
//		dao.update(vo4);
//		
//		
//		
////delete測試
//		
//		dao.delete("S021");
//		
//		
////findByPk測試		
		List<Sg_info> list = dao.findBySp("SP003");
		for(Sg_infoVO_android vo2 : list) {
		System.out.println(vo2.getSg_no());
		System.out.println(vo2.getMem_no());
		System.out.println(vo2.getSg_name());
		System.out.println(vo2.getSg_date());
		System.out.println(vo2.getApl_start());
		System.out.println(vo2.getApl_end());
		System.out.println(vo2.getSg_fee());
		System.out.println(vo2.getSg_per());
		System.out.println(vo2.getSp_no());
		System.out.println(vo2.getV_no());
		System.out.println(vo2.getSg_maxno());
		System.out.println(vo2.getSg_minno());
		System.out.println(vo2.getSg_ttlapl());
		System.out.println(vo2.getSg_chkno());
		System.out.println(vo2.getSg_extrainfo());
		System.out.println(vo2.getSg_status());
		System.out.println(vo2.getLoc_start());
		System.out.println(vo2.getLoc_end());
		System.out.println("--------------------------------------");
	}
//		
////getAll測試			
//		List<Sg_infoVO_Android> list = new ArrayList<Sg_infoVO_Android>();
//		list = dao.getAll();
//		for(Sg_infoVO_Android vo2 : list) {
//			System.out.println(vo2.getSg_no());
//			System.out.println(vo2.getMem_no());
//			System.out.println(vo2.getSg_name());
//			System.out.println(vo2.getSg_date());
//			System.out.println(vo2.getApl_start());
//			System.out.println(vo2.getApl_end());
//			System.out.println(vo2.getSg_fee());
//			System.out.println(vo2.getSg_pic());
//			System.out.println(vo2.getSg_pic_ext());
//			System.out.println(vo2.getSg_per());
//			System.out.println(vo2.getsp_no());
//			System.out.println(vo2.getVenue_no());
//			System.out.println(vo2.getSg_maxno());
//			System.out.println(vo2.getSg_minno());
//			System.out.println(vo2.getSg_ttlapl());
//			System.out.println(vo2.getSg_chkno());
//			System.out.println(vo2.getSg_extrainfo());
//			System.out.println(vo2.getSg_status());
//			System.out.println(vo2.getLoc_start_lat());
//			System.out.println(vo2.getLoc_start_lng());
//			System.out.println(vo2.getLoc_end_lat());
//			System.out.println(vo2.getLoc_end_lng());
//			System.out.println("--------------------------------------");
//		}
		
		
		
		
		
		
	}

}
