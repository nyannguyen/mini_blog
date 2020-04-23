<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="Models.User"
	import="java.util.ArrayList"    
    %>
<%
	String current_username = (String)request.getSession().getAttribute("current_username");
	User current_user = User.whereUsername(current_username);
	String current_user_fullName = current_user.getLastname()+" "+current_user.getFirstname();
	
	request.setAttribute("current_user", current_user);
	
	ArrayList<User> search_result = (ArrayList<User>)request.getAttribute("search_result");
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- Common Layout Head -->
  	<jsp:include page="components/header.jsp">
  	<jsp:param name="pageTitle" value="MiniBlog"/>
  	</jsp:include>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

  <!-- Navbar -->
  <jsp:include page="components/navigationbar.jsp">
  <jsp:param value="<%= current_user.requestCount() %>" name="friend_request_count"/>
  </jsp:include>
  <!-- /.navbar -->

  <!-- Main Sidebar -->
  <jsp:include page="components/sidebar.jsp"/>

  <!-- /.main-sidebar -->
  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        <div class="row">
        <%
	       	for(User user: search_result) {
        %>
        <div class="col-md-4">
          <!-- Widget: user widget style 1 -->
          <div class="card card-widget widget-user">
            <!-- Add the bg color to the header using any of the bg-* classes -->
            <div class="widget-user-header bg-info">
              <h3 class="widget-user-username"><%= user.getLastname()+" "+user.getFirstname() %></h3>
              <h5 class="widget-user-desc">@<%= user.getUsername() %></h5>
            </div>
            <div class="widget-user-image">
              <img class="img-circle elevation-2" src="img/avatar5.png" alt="User Avatar">
            </div>
            <div class="card-footer">
              <div class="row">
                <div class="col-sm-6 border-right">
                  <div class="description-block">
                    <h5 class="description-header"><%= user.postCount() %></h5>
                    <span class="description-text">POSTS</span>
                  </div>
                  <!-- /.description-block -->
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                  <div class="description-block">
                    <h5 class="description-header"><%= user.friendsCount() %></h5>
                    <span class="description-text">FRIENDS</span>
                  </div>
                  <!-- /.description-block -->
                </div>
                <!-- /.col -->
              </div>
              <div class="row mt-2">
              	<% 	int relationState = current_user.relationState(user);%>
				<a href="<%= request.getContextPath() %>/profile?user=<%= user.getUsername() %>" class="btn btn-primary btn-block"><b>Profile</b></a>
				<% if (relationState == 1){ %>
                	<a href="<%= request.getContextPath() %>/relation?action=acceptRequest&user=<%= user.getUsername() %>" class="btn btn-success btn-block"><b>Accept Friend Request</b></a>
					<a href="<%= request.getContextPath() %>/relation?action=removeFriend&user=<%= user.getUsername() %>" class="btn btn-danger btn-block"><b>Remove Friend Request</b></a>
                <% } %>
              </div>
              <!-- /.row -->
            </div>
          </div>
          <!-- /.widget-user -->
        </div>
        <% 	} %>
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Control Sidebar -->
  <jsp:include page="components/controlbar.jsp"/>
  <!-- /.control-sidebar -->

  <!-- Main Footer -->
  <jsp:include page="components/footer.jsp"/>
   <!-- /.main-footer -->
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- Common Layout Script -->
<jsp:include page="components/script.jsp"/>

</body>
</html>
