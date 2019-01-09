package com.memberlist.model;

public interface MemberlistRedisDAO_interface {

	public void insertRedis(String key,String value);
	public void appendRedis(String key,String value);
	public void deleteRedis(String key);
	public String getValue(String key);
}
