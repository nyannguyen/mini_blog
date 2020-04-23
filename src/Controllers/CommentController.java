package Controllers;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Comment;
import Models.User;

import com.google.gson.*;

/**
 * Servlet implementation class CommentController
 */
@WebServlet("/comment")
public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentController() {
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
		int pid = Integer.parseInt(request.getParameter("pid"));
		String content = (String)request.getParameter("comment");
		String current_username = (String)request.getSession().getAttribute("current_username");
				
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    						
	    Gson gson = new Gson();
	    
		try {
			Comment comment = new Comment(User.whereUsername(current_username).getId(),pid,content);
			if(comment.create()) {
				response.getWriter().write(gson.toJson(comment));
			} 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
		}
	}

}
