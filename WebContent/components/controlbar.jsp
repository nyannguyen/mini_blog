<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="Models.User"
%>
<%
	User current_user = (User)request.getAttribute("current_user");
%>

<aside class="control-sidebar control-sidebar-dark">
  <!-- Control sidebar content goes here -->
  <div class="p-3">
    <h5>Friends</h5>
    <a href="<%= request.getContextPath() %>/requests"><%= current_user.requestCount() %> friend requests</a>
    <hr class="mb-2">
    <%
    	for(User user: current_user.getAllFriends()) {
    %>
    	<div class="mb-1 friends-list">
	   		<div class="user-panel mt-3 pb-3 mb-3 d-flex">
		        <div class="image">
		          <img src="img/avatar5.png" class="img-circle elevation-2" alt="User Image">
		        </div>
		        <div class="info">
		          <a href="<%= request.getContextPath() %>/profile?user=<%= user.getUsername() %>" class="d-block"><%= user.getLastname()+" "+user.getFirstname() %></a>
		        </div>
		    </div>
    	</div>
    <% } %>
  </div>
</aside>
