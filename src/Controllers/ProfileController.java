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
 * Servlet implementation class ProfileController
 */
@WebServlet("/profile")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String profile_name = request.getParameter("user");
		User profile_user = null;
		try {
			 profile_user = User.whereUsername(profile_name);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("profile_user", profile_user);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String current_username = (String) request.getSession().getAttribute("current_username");

		if(request.getParameter("password")==null) {
			//Update personal information
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			try {
				User user = User.whereUsername(current_username);
				user.setFirstname(firstname);
				user.setLastname(lastname);
				if(user.update()) {
					request.getSession().setAttribute("succMsg", "Success!");
					request.getSession().setAttribute("current_user", user);
				} else {
					request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");
				}				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				request.getSession().setAttribute("errMsg", e.toString());
			}
			
		} else {
			//Update password
			String oldpassword = request.getParameter("oldpassword");
			String password = request.getParameter("password");
			
			try {
				User user = new User(current_username, oldpassword);
				user.encryptPassword();
				if(user.login()) {
					user.setPassword(password);
					user.encryptPassword();
					if(user.update()) {
						request.getSession().setAttribute("succMsg", "Success!");
						request.getSession().removeAttribute("current_username");
						request.getSession().removeAttribute("current_user");
						response.sendRedirect(request.getContextPath()+"/login");
						return;
					} else {
						request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");
					}
				} else {
					request.getSession().setAttribute("errMsg", "Current password is not correct!");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				request.getSession().setAttribute("errMsg", e.toString());
			}

		}
		
		doGet(request,response);
	}

}
