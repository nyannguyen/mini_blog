package Listeners;

import java.sql.SQLException;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import Models.Log;
import Models.User;

/**
 * Application Lifecycle Listener implementation class LoginActivity
 *
 */
@WebListener
public class Account implements HttpSessionAttributeListener {

    /**
     * Default constructor. 
     */
    public Account() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * Log login activity when has a new login
     * @see HttpSessionAttributeListener#attributeAdded(HttpSessionBindingEvent)
     */
    public void attributeAdded(HttpSessionBindingEvent event)  { 
         // TODO Auto-generated method stub
    	String attributeName = event.getName();
    	HttpSession session = event.getSession();
    	if(attributeName == "current_username") {
    		if(event.getValue()!=null) {
	    		String userIp = (String) session.getAttribute("userIp");
	    		String userAgent = (String) session.getAttribute("userAgent");
	    		
	    		String description = "Login on device: "+userIp+" via "+userAgent;
	    		String current_username = (String)session.getAttribute("current_username");
	    		try {
		    		Log log = new Log(User.whereUsername(current_username).getId(),description);
					log.create();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
    		}
    	}
    }

	/**
     * @see HttpSessionAttributeListener#attributeRemoved(HttpSessionBindingEvent)
     */
    public void attributeRemoved(HttpSessionBindingEvent event)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see HttpSessionAttributeListener#attributeReplaced(HttpSessionBindingEvent)
     */
    public void attributeReplaced(HttpSessionBindingEvent event)  { 
         // TODO Auto-generated method stub
    	String attributeName = event.getName();
    	HttpSession session = event.getSession();
    	if(attributeName == "current_user") {
    		if(event.getValue()!=null) {
	    		String userIp = (String) session.getAttribute("userIp");
	    		String userAgent = (String) session.getAttribute("userAgent");
	    		
	    		String description = "Update user information on device: "+userIp+" via "+userAgent;
	    		String current_username = (String)session.getAttribute("current_username");
	    		try {
		    		Log log = new Log(User.whereUsername(current_username).getId(),description);
					log.create();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
    		}
    	}
    }
	
}
