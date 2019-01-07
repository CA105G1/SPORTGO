package com.news.model;

import java.sql.Timestamp;
import java.util.List;

public class NewsService {

	private NewsDAO_interface newsDAO;
	
	public NewsService() {
		newsDAO = new NewsDAO();
	}
	
	public List<NewsVO> getAll(){
		return newsDAO.getAll();
	}
	public List<NewsVO> getReleaseNews(Timestamp nowTime){
		List<NewsVO> list = newsDAO.getReleaseNews(nowTime);
		if(list.size()==0) {
			list = newsDAO.getDefaultNews();
		}
		return list;
	}
	
	public void chargeNewsStutas() {
		// 先針對未發布的NEWS--->調整未發布，調成發布中
		List<NewsVO> list = newsDAO.getNeedToReleaseListNews();
		for(int i = 0; i<list.size(); i++) {
			NewsVO newsVO = list.get(i);
			newsDAO.updateStutasByNewsNo(newsVO.getNews_no(), "發布中");
		}
		// 再針對發布中的NEWS--->調整發布中，調成下架
		List<NewsVO> list2 = newsDAO.getNeedToDiscontinueListNews();
		for(int i = 0; i<list2.size(); i++) {
			NewsVO newsVO = list.get(i);
			newsDAO.updateStutasByNewsNo(newsVO.getNews_no(), "下架");
		}
	}
	
	
	
	public NewsVO addNews(NewsVO newsVO) {
		newsDAO.insert(newsVO);
		return newsVO;
	}
	
	public void update(NewsVO newsVO) {
		newsDAO.update(newsVO);
	}
	public NewsVO getOneNews(String news_no) {
		return newsDAO.findByPrimaryKey(news_no);
	}
}