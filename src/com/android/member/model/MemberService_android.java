package com.android.member.model;

import java.util.ArrayList;
import java.util.List;

import com.club.model.ClubService;
import com.club_memberlist.model.Club_memberlistService;
import com.club_memberlist.model.Club_memberlistVO;

public class MemberService_android {

	private MemberDAO_interface_android dao;
	private Club_memberlistService service = new Club_memberlistService();
	private ClubService cService = new ClubService();
	
	public MemberService_android() {
		dao = new MemberDAO_android();
		
	}
	
	public Member getMember(String mem_no) {
		List<Club_memberlistVO> clublist = service.getByMem(mem_no);
		List<String> nameList = new ArrayList<>();
		Member member = dao.findByPrimaryKey(mem_no);
		
		for (Club_memberlistVO x : clublist) {
			nameList.add(cService.getOneClub(x.getClub_no()).getClub_name());
		}
		
		member.setClub_name(nameList);
		member.setList(clublist);
		
		return member;
		
	}

	public Member isMember(String mem_account, String mem_pswd) throws Exception {
		Member member = dao.isMember(mem_account, mem_pswd);
		List<Club_memberlistVO> clublist = service.getByMem(member.getMem_no());
		List<String> nameList = new ArrayList<>();
		
		for (Club_memberlistVO x : clublist) {
			nameList.add(cService.getOneClub(x.getClub_no()).getClub_name());
		}
		
		member.setClub_name(nameList);
		member.setList(clublist);
		
		return member;

	}
	
	public byte[] getProfilePic(String mem_no) {
		return dao.getImage(mem_no);
	}

}
