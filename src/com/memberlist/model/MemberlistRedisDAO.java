package com.memberlist.model;

import java.util.List;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class MemberlistRedisDAO implements MemberlistRedisDAO_interface {

	private static JedisPool pool = null;
	private static final String AUTH = "123456";
	private static Jedis jedis;
	public MemberlistRedisDAO() {
		super();
		pool = JedisUtil.getJedisPool();
		jedis = pool.getResource();
		jedis.auth(AUTH);
	}

	@Override
	public void insertRedis(String key, String value) {
		jedis.set(key, value);
		jedis.close();
	}

	@Override
	public void appendRedis(String mem_no, String element) {
		jedis.lpush(mem_no, element);//List<String>
		jedis.close();
	}
	
	@Override
	public void deleteRedis(String mem_no,String mem_name) {
		List<String> value = jedis.lrange(mem_no, 0, jedis.llen(mem_no)-1);
		int count = -1;
		for(String list : value) {
			count++;
			if(list==mem_name) {
				break;
			}
		}
		jedis.lrem(mem_no, count, mem_name);
		jedis.close();
	}

	@Override
	public String getValue(String key) {
		String value = jedis.get(key);
		jedis.close();
		return value;
	}

	@Override
	public List<String> getHistoryMsg(String sender, String receiver) {
		String key = new StringBuilder(sender).append(":").append(receiver).toString();
		List<String> historyData = jedis.lrange(key, 0, jedis.llen(key)-1);
		jedis.close();
		return historyData;
	}

	@Override
	public void saveChatMessage(String sender, String receiver, String message) {
		String senderKey = new StringBuilder(sender).append(":").append(receiver).toString();
		String receiverKey = new StringBuilder(receiver).append(":").append(sender).toString();
		jedis.rpush(senderKey, message);
		jedis.rpush(receiverKey, message);
		jedis.close();
	}

	@Override
	public List<String> getNotationMsg(String mem_no) {
		List<String> natation = jedis.lrange(mem_no, 0, jedis.llen(mem_no)-1);
		jedis.close();
		return natation;
	}

	public static void main(String[]args) {
		
//		MemberlistRedisDAO dao = new MemberlistRedisDAO();
//		dao.deleteRedis("M001", "戴資穎");
//		jedis.lrem("M001", 2);
//		jedis.close();
//		dao.insertRedis("Hello", "Redis");
//		System.out.println("safed completed");
//		
//		String value = dao.getValue("Hello");
//		System.out.println(value);
//		
//		dao.deleteRedis("Hello");
//		System.out.println("deleted completed");
	}
}
