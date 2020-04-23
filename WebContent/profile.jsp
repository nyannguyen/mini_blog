<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="Models.User"
	import="Models.Log"
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
	User profile_user = (User)request.getAttribute("profile_user");
	int relationState = current_user.relationState(profile_user);
	ArrayList<Log> activities = Log.whereUid(current_user.getId());
	
	request.setAttribute("current_user", current_user);
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
	                	<a href="<%= request.getContextPath() %>/relation?action=addFriend&user=${ profile_user.username }" class="btn btn-primary btn-block"><b>Add friend</b></a>
	                <% } %>
	                <!-- Show pending button if they are waiting other to accept the invitation -->
	                <% if (relationState == 0){ %>
	                	<a href="<%= request.getContextPath() %>/relation?action=removeFriend&user=${ profile_user.username }" class="btn btn-warning btn-block"><b>Invitation sending...</b></a>
	                <% } %>
	                <% if (relationState == 1){ %>
	                	<a href="<%= request.getContextPath() %>/relation?action=acceptRequest&user=${ profile_user.username }" class="btn btn-success btn-block"><b>Accept Friend Request</b></a>
						<a href="<%= request.getContextPath() %>/relation?action=removeFriend&user=${ profile_user.username }" class="btn btn-danger btn-block"><b>Remove Friend Request</b></a>
	                <% } %>
      	            <!-- Show friend button if they have already connected -->
	                <% if (relationState == 2){ %>
	                	<a href="<%= request.getContextPath() %>/relation?action=removeFriend&user=${ profile_user.username }" class="btn btn-default btn-block"><b>Friend</b></a>
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
			<% if (current_user.equals(profile_user) || relationState == 2){ %>
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
             	  <% if (!current_user.equals(profile_user) && relationState != 2){ %>
				  <div style="text-align:center;">
                  	<span>Empty</span>
                  </div>
                  <% } %>
				  <% if (current_user.equals(profile_user) || relationState == 2){ %>
                  <div class="active tab-pane" id="timeline">
                  	<%
                  		ArrayList<Post> user_posts = profile_user.getPosts();
                  		if(user_posts.size()>0) {
                  			for(Post post: user_posts) {
                  				HashMap<Integer,Like> likes = post.getLikes();
                          		String post_date = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(post.getCreated_at());
                          		ArrayList<Comment> comments = post.getComments();
                  	%>
	                  	<div class="row">
	                  		<div class="col-12">
					          	<div class="card card-widget">
					              <div class="card-header">
					                <div class="user-block">
					                  <img class="img-circle" src="img/avatar5.png" alt="User Image">
					                  <span class="username"><a href="<%= request.getContextPath() %>/profile?user=<%= profile_user.getUsername() %>">${ profile_user.lastname } ${ profile_user.firstname }</a></span>
					                  <span class="description"><%= post_date %></span>
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
					                <%= post.getDescription() %>
					
					                <!-- Social sharing buttons -->
					                <% if(likes.containsKey(current_user.getId())) { %>
					                <button type="button" class="btn btn-primary btn-sm btn-unlike-<%= post.getId() %>" onclick="return onLikeClick(<%= post.getId() %>,0)"><i class="far fa-thumbs-up"></i> Like</button>
									<button type="button" class="d-none btn btn-default btn-sm btn-like-<%= post.getId() %>" onclick="onLikeClick(<%= post.getId() %>,1)"><i class="far fa-thumbs-up"></i> Like</button>
					                <% } else { %>
					                <button type="button" class="d-none btn btn-primary btn-sm btn-unlike-<%= post.getId() %>" onclick="return onLikeClick(<%= post.getId() %>,0)"><i class="far fa-thumbs-up"></i> Like</button>
									<button type="button" class="btn btn-default btn-sm btn-like-<%= post.getId() %>" onclick="onLikeClick(<%= post.getId() %>,1)"><i class="far fa-thumbs-up"></i> Like</button>
					                <% } %>
					                <span class="float-right text-muted">&nbsp;comments </span>
  					                <span class="float-right text-muted comment-count-<%= post.getId() %>"><%= comments.size() %></span>
  					                <span class="float-right text-muted">&nbsp;likes&nbsp;-&nbsp;</span>
									<span class="float-right text-muted like-count-<%= post.getId() %>"><%= likes.size() %></span>
					              </div>
					              <!-- /.card-body -->
					              <div class="card-footer card-comments comments-<%= post.getId() %>">
					              	<% for(Comment comment: comments) { 
		                          		String comment_date = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(comment.getCreated_at());
					              	%>
					                <div class="card-comment">
					                  <!-- User image -->
					                  <img class="img-circle img-sm" src="img/avatar5.png" alt="User Image">
					
					                  <div class="comment-text">
					                    <span class="username">
					                      <%= User.whereId(comment.getUid()).getFullName() %>
					                      <span class="text-muted float-right"><%= comment_date %></span>
					                    </span><!-- /.username -->
					                    <%= comment.getComment() %>
					                  </div>
					                  <!-- /.comment-text -->
					                </div>
					                <!-- /.card-comment -->
					                <% } %>
					              </div>
					              <!-- /.card-footer -->
					              <div class="card-footer">
					                  <img class="img-fluid img-circle img-sm" src="img/avatar5.png" alt="Alt Text">
					                  <!-- .img-push is used to add margin to elements next to floating images -->
					                  <div class="img-push">
					                    <input type="text" onkeypress="return addComment(event, this, <%= post.getId() %>)" class="form-control form-control-sm" placeholder="Press enter to post comment">
					                  </div>
					              </div>
					              <!-- /.card-footer -->
					            </div>
					          </div>
	                  	</div>
                  	<% 		}
                  		} else { 
                  	%>
	                  	<div style="text-align:center;">
	                  		<span>Empty</span>
	                  	</div>
                  	<% 	} %>
                  </div>
                  <!-- /.tab-pane -->
                  <% } %>
                  <% if (current_user.equals(profile_user)){ %>
                  <div class="tab-pane" id="activity">
                    <!-- The timeline -->
                    <div class="timeline timeline-inverse">
                      <%
                      	String pre_date = "";
                      	for(Log log:activities) {
                      		String log_date = new SimpleDateFormat("dd/MM/yyyy").format(log.getCreated_at());
                      		if(!log_date.equals(pre_date)) {
                      %>
		                      <!-- timeline time label -->
		                      <div class="time-label">
		                        <span class="bg-danger">
		                          <%= log_date %>
		                        </span>
		                      </div>
		                      <% pre_date = log_date; %>
		                      <!-- /.timeline-label -->
                      		<% } %>
                      
                      <!-- timeline item -->
                      <div>
                        <i class="far fa-sticky-note bg-primary"></i>

                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> <%= new SimpleDateFormat("HH:mm").format(log.getCreated_at()) %></span>

                          <div class="timeline-body">
                            <%= log.getDescription() %>
                          </div>
                        </div>
                      </div>
                      <!-- END timeline item -->
                      <% } %>
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
                  <% } %>
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

<script>
function addComment(event, input,  pid) {
	if(event.keyCode == 13) {
		console.log(pid, $(input).val());
		comment = $(input).val();


		$.post("comment",{ pid: pid, comment: comment}, function(responseComment){
			if(responseComment==""){
				toastr.error('Some error occured! Please try again later!');
			} else {
				var c = JSON.parse(JSON.stringify(responseComment));
				var date = new Date(c.created_at);
				$(".comments-"+pid).append(`
					<div class="card-comment">
						<!-- User image -->
						<img class="img-circle img-sm" src="img/avatar5.png" alt="User Image">

						<div class="comment-text">
						<span class="username">
							<%= current_user.getFullName() %>
							<span class="text-muted float-right">`+getDateTimeFormat(date)+`</span>
						</span><!-- /.username -->
						`+c.comment+`
						</div>
						<!-- /.comment-text -->
					</div>
				`);
				
				$(".comment-count-"+pid).text(parseInt($(".comment-count-"+pid).text())+1);
			}
		});

		$(input).val("");
	}
}
</script>

<script>
function onLikeClick(pid, type) {
	if(type==0){ //Unlike
		$(".btn-like-"+pid).removeClass("d-none");
		$(".btn-unlike-"+pid).addClass("d-none");
		
		$(".like-count-"+pid).text(parseInt($(".like-count-"+pid).text())-1);
	} else {
		$(".btn-unlike-"+pid).removeClass("d-none");
		$(".btn-like-"+pid).addClass("d-none");
		
		$(".like-count-"+pid).text(parseInt($(".like-count-"+pid).text())+1);
	}
	$.post("like",{ pid: pid, type: type});
}
</script>
</body>
</html>
