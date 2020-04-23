package Controllers;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Relation;
import Models.User;

/**
 * Servlet implementation class RelationController
 */
@WebServlet("/relation")
public class RelationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RelationController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		String friend_username = request.getParameter("user");
		String current_username = (String) request.getSession().getAttribute("current_username");
		
		User current_user;
		try {
			current_user = User.whereUsername(current_username);
			User friend_user = User.whereUsername(friend_username);
			switch(action) {
				case "addFriend":
					if(current_username!=friend_username && current_user.relationState(friend_user)==-1) {
						Relation relation = new Relation(current_user.getId(),friend_user.getId(),false);
						if(relation.create()) {
							request.getSession().setAttribute("succMsg", "Success!");
						} else {
							request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");
						}
					} else {
						request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");
					}
					break;
				case "acceptRequest":
					if(current_username!=friend_username && current_user.relationState(friend_user)==1) {
						if(current_user.acceptFriendRequest(friend_user.getId())) {
							request.getSession().setAttribute("succMsg", "Success!");
						} else {
							request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");
						}
					} else {
						request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");
					}
					break;
				case "removeFriend":
					int currentState = current_user.relationState(friend_user);
					if(current_username!=friend_username && (currentState==0 || currentState==2)) {
						if(current_user.removeFriend(friend_user.getId())) {
							request.getSession().setAttribute("succMsg", "Success!");
						} else {
							request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");
						}
					} else {
						request.getSession().setAttribute("errMsg", "Some error occured! Please try again later!");
					}
					break;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			request.getSession().setAttribute("errMsg", e.toString());
		}
		response.sendRedirect(request.getContextPath()+"/profile?user="+friend_username);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
