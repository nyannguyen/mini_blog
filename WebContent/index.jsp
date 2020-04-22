<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="Models.User"
    %>
<%
	String current_username = (String)request.getSession().getAttribute("current_username");
	User current_user = User.whereUsername(current_username);
	String current_user_fullName = current_user.getLastname()+" "+current_user.getFirstname(); 
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
  <jsp:include page="components/navigationbar.jsp"/>
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
			<div class="card card-outline card-info">
				<div class="card-header">
					<h3 class="card-title">
					  Write something today...
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
				    <textarea id="txt_newPost" class="textarea" placeholder="Place some text here"
				              style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
				  </div>
				  <button type="button" class="btn btn-block btn-primary">Post</button>
				</div>
			</div>
          </div>
          
          <div class="col-12">
          	<div class="card card-widget">
              <div class="card-header">
                <div class="user-block">
                  <img class="img-circle" src="img/avatar5.png" alt="User Image">
                  <span class="username"><a href="#">Jonathan Burke Jr.</a></span>
                  <span class="description">Shared publicly - 7:30 PM Today</span>
                </div>
                <!-- /.user-block -->
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                  </button>
                </div>
                <!-- /.card-tools -->
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <!-- post text -->
                <p>Far far away, behind the word mountains, far from the
                  countries Vokalia and Consonantia, there live the blind
                  texts. Separated they live in Bookmarksgrove right at</p>

                <p>the coast of the Semantics, a large language ocean.
                  A small river named Duden flows by their place and supplies
                  it with the necessary regelialia. It is a paradisematic
                  country, in which roasted parts of sentences fly into
                  your mouth.</p>

                <!-- Social sharing buttons -->
                <button type="button" class="btn btn-default btn-sm"><i class="far fa-thumbs-up"></i> Like</button>
                <span class="float-right text-muted">45 likes - 2 comments</span>
              </div>
              <!-- /.card-body -->
              <div class="card-footer card-comments">
                <div class="card-comment">
                  <!-- User image -->
                  <img class="img-circle img-sm" src="img/avatar5.png" alt="User Image">

                  <div class="comment-text">
                    <span class="username">
                      Maria Gonzales
                      <span class="text-muted float-right">8:03 PM Today</span>
                    </span><!-- /.username -->
                    It is a long established fact that a reader will be distracted
                    by the readable content of a page when looking at its layout.
                  </div>
                  <!-- /.comment-text -->
                </div>
                <!-- /.card-comment -->
                <div class="card-comment">
                  <!-- User image -->
                  <img class="img-circle img-sm" src="img/avatar5.png" alt="User Image">

                  <div class="comment-text">
                    <span class="username">
                      Nora Havisham
                      <span class="text-muted float-right">8:03 PM Today</span>
                    </span><!-- /.username -->
                    The point of using Lorem Ipsum is that it hrs a morer-less
                    normal distribution of letters, as opposed to using
                    'Content here, content here', making it look like readable English.
                  </div>
                  <!-- /.comment-text -->
                </div>
                <!-- /.card-comment -->
              </div>
              <!-- /.card-footer -->
              <div class="card-footer">
                <form action="#" method="post">
                  <img class="img-fluid img-circle img-sm" src="img/avatar5.png" alt="Alt Text">
                  <!-- .img-push is used to add margin to elements next to floating images -->
                  <div class="img-push">
                    <input type="text" class="form-control form-control-sm" placeholder="Press enter to post comment">
                  </div>
                </form>
              </div>
              <!-- /.card-footer -->
            </div>
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
</body>
</html>
