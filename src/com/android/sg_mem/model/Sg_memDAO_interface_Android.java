package com.android.sg_mem.model;

import java.util.List;

public interface Sg_memDAO_interface_Android {
	public void insert(Sg_memVO_Android sg_memVO);
	public void update(Sg_memVO_Android sg_memVO);
	public void delete(String sg_no, String mem_no);
	public List<Sg_mem> findBySG(String sg_no);

}
