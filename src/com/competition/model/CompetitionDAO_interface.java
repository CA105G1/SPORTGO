package com.competition.model;

import java.util.List;

public interface CompetitionDAO_interface {
	
	public void insert(CompetitionVO competitionVO);
    public void update(CompetitionVO competitionVO);
    public void delete(Integer comp_no);
    public CompetitionVO findByPrimaryKey(Integer comp_no);
    public List<CompetitionVO> getAll();
    public List<CompetitionVO> getCompetitionByDeptno(Integer comp_no);
	
}
