package com.multimedia.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Arrays;

public class MultimediaVO implements Serializable{
	private static final long serialVersionUID = -1316074584045926207L;
	
	private String media_no;
	private String file_extension;
	private byte[] media_content;
	private String club_no;
	private String mem_no;
	private Timestamp media_releasedate;
	private String media_title;
	
	public MultimediaVO(){
	}

	public String getMedia_no() {
		return media_no;
	}

	public void setMedia_no(String media_no) {
		this.media_no = media_no;
	}

	public String getFile_extension() {
		return file_extension;
	}

	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}

	public byte[] getMedia_content() {
		return media_content;
	}

	public void setMedia_content(byte[] media_content) {
		this.media_content = media_content;
	}

	public String getClub_no() {
		return club_no;
	}

	public void setClub_no(String club_no) {
		this.club_no = club_no;
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	public Timestamp getMedia_releasedate() {
		return media_releasedate;
	}

	public void setMedia_releasedate(Timestamp media_releasedate) {
		this.media_releasedate = media_releasedate;
	}

	public String getMedia_title() {
		return media_title;
	}

	public void setMedia_title(String media_title) {
		this.media_title = media_title;
	}

	@Override
	public String toString() {
		return "MultimediaVO [media_no=" + media_no + ", file_extension=" + file_extension + ", media_content="
				+ Arrays.toString(media_content) + ", club_no=" + club_no + ", mem_no=" + mem_no
				+ ", media_releasedate=" + media_releasedate + ", media_title=" + media_title + "]";
	}
	
	
	
}
