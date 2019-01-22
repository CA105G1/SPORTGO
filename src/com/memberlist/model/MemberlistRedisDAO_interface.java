package com.memberlist.model;

import java.util.List;

import org.json.JSONException;

import com.google.gson.JsonObject;

public interface MemberlistRedisDAO_interface {

	public void insertRedis(String key,String value);
	public void appendRedis(String key,String type,String title,String value);
	public void deleteRedis(String key,String value);
	public String getValue(String key);
	public List<String> getNotationMsg(String sender);
	public void saveChatMessage(String sender, String receiver, String message) throws JSONException;
	public List<String> getHistoryMsg(String sender);
	public boolean isOpen();
}
