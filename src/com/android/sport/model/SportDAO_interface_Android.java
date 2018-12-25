package com.android.sport.model;

import java.util.List;

public interface SportDAO_interface_Android {
	public void insert(SportVO_Android sportVO);
	public void update(SportVO_Android sportVO);
	public void delete(String sp_no);
	public SportVO_Android findByPk(String sp_no);
	public List<SportVO_Android> getAll();
}
