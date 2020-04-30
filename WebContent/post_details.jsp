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
          <div class="col-12 posts">
          <%
               		if(post!=null){
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
			                  <a href="<%= request.getContextPath() %>/details?pid=<%= post.getId() %>" class="description"><%= post_date %></a>
			                </div>
			                <!-- /.user-block -->
			                <div class="card-tools">
			                <% if(post.getUid()==current_user.getId()){ %>
			                								<a href="<%= request.getContextPath() %>/delete?pid=<%= post.getId() %>" type="button" class="btn btn-tool"><i class="fas fa-trash-alt"></i>
			                  </a>
			                
			                  <a href="<%= request.getContextPath() %>/edit?pid=<%= post.getId() %>" type="button" class="btn btn-tool"><i class="fas fa-edit"></i>
			                  </a>
			                  <% } %>
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
               	<% 		
				} %>
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
