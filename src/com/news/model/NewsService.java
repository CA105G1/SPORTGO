package com.news.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class NewsService {
	
	//private static final String NEW_STUTAS_BEFORE_RELEASE = "未發布";
	private static final String NEW_STUTAS_RELEASE = "發布中";
	private static final String NEW_STUTAS_OUT_OF_TIME = "下架";
	
	private NewsDAO_interface newsDAO;
	
	public NewsService() {
		newsDAO = new NewsDAO();
	}
	
	public List<NewsVO> getAll(){
		return newsDAO.getAll();
	}
	
	public List<NewsVO> getAll(Map<String, String[]> map){
		return newsDAO.getAll(map);
	}
	// Map<String, String>---> Map<NewsType_name, NewsType_no>
	public List<NewsVO> getReleaseNewsAndChooseNewsType(Timestamp nowTime, Map<String,String> whatToJionNewstypeMap){
		List<NewsVO> list = newsDAO.getReleaseNews(nowTime);
		List<NewsVO> newList = new ArrayList<>();
		for(int i =0 ; i<list.size(); i++) {
			for(String key : whatToJionNewstypeMap.keySet()) {
				if(list.get(i).getNewstype_no().equals(whatToJionNewstypeMap.get(key))) {
					newList.add(list.get(i));
					continue;
				}
			}
		}
		if(newList.size()==0) {
			newList = newsDAO.getDefaultNews();
		}
		return newList;
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
//		System.out.println("newsDAO.getNeedToReleaseListNews() :" + list.size());
//		System.out.println(list);
		for(int i = 0; i<list.size(); i++) {
			NewsVO newsVO = list.get(i);
			newsDAO.updateStutasByNewsNo(newsVO.getNews_no(), NEW_STUTAS_RELEASE);
		}
		// 再針對發布中的NEWS--->調整發布中，調成下架
		List<NewsVO> list2 = newsDAO.getNeedToDiscontinueListNews();
//		System.out.println("newsDAO.getNeedToDiscontinueListNews() :" + list2.size());
//		System.out.println(list2);
		for(int i = 0; i<list2.size(); i++) {
			NewsVO newsVO = list2.get(i);
			newsDAO.updateStutasByNewsNo(newsVO.getNews_no(), NEW_STUTAS_OUT_OF_TIME);
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
	public void delete(String news_no) {
		newsDAO.delete(news_no);
	}
	
	
}
