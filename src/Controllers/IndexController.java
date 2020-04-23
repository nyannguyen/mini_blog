package Controllers;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Post;
import Models.User;

/**
 * Servlet implementation class IndexController
 */
@WebServlet(urlPatterns = {"/index"})
public class IndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub	
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String post_description = request.getParameter("post_description");
		String current_username = (String) request.getSession().getAttribute("current_username");
		
		if(!post_description.isBlank() && !post_description.isEmpty()) {
			try {
				Post post = new Post(User.whereUsername(current_username).getId(),post_description);
				if(post.create()) {
					request.getSession().setAttribute("succMsg", "Published!");
				} else {
					request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				request.getSession().setAttribute("errMsg", e.toString());
			}
			
		} else {
			request.getSession().setAttribute("errMsg", "Post can not be empty!");
		}
		
		doGet(request, response);
	}

}
