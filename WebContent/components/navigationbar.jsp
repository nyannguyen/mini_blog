 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="Models.User"
%>
<%
	User current_user = (User)request.getAttribute("current_user");
%>
  
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
    </ul>

    <!-- SEARCH FORM -->
    <form class="form-inline ml-3" action="<%= request.getContextPath() %>/search" method="get">
      <div class="input-group input-group-sm">
        <input class="form-control form-control-navbar" name="key" type="search" placeholder="Search" aria-label="Search">
        <div class="input-group-append">
          <button class="btn btn-navbar" type="submit">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
    </form>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
		<li class="nav-item">
		  <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
		  	<i class="fas fa-users"></i>
		  	<% if(current_user.requestCount()>0) {%>
		  	<span class="badge badge-warning navbar-badge"><%= current_user.requestCount() %></span>
		  	<% } %>
		  </a>
		</li>
    </ul>
  </nav>
