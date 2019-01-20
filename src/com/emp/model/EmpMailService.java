package com.emp.model;

import java.time.chrono.ThaiBuddhistEra;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
public class EmpMailService {
		
	private String emp_name;
	private String emp_auth;
	private String emp_psw;
	private String messageText;
	private String to;
	private String subject;
	
	public EmpMailService(String emp_name, String emp_auth){
		this.emp_name = emp_name;
		this.emp_auth = emp_auth;
		this.emp_psw = getRandomPassword();
	}
	
	private String getRandomPassword() {
		int num;
	    StringBuilder sb = new StringBuilder();
	    for (int i = 0; i < 9; i++) {
	    	num = (int) ((Math.random() * 7) % 3);
	        if (num == 1) { // 放數字
	        	sb.append((int) ((Math.random() * 10)));
	        } else if (num == 2) { // 放大寫英文
	        	sb.append((char) (((Math.random() * 26) + 65)));
	        } else {// 放小寫英文
	        	sb.append(((char) ((Math.random() * 26) + 97)));
	        }
	    }
	    return sb.toString();
	}
	
	public EmpMailService setToWhereMail(String to) {
		this.to = to;
		return this;
	}
	public EmpMailService setSubject(String subject) {
		this.subject = subject;
		return this;
	}
	public EmpMailService setMessageText(String messageText) {
		this.messageText = messageText;
		return this;
	}
	
	public EmpMailService getCanToSetMessageText() {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("Hello,").append(emp_name).append(" : \n")
					 .append("　　")
					 .append("歡迎你的加入，你已成功登記註冊，成為SportGo的").append(emp_auth).append("。\n")
					 .append("請謹記此密碼 : ").append(emp_psw).append(" (已經啟用)\n")
					 .append("Have a nice day.\n")
					 .append("SportGo");
		this.messageText = stringBuilder.toString();
		return this;
	}
	
	// 設定傳送郵件:至收信人的Email信箱,Email主旨,Email內容
	public void sendMail() {	
		try {
			// 設定使用SSL連線至 Gmail smtp Server
		    Properties props = new Properties();
		    props.put("mail.smtp.host", "smtp.gmail.com");
		    props.put("mail.smtp.socketFactory.port", "465");
		    props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		    props.put("mail.smtp.auth", "true");
		    props.put("mail.smtp.port", "465");

		    // ●設定 gmail 的帳號 & 密碼 (將藉由你的Gmail來傳送Email)
		    // ●須將myGmail的【安全性較低的應用程式存取權】打開
		    final String myGmail = "ixlogic.wu@gmail.com";
		    final String myGmail_password = "BBB45678";
		    Session session = Session.getInstance(props, new Authenticator() {
			    protected PasswordAuthentication getPasswordAuthentication() {
				    return new PasswordAuthentication(myGmail, myGmail_password);
			    }
		    });

		    Message message = new MimeMessage(session);
		    message.setFrom(new InternetAddress(myGmail));
		    message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
		  
		    //設定信中的主旨  
		    message.setSubject(subject);
		    //設定信中的內容 
		    message.setText(messageText);

		    Transport.send(message);
		    System.out.println("傳送成功!");
       }catch (MessagingException e){
	        System.out.println("傳送失敗!");
	        e.printStackTrace();
       }
	}
	
	public static void main (String args[]){

//		String to = "ixlogic@pchome.com.tw";
//      
//		String subject = "密碼通知";
//      
//		String ch_name = "testName";
//		String passRandom = "testPSW";
//		String messageText = "Hello! " + ch_name + " 請謹記此密碼: " + passRandom + "\n" +" (已經啟用)"; 
//       
		EmpMailService mailService = new EmpMailService("","");
//		mailService.sendMail(to, subject, messageText);
		
		System.out.println(mailService.getRandomPassword());
		
	}


}
