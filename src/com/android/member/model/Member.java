package com.android.member.model;

import java.util.List;

import com.club_memberlist.model.Club_memberlistVO;

public class Member extends MemberVO_android {
	
	private List<Club_memberlistVO> list;
	private List<String> club_name;
	
	public Member() {
	}

	public List<Club_memberlistVO> getList() {
		return list;
	}

	public void setList(List<Club_memberlistVO> list) {
		this.list = list;
	}

	public List<String> getClub_name() {
		return club_name;
	}

	public void setClub_name(List<String> club_name) {
		this.club_name = club_name;
	}

}
