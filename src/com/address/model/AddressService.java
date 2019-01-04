package com.address.model;

import java.util.List;

public class AddressService {

	private AddressDAO_interface dao;
	public AddressService() {
		dao = new AddressDAO();
	}
	
	public AddressVO addNewAddress(String mem_no,String receiver,String receiver_phone,String country
			,String city,String addr_detail,String addr_zip) {
		AddressVO VO = new AddressVO(mem_no,receiver,
				receiver_phone,country,city,addr_detail,addr_zip);
		dao.insert(VO);
		return VO;
	}
	
	public void deleteAddress(String addr_no) {
		dao.delete(addr_no);
	}
	
	public List<AddressVO> findMyAddress(String mem_no){
		return dao.getByForeignKey(mem_no);
	}
	
	public List<AddressVO> findAll(){
		return dao.getAll();
	}
}
