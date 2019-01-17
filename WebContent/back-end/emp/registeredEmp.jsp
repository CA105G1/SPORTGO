<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.emp.model.EmpVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>CA105G1:back-end:registeredEmp</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style>
		.errorMsgs-color{
			color:red
		}
		
		</style>
		
	</head>
	<body>
		<div class="container-fluid">
			<div class="ros">
				<div class="col-xs-12 col-sm-6 col-sm-offset-1">
					<div class="h1">新增管理員</div>
					<form method="post" action ="<%=request.getContextPath()%>/emp/emp.do">
			<%-------------
						<!-- sample -->
						<div class="form-group">
							<label for=""></label>
							<input type="" name="" id="" value="" class="form-control"/>
						</div>
			-------------%>
						<div class="form-group">
							<label for="emp_name">emp_name</label><span class="pull-right errorMsgs-color">${errorMsgs.get("emp_name")}</span>
							<input type="text" name="emp_name" id="emp_name" value="${empVO_forRes.emp_name}" class="form-control"/>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("newstype_no")}</div>
						</div>
						
						<div class="form-group">
							<label for="emp_account">account</label><span class="pull-right errorMsgs-color">${errorMsgs.get("emp_account")}</span>
							<input type="text" name="emp_account" id="emp_account" value="${empVO_forRes.emp_account}" class="form-control"/>
						</div>
						<!-- TODO: 寄發EMALIL 亂數密碼 -->
						<div class="form-group">
							<label for="emp_psw">password</label><span class="pull-right errorMsgs-color">${errorMsgs.get("emp_psw")}</span>
							<input type="password" name="emp_psw" id="emp_psw" value="${empVO_forRes.emp_psw}" class="form-control"/>
						</div>
						
						
						<div class="form-group">
							<label for="emp_auth">emp_auth</label><span class="pull-right errorMsgs-color">${errorMsgs.get("emp_auth")}</span>
							<select size="1" name="emp_auth" id="emp_auth" class="form-control">
								<option value="normal_emp" selected>管理員</option >
								<option value=""></option>
								<option value="supper_emp">超級管理員</option >
							</select>
<!-- 							<input type="text" name="emp_auth" id="emp_auth" value="" class="form-control"/> -->
						</div>
						
						<div class="form-group">
							<label for="emp_phone">phone</label><span class="pull-right errorMsgs-color">${errorMsgs.get("emp_phone")}</span>
							<input type="text" name="emp_phone" id="emp_phone" value="${empVO_forRes.emp_phone}" class="form-control"/>
						</div>
						
						<div class="form-group">
							<label for="emp_email">email</label><span class="pull-right errorMsgs-color">${errorMsgs.get("emp_email")}</span>
							<input type="email" name="emp_email" id="emp_email" value="${empVO_forRes.emp_email}" class="form-control"/>
						</div>
												
						<div class="form-group">
							<label for="hiredate_for_format">hiredate</label><span class="pull-right errorMsgs-color">${errorMsgs.get("hiredate")}</span>
							<input type="text" name="hiredate" id="hiredate_for_format" class="form-control"
							value='<fmt:formatDate value="${empVO_forRes.hiredate}" pattern="yyyy-MM-dd HH:mm"/>' />
						</div>

						<div class="row">
							<div class="col-xs-12 col-sm-1">
							</div>
							<div class="col-xs-12 col-sm-4">
								<button type="submit" name="action" class="btn btn-info btn-block" value="login_reset"> 清空 </button>
							</div>
							<div class="col-xs-12 col-sm-2"></div>
							<div class="col-xs-12 col-sm-4">
<%-- 								<input type="hidden" name="requestUrl" value="<%=request.getRequestURI()%>"/> --%>
								<input type="hidden" name="requestUrl" value="<%=request.getServletPath()%>"/>
								<button type="submit" name="action" class="btn btn-info btn-block" value="registered_emp"> 註冊 </button>
							</div>
							<div class="col-xs-12 col-sm-1">
							</div>
						</div>
					</form>

				</div>
			</div>
		</div>
		<%-- for test login--%>
<%-- 
		<h4>This is registeredEmp.jsp</h4>
		<form method="post" action="<%=request.getContextPath()%>/emp/emp.do">
			
			emp_name : <input type="text" name="emp_name" value="Daivid"><br>
			emp_auth : <input type="text" name="emp_auth" value="一般管理員"><br>
			phone : <input type="text" name="emp_phone" value="0987654321"><br>
			email : <input type="text" name="emp_email" value="david@iii.com.tw"><br>
			account  : <input type="text" name="emp_account" value="david"><br>
			passwoed : <input type="password" name="emp_psw" value="123456"><br>
			hiredate : <input type="text" name="hiredate" value="2018-12-01" id="hiredate_for_format"><br>


			
<!-- 		empVO.setEmp_name("David"); -->
<!-- 		empVO.setEmp_auth("一般管理員"); -->
<!-- 		empVO.setEmp_phone("0987654321"); -->
<!-- 		empVO.setEmp_email("david@iii.com.tw"); -->
<!-- 		empVO.setEmp_account("david"); -->
<!-- 		empVO.setEmp_psw("123456"); -->
<!-- 		empVO.setHiredate(java.sql.Date.valueOf("2018-12-01")); -->
			
			<input type="hidden" name="action" value="registered_emp">
			<input type="submit" value="registered_emp"><br>
		</from>
--%>			
		<%-- 錯誤表列 --%>
<%--
 		<c:if test="${not empty errorMsgs}">
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
--%>		
		<%-- --------------------------------------------------------- --%>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
<!-- 		<script src="https://code.jquery.com/jquery.js"></script> -->
<!-- 		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
	
	<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#hiredate_for_format').datetimepicker({
           theme: '',              //theme: 'dark',
  	       timepicker:false,       //timepicker:true,
  	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
  	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
<%--   		   value: '<%=empVO.getHiredate()%>', // value:   new Date(), --%>
  		   value: '<%=new java.sql.Date(System.currentTimeMillis())%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
	
</html>