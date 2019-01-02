<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	ProductVO proVO = (ProductVO) request.getAttribute("proVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
	pageContext.setAttribute("list",proVO);
%>

<html> 
<head>
<title>商品類別資料 - listOnePro.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
    .imgsize {
   width: 300px;
   height: auto;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - listOnePro.jsp</h3>
		 <h4><a href="<%= request.getContextPath()%>/back-end/pro/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<td>商品編號</td>
		<td>商品類別編號</td>
		<td>商品名稱</td>
		<td>商品圖片</td>
		<td>照片副檔名</td>
		<td>商品規格</td>
		<td>商品單價</td>
		<td>商品庫存量</td>
		<td>商品安全庫存量</td>
		<td>商品詳述</td>
		<td>商品狀態</td>
		<td>商品總評價</td>
		<td>商品評價總人數</td>
	
	</tr>
	${list.pro_no}
	<tr>
	     <td><%=proVO.getPro_no()%></td>
		 <td><%=proVO.getPro_classid()%></td>
		 <td><%=proVO.getPro_name()%></td>
		 
		 <td><img class="imgsize" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>">
		 
		 <td><%=proVO.getPro_pic_ext()%></td>
		 <td><%=proVO.getPro_format()%></td>
		 <td><%=proVO.getPro_bonus()%></td>
		 <td><%=proVO.getPro_stock()%></td>
		 <td><%=proVO.getPro_safestock()%></td>
		 <td><%=proVO.getPro_details()%></td>
		 <td><%=proVO.getPro_shelve()%></td>
		 <td><%=proVO.getPro_all_assess()%></td>
		 <td><%=proVO.getPro_all_assessman()%></td>
	
	</tr>
</table>

</body>
</html>