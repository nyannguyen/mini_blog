<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Toastr -->
<script src="plugins/toastr/toastr.min.js"></script>
<!-- AdminLTE App -->
<script src="js/adminlte.min.js"></script>

<script>
$(document).ready(function() {
<%
String succMsg = (String)request.getSession().getAttribute("succMsg");
String errMsg = (String)request.getSession().getAttribute("errMsg");
%>
<% if(errMsg!=null) { %>
	toastr.error("<%= errMsg %>");
<% } %>
<% if(succMsg!=null) { %>
	toastr.success("<%= succMsg %>");
<% } 
request.getSession().removeAttribute("errMsg");
request.getSession().removeAttribute("succMsg");
%>
});
</script>

<script>
function getDateTimeFormat(dt){
	var date = (dt.getDate() < 10 ? '0' : '') + dt.getDate();
	var month = (dt.getMonth() < 9 ? '0' : '') + (dt.getMonth()+1);
	var year = dt.getFullYear();
	var hour = (dt.getHours() < 10 ? '0' : '') + dt.getHours();
	var minute = (dt.getMinutes() < 10 ? '0' : '') + dt.getMinutes();
	
	return date+"/"+month+"/"+year+" "+hour+":"+minute;
}
</script>