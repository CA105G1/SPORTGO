package com.shoppingcart.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



import com.product.model.ProductJDBCDAO;
import com.product.model.ProductService;
import com.product.model.ProductVO;

import redis.clients.jedis.Jedis;

public class ShoppingcartDAO implements Shoppingcart_interface{
	private static final String HOST = "localhost";
	private static final Integer PORT = 6379;
	private static final String AUTH = "123456";
	
	public ShoppingcartDAO() {
		super();
	}
	@Override
	public void insert(ShoppingcartVO cartVO) {
		
		Jedis jedis = new Jedis(HOST, PORT);
		jedis.auth(AUTH);
		
//			String job = new JSONObject(cartVO).toString();
//			jedis.set(cartVO.getMem_no(), job);
//			System.out.println(jedis.get(cartVO.getMem_no()));
		HashMap<String, String> data = new HashMap<>();  //將資料包成HashMap型態 一次存起來
		data.put(cartVO.getPro_no(), String.valueOf(cartVO.getPro_count()));
		String test = cartVO.getMem_no();
		jedis.hmset(cartVO.getMem_no(), data);
		
		
		jedis.close();
	}
	

	@Override
	public Map<String , String> getAll(String mem_no) {
		Jedis jedis = new Jedis(HOST, PORT);
		jedis.auth(AUTH);
		List<ProductVO> proVOList = new ArrayList<>();
		List<Integer> pro_countList = new ArrayList<>();
		ProductService proSvc = new ProductService();
		ProductJDBCDAO proDAO = new ProductJDBCDAO();//test
		
		
		Map<String , String> hAll = jedis.hgetAll(mem_no);
//		for (String pro_no : hAll.keySet()) {
//			proVOList.add(proSvc.getOneProduct(pro_no));
//			pro_countList.add(Integer.parseInt(hAll.get(pro_no)));
//		}
//		jedis.hdel("M001", "P001");
		
		 return hAll;
	}
	
	@Override
	public void delete(String mem_no, String pro_no) {
		Jedis jedis = new Jedis(HOST, PORT);
		jedis.auth(AUTH);
		jedis.hdel(mem_no, pro_no);
		
	}
	
	@Override
	public Integer findByCount(String mem_no, String pro_no) {
		Jedis jedis = new Jedis(HOST, PORT);
		jedis.auth(AUTH);
		Integer count = 0;
		
		count = Integer.parseInt(jedis.hget(mem_no, pro_no));
		return count;
	}
	
	public static void main(String[] args) {
		
		ShoppingcartDAO cartDAO = new ShoppingcartDAO();
		
		//放入
		ShoppingcartVO cartVO = new ShoppingcartVO();
//		cartVO.setMem_no("M001");
//		cartVO.setPro_no("P006");
//		cartVO.setPro_count(999000);
//		cartDAO.insert(cartVO);
		
//		//取出
//		List<ProductVO> proVOList = new ArrayList<>();
//		ProductService proSvc = new ProductService();
//		Map<String , String> hAll =  cartDAO.getAll("M001");
////		String pro_no = "P001";
//		for (String pro_no : hAll.keySet()) {
//			proVOList.add(proSvc.getOneProduct(pro_no));
//
//		}
		
//    	//多筆查詢
//    	List<ProductVO> provolist =proVOList;
//    	for (ProductVO proVO4 : provolist) {
//        	System.out.println(proVO4.getPro_no() + ",");
//        	System.out.println(proVO4.getPro_classid() + ",");
//        	System.out.println(proVO4.getPro_name() + ",");
//        	System.out.println(proVO4.getPro_pic() + ",");
//        	System.out.println(proVO4.getPro_pic_ext() + ",");
//        	System.out.println(proVO4.getPro_format() + ",");
//        	System.out.println(proVO4.getPro_bonus() + ",");
//        	System.out.println(proVO4.getPro_stock() + ",");
//        	System.out.println(proVO4.getPro_safestock() + ",");
//        	System.out.println(proVO4.getPro_details() + ",");
//        	System.out.println(proVO4.getPro_shelve() + ",");
//        	System.out.println(proVO4.getPro_all_assess() + ",");
//        	System.out.println(proVO4.getPro_all_assessman() + ",");
//        	System.out.println("-----------------------------------");
//    	}
		
//		//移除
//		String mem_no = "M001";
//		String pro_no = "P001";
//		cartDAO.delete(mem_no, pro_no);
		
		//查詢單筆
//		String mem_no = "M001";
//		String pro_no = "P006";
//		cartDAO.findByCount(mem_no, pro_no);
	}
	
	
}
