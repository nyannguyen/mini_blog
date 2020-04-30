package Controllers;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Post;
import Models.User;

/**
 * Servlet implementation class PostDeleteController
 */
@WebServlet("/delete")
public class PostDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int pid = Integer.parseInt(request.getParameter("pid"));
		Post p = null;
		String current_username = (String)request.getSession().getAttribute("current_username");

		try {
			User current_user = User.whereUsername(current_username);
			 p = Post.whereId(pid);
			 if(p.getUid()==current_user.getId()) {
					if(p.delete()) {
						response.sendRedirect("index");
					} else {
						request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");

						response.sendRedirect("index");
					}
			 } else {
				request.getSession().setAttribute("errMsg", "You don't have permission to edit this post!");
				 response.sendRedirect("index");
			 }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
