package com.android.sg_info.model;

import java.util.*;

public interface Sg_infoDAO_interface_Android {
	public void insert(Sg_infoVO_Android sgInfo);
	public void update(Sg_infoVO_Android sgInfo);
	public void delete(String sg_no);
	public List<Sg_info> findBySp(String sp_no);
	public List<Sg_info> getAll();
	public byte[] getImage(String sg_no);
}
