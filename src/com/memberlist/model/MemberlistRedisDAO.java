package com.memberlist.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class MemberlistRedisDAO implements MemberlistRedisDAO_interface {

	private JedisPool pool;
	private static final String AUTH = "123456";
	private Jedis jedis;
	
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
	public void appendRedis(String mem_no, String type,String title,String element) {
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String time = df.format(Calendar.getInstance().getTimeInMillis());
		String value = "{"
				+ "\"userName\":"+"\""+mem_no+"\""
				+ ",\"type\":"+"\""+type+"\""
				+ ",\"message\":"+"\""+element+"\""
				+ ",\"to\":"+"\""+title+"\""
				+ ",\"time\":"+"\""+ time +"\""
				+ "}";
		jedis.lpush(mem_no, value);//List<String>
		jedis.close();
	}
	
	@Override
	public void deleteRedis(String mem_no,String mem_name) {
		List<String> value = jedis.lrange(mem_no, 0, jedis.llen(mem_no)-1);
		int count = -1;
		for(String list : value) {
			count++;
			JSONObject json = new JSONObject();
			String message=null;
			try {
				message = json.getJSONObject(list).getString("to");
			} catch (JSONException e) {
				e.printStackTrace();
			}
			 if(message.equals(mem_name))
				 jedis.lrem(mem_no,count ,mem_name); 
		}
//		int count = -1;
//		for(String list : value) {
//			count++;
//			if(list==mem_name) {
//				break;
//			}
//		}
//		jedis.lrem(mem_no, count, mem_name);
		jedis.close();
	}

	@Override
	public String getValue(String key) {
		String value = jedis.get(key);
		jedis.close();
		return value;
	}

	@Override
	public List<String> getHistoryMsg(String sender) {
		List<String> historyData = jedis.lrange(sender, 0, jedis.llen(sender)-1);
		jedis.close();
		for (String x: historyData) {
			System.out.println(x);
		}
		return historyData;
	}

	@Override
	public void saveChatMessage(String sender, String receiver, String message) throws JSONException {
		jedis.rpush(sender, message.toString());
		jedis.rpush(receiver, message.toString());
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

	@Override
	public boolean isOpen() {
		return jedis.isConnected();
	}

}
