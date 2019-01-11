package com.memberlist.model;

import java.util.List;

public interface MemberlistRedisDAO_interface {

	public void insertRedis(String key,String value);
	public void appendRedis(String key,String value);
	public void deleteRedis(String key,String value);
	public String getValue(String key);
	public List<String> getHistoryMsg(String sender,String receiver);
	public List<String> getNotationMsg(String sender);
	public void saveChatMessage(String sender, String receiver, String message);
}
