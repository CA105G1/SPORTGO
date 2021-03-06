package com.product_like.model;

import java.util.List;


public interface Product_likeDAO_interface {
	//push like button use insert
	public void insert(Product_likeVO product_likeVO);
	//push dislike button use delete
	public void delete(Product_likeVO product_likeVO);
	//find how much people like this Product
	public List<Product_likeVO> Product_getAll(String product_no);
	//find this people like which Products
	public List<Product_likeVO> Mem_getAll(String mem_no);
	//find people like and Product
	public Product_likeVO select(String product_no , String mem_no);
}
