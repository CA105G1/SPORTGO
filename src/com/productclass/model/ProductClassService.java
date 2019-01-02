package com.productclass.model;

import java.util.List;

public class ProductClassService {
	
	private ProductClassDAO_interface proClassDAO ;

	public ProductClassService() {
		super();
		proClassDAO = new ProductClassJDBCDAO();
	}
	
	public ProductClassVO addProClass(String pro_classid,String pro_classname) {
		
		ProductClassVO productClassVO = new ProductClassVO();
		
		productClassVO.setPro_classid(pro_classid);
		productClassVO.setPro_classname(pro_classname);
		proClassDAO.insert(productClassVO);
		
		return productClassVO;
	}
	
	public ProductClassVO updateProductClass(String pro_classid,String pro_classname) {
		
		ProductClassVO productClassVO = new ProductClassVO();
		productClassVO.setPro_classid(pro_classid);
		productClassVO.setPro_classname(pro_classname);
		proClassDAO.update(productClassVO);
		
		return productClassVO;
	}
	
	public void deleteProductClass (String pro_classid) {
		proClassDAO.delete(pro_classid);
	}
	
	public ProductClassVO getOneProductClass (String pro_classid) {
	    return proClassDAO.findByPK(pro_classid);	
	}
	
	public List<ProductClassVO> getAll(){
		return proClassDAO.getAll();
	}
	
}
