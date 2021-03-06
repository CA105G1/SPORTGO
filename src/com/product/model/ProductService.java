package com.product.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.productclass.model.ProductClassVO;

public class ProductService {
	
	private ProductDAO_interface proDAO;

	public ProductService() {
        super();
		proDAO = new ProductJDBCDAO();
		
	}
	
	public List<ProductAssessVO> getProAssess(){
		List<ProductAssessVO> list = new ArrayList<>();
		list = proDAO.getAllAssess();
		return list;
	}
	
	public List<ProductAssessVO> getProAssesslike(String pro_classid){
		List<ProductAssessVO> list = new ArrayList<>();
		list = proDAO.getAllAssesslike(pro_classid);
		return list;
	}
	
	public ProductVO addPro(String pro_classid ,String pro_name ,byte[]   pro_pic ,
			String pro_pic_ext ,String pro_format ,Integer pro_bonus ,
			Integer pro_stock ,Integer pro_safestock ,String pro_details ,
			String pro_shelve ,Integer pro_all_assess ,Integer pro_all_assessman) {
		
		ProductVO proVO = new ProductVO();

		 proVO.setPro_classid(pro_classid);
		 proVO.setPro_name(pro_name);
		 proVO.setPro_pic(pro_pic);
		 proVO.setPro_pic_ext(pro_pic_ext);
		 proVO.setPro_format(pro_format);
		 proVO.setPro_bonus(pro_bonus);
		 proVO.setPro_stock(pro_stock);
		 proVO.setPro_safestock(pro_safestock);
		 proVO.setPro_details(pro_details);
		 proVO.setPro_shelve(pro_shelve);
		 proVO.setPro_all_assess(pro_all_assess);
		 proVO.setPro_all_assessman(pro_all_assessman);
		 proDAO.insert(proVO);
		
		return proVO;
	}
	
	public ProductVO updatePro (String pro_no,String pro_classid ,String pro_name ,byte[] pro_pic ,
			String pro_pic_ext ,String pro_format ,Integer pro_bonus ,
			Integer pro_stock ,Integer pro_safestock ,String pro_details ,
			String pro_shelve ,Integer pro_all_assess ,Integer pro_all_assessman ) {
		
		 ProductVO proVO = new ProductVO();
         
		 proVO.setPro_no(pro_no);
		 proVO.setPro_classid(pro_classid);
		 proVO.setPro_name(pro_name);
		 proVO.setPro_pic(pro_pic);
		 proVO.setPro_pic_ext(pro_pic_ext);
		 proVO.setPro_format(pro_format);
		 proVO.setPro_bonus(pro_bonus);
		 proVO.setPro_stock(pro_stock);
		 proVO.setPro_safestock(pro_safestock);
		 proVO.setPro_details(pro_details);
		 proVO.setPro_shelve(pro_shelve);
		 proVO.setPro_all_assess(pro_all_assess);
		 proVO.setPro_all_assessman(pro_all_assessman);
		 

		 proDAO.update(proVO);
		 
		return proVO;
	}
	
	public ProductVO getOneProduct (String pro_no) {
	    return proDAO.findByPK(pro_no);	
	}
	
	public List<ProductVO> getAll(){
		return proDAO.getAll();
	} 
	
	public List<ProductVO> getAll(Map<String, String[]> map) {//前端使用複合
		return proDAO.getAll(map);
	}
	public List<ProductVO> getAll_back(Map<String, String[]> map) {//前端使用複合
		return proDAO.getAll(map);
	}
	public List<ProductVO> getAllOnShelve(){
		return proDAO.getAllOnShelve();
	}
	public void deletePro (String pro_no) {
		proDAO.delete(pro_no);
	}
	
	public void updateShelve(String pro_no,String pro_shelve) {
		proDAO.updateShelve(pro_no, pro_shelve);
	}
	
	public ProductVO getLastProduct() {
		return proDAO.getLastVO();
	}
	
	public int updateStock(String pro_no,Integer cart_pro_stock) {
		return proDAO.updateStock(pro_no, cart_pro_stock);
	}
	public ProductVO getProductStock(String pro_no,Integer cart_pro_stock) {
		return proDAO.getSelectStock(pro_no, cart_pro_stock);
	}
	//更新評價分數
	public int getUpdateAssess(String pro_no,Integer pro_all_assess) {
		return proDAO.updateAssess(pro_no, pro_all_assess);
	}

}

