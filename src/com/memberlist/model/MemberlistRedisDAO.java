package com.memberlist.model;

import redis.clients.jedis.Jedis;

public class MemberlistRedisDAO implements MemberlistRedisDAO_interface {

	private static final String HOST = "localhost";
	private static final Integer PORT = 6379;
	private static final String AUTH = "123456";
	private Jedis jedis = null;
	public MemberlistRedisDAO() {
		super();
		jedis = new Jedis(HOST,PORT);
		jedis.auth(AUTH);
	}

	@Override
	public void insertRedis(String key, String value) {
		jedis.set(key, value);
		jedis.close();
	}

	@Override
	public void appendRedis(String key, String value) {
		jedis.append(key, value);
		jedis.close();
	}
	
	@Override
	public void deleteRedis(String key) {
		jedis.del(key);
		jedis.close();
	}

	@Override
	public String getValue(String key) {
		String value = jedis.get(key);
		jedis.close();
		return value;
	}


	public static void main(String[]args) {
		MemberlistRedisDAO dao = new MemberlistRedisDAO();
		dao.insertRedis("Hello", "Redis");
		System.out.println("safed completed");
		
		String value = dao.getValue("Hello");
		System.out.println(value);
//		
//		dao.deleteRedis("Hello");
//		System.out.println("deleted completed");
	}

}
