package com.address.model;

import java.util.List;

public interface AddressDAO_interface {
	public void insert(AddressVO address);
	public void delete(String addr_no);
	public List<AddressVO> getByForeignKey(String mem_no);
	public List<AddressVO> getAll();
}
