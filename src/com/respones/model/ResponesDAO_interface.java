package com.respones.model;

import java.util.List;
import java.util.Map;


public interface ResponesDAO_interface {
	public void insert(ResponesVO responesVO);
    public void update(ResponesVO responesVO);
//    public void delete(String res_no);
    public ResponesVO findByPrimaryKey(String res_no);
    public List<ResponesVO> getAll();
    public List<ResponesVO> getAll(Map<String, String[]> map);
	public List<ResponesVO> getallfrompost(String post_no);
	public void delete(String res_no, String mem_no);//刪除回文必須是原本留言者
	public void deleteBypostno(String res_no);//刪除貼文前要先刪回文
}
