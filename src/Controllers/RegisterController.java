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
 * Servlet implementation class RegisterController
 */
@WebServlet("/register")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		User user = new User(username, email, password, firstname, lastname);
		user.encryptPassword();
		try {
			if(User.whereUsername(username)!=null) {
				request.getSession().setAttribute("errMsg", "Username has been existed!");
				response.sendRedirect("register");
			} else {
				if(User.whereEmail(email)!=null) {
					request.getSession().setAttribute("errMsg", "Email has been existed!");
					response.sendRedirect("register?errMsg=emailExist");
				} else {
					user.create();
					request.getSession().setAttribute("succMsg", "Success! Please login to continue!");
					response.sendRedirect("login?succMsg=registerSucc");
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			request.getSession().setAttribute("errMsg", e.toString());
			response.sendRedirect("errMsg");
		}
	}

}
