<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr><th>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="get_all_venue"/>
					<input type="submit" value="get_all_venue"/>		
				</form>
		</th></tr>
		<tr><th>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="get_one_venue"/>
					<input type="submit" value="get_one_venue"/>		
				</form>
		</th></tr>
		<tr><th>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="listVenueByCompositeQuery"/>
					<input type="submit" value="listVenueByCompositeQuery"/>		
				</form>
		</th></tr>
		<tr><th>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="listVenueByCompostieQueryForFrontEnd"/>
					<input type="submit" value="listVenueByCompostieQueryForFrontEnd"/>		
				</form>
		</th></tr>
		<tr><th>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="updateForQuerry"/>
					<input type="submit" value="updateForQuerry"/>		
				</form>
		</th></tr>
		<tr><th>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="update_cancel"/>
					<input type="submit" value="update_cancel"/>		
				</form>
		</th></tr>
		<tr><th>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="update_commit"/>
					<input type="submit" value="update_commit"/>		
				</form>
		</th></tr>
		<tr><th>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="delete"/>
					<input type="submit" value="delete"/>		
				</form>
		</th></tr>
	</table>

	
	
	


</body>
</html>