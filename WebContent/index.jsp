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
					  <textarea name="post_description" id="txt_newPost" class="textarea" placeholder="Place some text here"
					            style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
					</div>
					<button type="button" onclick="addPost()" class="btn btn-block btn-primary">Post</button>
				</div>
			</div>
          </div>
          
          <div class="col-12 posts">
          <%
               		ArrayList<Post> posts = current_user.getFeeds();
               		if(posts.size()>0) {
               			for(Post post: posts) {
               				HashMap<Integer,Like> likes = post.getLikes();
                       		String post_date = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(post.getCreated_at());
                       		ArrayList<Comment> comments = post.getComments();
                       		User post_user = User.whereId(post.getUid());
               	%>
               	<div class="row">
               		<div class="col-12">
			          	<div class="card card-widget">
			              <div class="card-header">
			                <div class="user-block">
			                  <img class="img-circle" src="img/avatar5.png" alt="User Image">
			                  <span class="username"><a href="<%= request.getContextPath() %>/profile?user=<%= post_user.getUsername() %>"><%= post_user.getFullName() %></a></span>
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
function addPost() {
	post = $("#txt_newPost").val();

	$.post("post",{ post_description: post }, function(responseComment){
		if(responseComment==""){
			toastr.error('Some error occured! Please try again later!');
		} else {
			var p = JSON.parse(JSON.stringify(responseComment));
			var date = new Date(p.created_at);
			$(".posts").prepend(`
					<div class="card card-widget">
		              <div class="card-header">
		                <div class="user-block">
		                  <img class="img-circle" src="img/avatar5.png" alt="User Image">
		                  <span class="username"><a href="#"><%= current_user.getFullName() %></a></span>
		                  <span class="description">`+getDateTimeFormat(date)+`</span>
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
		                `+p.description+`

		                <!-- Social sharing buttons -->
		                <button type="button" class="d-none btn btn-primary btn-sm btn-unlike-`+p.id+`" onclick="return onLikeClick(`+p.id+`,0)"><i class="far fa-thumbs-up"></i> Like</button>
						<button type="button" class="btn btn-default btn-sm btn-like-`+p.id+` %>" onclick="onLikeClick(`+p.id+`,1)"><i class="far fa-thumbs-up"></i> Like</button>
		                <span class="float-right text-muted">&nbsp;comments </span>
		                <span class="float-right text-muted comment-count-`+p.id+`">0</span>
		                <span class="float-right text-muted">&nbsp;likes&nbsp;-&nbsp;</span>
						<span class="float-right text-muted like-count-`+p.id+`">0</span>
		              </div>
		              <!-- /.card-body -->
		              <div class="card-footer card-comments comments-`+p.id+`">
		              </div>
		              <!-- /.card-footer -->
		              <div class="card-footer">
		                  <img class="img-fluid img-circle img-sm" src="img/avatar5.png" alt="Alt Text">
		                  <!-- .img-push is used to add margin to elements next to floating images -->
		                  <div class="img-push">
		                    <input type="text" onkeypress="return addComment(event, this, `+p.id+`)"  class="form-control form-control-sm" placeholder="Press enter to post comment">
		                  </div>
		              </div>
		              <!-- /.card-footer -->
		            </div>
			`);
			
		}
	});
	
	$("#txt_newPost").val("");
	$("#txt_newPost").summernote("reset");
}
</script>
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
