package Controllers;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.User;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String current_username = (String) request.getSession().getAttribute("current_username");
		if(current_username != null) {
			// Redirect to index page if user has logged in
			response.sendRedirect(request.getContextPath()+"/index");
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		User user = new User(username, password);
		user.encryptPassword();
		
		try {
			if(user.login()) {
				request.getSession().setAttribute("current_username", username);
				
				response.sendRedirect("index");
			} else {
				request.getSession().setAttribute("errMsg", "Login failed! Please check your username and password!");
				response.sendRedirect("login");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			request.getSession().setAttribute("errMsg", e.toString());
			response.sendRedirect("login");
		}
	}

}
