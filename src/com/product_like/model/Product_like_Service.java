package com.product_like.model;

import java.sql.Timestamp;
import java.util.List;

import com.ord.model.OrdVO;
import com.orddetails.model.OrddetailsVO;


public class Product_like_Service {
	
	private Product_likeDAO_interface prolikeDAO;
	
	public Product_like_Service () {
		super();
		prolikeDAO = new Product_likeJDBCDAO();
	}
	
	public Product_likeVO addProlike(Product_likeVO product_likeVO) {
		
		Product_likeVO ordVO = new Product_likeVO();
		prolikeDAO.insert(product_likeVO);
	
		return product_likeVO;
	}
	public Product_likeVO deleteProlike(Product_likeVO product_likeVO) {
		
		Product_likeVO ordVO = new Product_likeVO();
		prolikeDAO.delete(product_likeVO);
	
		return product_likeVO;
	}
	
//	public OrdVO getOneOrd (String ord_no) {
//		return ordDAO.findByPK(ord_no);
//	}
//	
//	public List<OrdVO> getAll(){
//		return ordDAO.getAll();
//	}
//	
//	public OrdVO updataStatus (String ord_no ,String ord_status) {
//		return ordDAO.updataStatus(ord_no, ord_status);
//	}
//	
//	public List<OrdVO> getAllmem_no(String mem_no){
//		return ordDAO.getAllmem_no(mem_no);
//	}
//	public OrdDAO addOrd(String Mem_no ,)

}
