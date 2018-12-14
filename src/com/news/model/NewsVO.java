package com.news.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Arrays;

public class NewsVO implements Serializable{
	private static final long serialVersionUID = 3090317870143707331L;

	public static final String STUTAS_DEFAULT = "未發布";
	
	private String news_no;
	private String news_typeno;
	private String news_script;
	private String pic_extension;
	private byte[] news_picture;
	private String news_stutas;
	private Timestamp news_release_date;
	private Timestamp news_last_date;
	
	public NewsVO() {}

	public String getNews_no() {
		return news_no;
	}

	public void setNews_no(String news_no) {
		this.news_no = news_no;
	}

	public String getNews_typeno() {
		return news_typeno;
	}

	public void setNews_typeno(String news_typeno) {
		this.news_typeno = news_typeno;
	}

	public String getNews_script() {
		return news_script;
	}

	public void setNews_script(String news_script) {
		this.news_script = news_script;
	}

	public String getPic_extension() {
		return pic_extension;
	}

	public void setPic_extension(String pic_extension) {
		this.pic_extension = pic_extension;
	}

	public byte[] getNews_picture() {
		return news_picture;
	}

	public void setNews_picture(byte[] news_picture) {
		this.news_picture = news_picture;
	}

	public String getNews_stutas() {
		return news_stutas;
	}

	public void setNews_stutas(String news_stutas) {
		this.news_stutas = news_stutas;
	}

	public Timestamp getNews_release_date() {
		return news_release_date;
	}

	public void setNews_release_date(Timestamp news_release_date) {
		this.news_release_date = news_release_date;
	}

	public Timestamp getNews_last_date() {
		return news_last_date;
	}

	public void setNews_last_date(Timestamp news_last_date) {
		this.news_last_date = news_last_date;
	}

	@Override
	public String toString() {
		return "NewsVO [news_no=" + news_no + ", news_typeno=" + news_typeno + ", news_script=" + news_script
				+ ", pic_extension=" + pic_extension + ", news_picture=" + Arrays.toString(news_picture)
				+ ", news_stutas=" + news_stutas + ", news_release_date=" + news_release_date + ", news_last_date="
				+ news_last_date + "]";
	}
	
	
	
	
}
