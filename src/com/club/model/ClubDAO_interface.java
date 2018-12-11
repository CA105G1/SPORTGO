package com.club.model;

import java.util.List;

public interface ClubDAO_interface {
	public void insert(ClubVO clubVO);
    public void update(ClubVO clubVO);
    public void delete(String club_no);
    public ClubVO findByPrimaryKey(String clubp_no);
    public List<ClubVO> getAll();
}
