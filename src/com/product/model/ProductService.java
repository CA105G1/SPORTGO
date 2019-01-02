package com.product.model;

import java.util.List;
import java.util.Map;

import com.productclass.model.ProductClassVO;

public class ProductService {
	
	private ProductDAO_interface proDAO;

	public ProductService() {
        super();
		proDAO = new ProductJDBCDAO();
		
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
	
	public List<ProductVO> getAll(Map<String, String[]> map) {
		return proDAO.getAll(map);
	}
	
	public void deletePro (String pro_no) {
		proDAO.delete(pro_no);
	}
	
}
