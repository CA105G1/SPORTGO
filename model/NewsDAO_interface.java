package com.news.model;

import java.util.List;
import java.sql.Timestamp;

public interface NewsDAO_interface {
	
	public void insert(NewsVO newsVO);
    public void update(NewsVO newsVO);
    public void updateStutasByNewsNo(String news_no ,String news_stutas);
    public void delete(String news_no);
    public NewsVO findByPrimaryKey(String news_no);
    public List<NewsVO> getAll();
    public List<NewsVO> getNewsByNewtype(String newstype_no);
	public List<NewsVO> getReleaseNews(Timestamp nowTime);
	public List<NewsVO> getDefaultNews();
	public List<NewsVO> getNeedToReleaseListNews();
	public List<NewsVO> getNeedToDiscontinueListNews();
	
}
