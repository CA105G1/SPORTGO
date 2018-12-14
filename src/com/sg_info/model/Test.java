package com.sg_info.model;
import com.sg_info.model.Sg_infoDAO;
import com.sg_info.model.Sg_infoVO;
import com.sport.model.SportDAO;
import com.sport.model.SportVO;

public class Test {

	public static void main(String[] args) {
		Sg_infoDAO dao = new Sg_infoDAO();
		Sg_infoVO vo = dao.findByPk("S001");
		System.out.println(vo.getSg_no());
		System.out.println(vo.getMem_no());
		System.out.println(vo.getSg_name());
		System.out.println(vo.getSg_date());
		System.out.println(vo.getApl_start());
		System.out.println(vo.getApl_end());
		System.out.println(vo.getSg_fee());
		System.out.println(vo.getSg_pic());
		System.out.println(vo.getSg_pic_ext());
		System.out.println(vo.getSg_per());
		System.out.println(vo.getSport_no());
		System.out.println(vo.getVenue_no());
		System.out.println(vo.getSg_maxno());
		System.out.println(vo.getSg_minno());
		System.out.println(vo.getSg_ttlapl());
		System.out.println(vo.getSg_chkno());
		System.out.println(vo.getSg_extrainfo());
		System.out.println(vo.getSg_status());
		System.out.println(vo.getLoc_start_lat());
		System.out.println(vo.getLoc_start_lng());
		System.out.println(vo.getLoc_end_lat());
		System.out.println(vo.getLoc_end_lng());
	}

}
