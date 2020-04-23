package Controllers;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Models.Post;
import Models.User;

/**
 * Servlet implementation class PostController
 */
@WebServlet("/post")
public class PostController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String post_description = request.getParameter("post_description");
		String current_username = (String) request.getSession().getAttribute("current_username");
		
	    Gson gson = new Gson();
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		
		if(!post_description.isBlank() && !post_description.isEmpty()) {
			try {
				Post post = new Post(User.whereUsername(current_username).getId(),post_description);
				if(post.create()) {
					response.getWriter().write(gson.toJson(post));
				} 
			} catch (SQLException e) {
				// TODO Auto-generated catch block
			}	
		}
	}

}
