package com.android.sg_rep.model;

import java.sql.SQLException;
import java.util.List;

public interface Sg_repDAO_interface_android {
	public void insert(Sg_repVO_android sg_repVO) throws SQLException;
	public void update(Sg_repVO_android sg_repVO);
	public void delete(String rep_no);
	public List<Sg_rep> findByMem(String rep_no);
	public List<Sg_rep> getAll();
}
