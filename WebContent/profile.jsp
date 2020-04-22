<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="Models.User"    
    %>
<%
	String current_username = (String)request.getSession().getAttribute("current_username");
	User current_user = User.whereUsername(current_username);
	String current_user_fullName = current_user.getLastname()+" "+current_user.getFirstname(); 
	User profile_user = (User)request.getSession().getAttribute("profile_user");
	int relationState = current_user.relationState(profile_user);
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- Common Layout Head -->
  	<jsp:include page="components/header.jsp">
  	<jsp:param name="pageTitle" value="MiniBlog | Profile"/>
  	</jsp:include>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

  <!-- Navbar -->
  <jsp:include page="components/navigationbar.jsp"/>
  <!-- /.navbar -->

  <!-- Main Sidebar -->
  <jsp:include page="components/sidebar.jsp">
    <jsp:param value="<%= current_user_fullName %>" name="current_user_fullName"/>
  	<jsp:param value="active" name="profile"/>
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
          <div class="col-md-3">

            <!-- Profile Image -->
            <div class="card card-primary card-outline">
              <div class="card-body box-profile">
                <div class="text-center">
                  <img class="profile-user-img img-fluid img-circle"
                       src="img/avatar5.png"
                       alt="User profile picture">
                </div>

                <h3 class="profile-username text-center">${ profile_user.lastname } ${ profile_user.firstname }</h3>

                <p class="text-muted text-center">@${ profile_user.username }</p>

                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item">
                    <b>Friends</b> <a class="float-right">${ profile_user.friendsCount() }</a>
                  </li>
                </ul>
                
                <% if (!current_user.equals(profile_user)){ %>
                	<!-- Show add friend button if they have not been connected -->
	                <% if (relationState == -1){ %>
	                	<a href="#" class="btn btn-primary btn-block"><b>Add friend</b></a>
	                <% } %>
	                <!-- Show pending button if they are waiting other to accept the invitation -->
	                <% if (relationState == 0){ %>
	                	<button class="btn btn-warning btn-block"><b>Invitation sending...</b></a>
	                <% } %>
	                <!-- Show friend button if they have already connected -->
	                <% if (relationState == 1){ %>
	                	<a href="#" class="btn btn-default btn-block"><b>Friend</b></a>
	                <% } %>
                <% } %>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
          <div class="col-md-9">
            <div class="card">
			<% if (current_user.equals(profile_user) || relationState == 1){ %>
              <div class="card-header p-2">
                <ul class="nav nav-pills">
                  	<li class="nav-item"><a class="nav-link active" href="#timeline" data-toggle="tab">Timeline</a></li>
                  	<% if (current_user.equals(profile_user)){ %>
                  	<li class="nav-item"><a class="nav-link" href="#activity" data-toggle="tab">Activity</a></li>
                  	<li class="nav-item"><a class="nav-link" href="#settings" data-toggle="tab">Settings</a></li>
                  	<% } %>
                </ul>
              </div><!-- /.card-header -->
            <% } %>
              <div class="card-body">
                <div class="tab-content">
                  <div class="active tab-pane" id="timeline">
                  	<div style="text-align:center;">
                  		<span>Empty</span>
                  	</div>
                  </div>
                  <!-- /.tab-pane -->
                  <div class="tab-pane" id="activity">
                    <!-- The timeline -->
                    <div class="timeline timeline-inverse">
                      <!-- timeline time label -->
                      <div class="time-label">
                        <span class="bg-danger">
                          10 Feb. 2014
                        </span>
                      </div>
                      <!-- /.timeline-label -->
                      <!-- timeline item -->
                      <div>
                        <i class="fas fa-envelope bg-primary"></i>

                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 12:05</span>

                          <h3 class="timeline-header"><a href="#">Support Team</a> sent you an email</h3>

                          <div class="timeline-body">
                            Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles,
                            weebly ning heekya handango imeem plugg dopplr jibjab, movity
                            jajah plickers sifteo edmodo ifttt zimbra. Babblely odeo kaboodle
                            quora plaxo ideeli hulu weebly balihoo...
                          </div>
                          <div class="timeline-footer">
                            <a href="#" class="btn btn-primary btn-sm">Read more</a>
                            <a href="#" class="btn btn-danger btn-sm">Delete</a>
                          </div>
                        </div>
                      </div>
                      <!-- END timeline item -->
                      <!-- timeline item -->
                      <div>
                        <i class="fas fa-user bg-info"></i>

                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 5 mins ago</span>

                          <h3 class="timeline-header border-0"><a href="#">Sarah Young</a> accepted your friend request
                          </h3>
                        </div>
                      </div>
                      <!-- END timeline item -->
                      <!-- timeline item -->
                      <div>
                        <i class="fas fa-comments bg-warning"></i>

                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 27 mins ago</span>

                          <h3 class="timeline-header"><a href="#">Jay White</a> commented on your post</h3>

                          <div class="timeline-body">
                            Take me to your leader!
                            Switzerland is small and neutral!
                            We are more like Germany, ambitious and misunderstood!
                          </div>
                          <div class="timeline-footer">
                            <a href="#" class="btn btn-warning btn-flat btn-sm">View comment</a>
                          </div>
                        </div>
                      </div>
                      <!-- END timeline item -->
                      <div>
                        <i class="far fa-clock bg-gray"></i>
                      </div>
                    </div>
                  </div>
                  <!-- /.tab-pane -->

                  <div class="tab-pane" id="settings">
                    <form class="form-horizontal" method="post" id="infoForm">
                  		<div class="form-group row">
	                        <label for="inputLastname" class="col-sm-3 col-form-label">Last Name</label>
	                        <div class="col-sm-9">
	                          <input type="text" class="form-control" name="lastname" id="lastname" placeholder="Last Name" value="${ profile_user.lastname }">
	                        </div>
                     	</div>
	                    <div class="form-group row">
	                      <label for="inputFirstname" class="col-sm-3 col-form-label">First Name</label>
	                      <div class="col-sm-9">
	                        <input type="text" class="form-control" name="firstname" id="firstname" placeholder="First Name" value="${ profile_user.firstname }">
	                      </div>
	                    </div>
	                    <div class="form-group row">
	                      <label for="inputEmail" class="col-sm-3 col-form-label">Email</label>
	                      <div class="col-sm-9">
	                        <input type="text" disabled class="form-control" name="email" id="email" placeholder="Email" value="${ profile_user.email }">
	                      </div>
	                    </div>
	                    <div class="form-group row">
	                      <div class="offset-sm-3 col-sm-9">
	                        <button type="button" name="infoUpdate" id="infoUpdate" class="btn btn-danger">Update</button>
	                      </div>
	                    </div>
                    </form>
                    <form class="form-horizontal" method="post" id="passwordForm">                    
	                    <div class="form-group row">
	                      <label for="inputPassword" class="col-sm-3 col-form-label">Old Password</label>
	                      <div class="col-sm-9">
	                        <input type="password" class="form-control" name="oldpassword" id="oldpassword" placeholder="Old Password">
	                      </div>
	                    </div>
	                    <div class="form-group row">
	                      <label for="inputPassword" class="col-sm-3 col-form-label">New Password</label>
	                      <div class="col-sm-9">
	                        <input type="password" class="form-control" name="password" id="password" placeholder="New Password">
	                      </div>
	                    </div>
	                    <div class="form-group row">
	                      <label for="inputPassword" class="col-sm-3 col-form-label">Repeat New Password</label>
	                      <div class="col-sm-9">
	                        <input type="password" class="form-control" name="repassword" id="repassword" placeholder="Repeat New Password">
	                      </div>
	                    </div>
	                    <div class="form-group row">
	                      <div class="offset-sm-3 col-sm-9">
	                        <button type="button" name="passwordUpdate" id="passwordUpdate" class="btn btn-danger">Update Password</button>
	                      </div>
	                    </div>
                    </form>
                  </div>
                  <!-- /.tab-pane -->
                </div>
                <!-- /.tab-content -->
              </div><!-- /.card-body -->
            </div>
            <!-- /.nav-tabs-custom -->
          </div>
          <!-- /.col -->
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

<!-- Profile Script -->
<script src="js/profile.js"></script>

</body>
</html>
