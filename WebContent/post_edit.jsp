<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="Models.User"
    import="Models.Post"
	import="Models.Like"
	import="Models.Comment"
	import="java.util.ArrayList"    
	import="java.util.HashMap"
	import="java.text.SimpleDateFormat"
%>
<%
	String current_username = (String)request.getSession().getAttribute("current_username");
	User current_user = User.whereUsername(current_username);
	String current_user_fullName = current_user.getLastname()+" "+current_user.getFirstname();
	Post post = (Post)request.getAttribute("post");
	
	request.setAttribute("current_user", current_user);
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- Common Layout Head -->
  	<jsp:include page="components/header.jsp">
  	<jsp:param name="pageTitle" value="MiniBlog"/>
  	</jsp:include>
  	
	<!-- summernote -->
	<link rel="stylesheet" href="plugins/summernote/summernote-bs4.css">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

  <!-- Navbar -->
  <jsp:include page="components/navigationbar.jsp">
  <jsp:param value="<%= current_user.requestCount() %>" name="friend_request_count"/>
  </jsp:include>
  <!-- /.navbar -->

  <!-- Main Sidebar -->
  <jsp:include page="components/sidebar.jsp">
    <jsp:param value="<%= current_user_fullName %>" name="current_user_fullName"/>
  	<jsp:param value="active" name="home"/>
  </jsp:include>
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
          <div class="col-12">
          <form method="post">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title">
						  Edit post
						</h3>
						<!-- tools box -->
						<div class="card-tools">
						  <button type="button" class="btn btn-tool btn-sm" data-card-widget="collapse" data-toggle="tooltip"
						          title="Collapse">
						    <i class="fas fa-minus"></i></button>
						  <button type="button" class="btn btn-tool btn-sm" data-card-widget="remove" data-toggle="tooltip"
						          title="Remove">
						    <i class="fas fa-times"></i></button>
						</div>
						<!-- /. tools -->
					</div>
					<!-- /.card-header -->
					<div class="card-body pad">
						<div class="mb-3">
						  <textarea name="post_description" id="txt_newPost" class="textarea"
						            style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
						</div>
						<button type="submit" class="btn btn-block btn-primary">Edit</button>
					</div>
				</div>
			</form>
          </div>          
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

<!-- Summernote -->
<script src="plugins/summernote/summernote-bs4.min.js"></script>

<script src="js/index.js"></script>
<script>
$('#txt_newPost').summernote("code","<%= post.getDescription() %>");
</script>
</body>
</html>
