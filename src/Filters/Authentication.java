package Filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class Authentication
 */
@WebFilter(urlPatterns = {"/index/*","/profile/*","/comment/*","/post/*","/like/*","/details/*","/relation/*","/requests/*","/search/*","/edit/*","/delete/*"})
public class Authentication implements Filter {

    /**
     * Default constructor. 
     */
    public Authentication() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * Get current user from current session
	 * Continue request if client has already logged in 
	 * Go to login page if not
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		// pass the request along the filter chain
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		
		// Get current user from session
		String current_username = (String) httpRequest.getSession().getAttribute("current_username");
		if(current_username == null) {
			httpResponse.sendRedirect(httpRequest.getContextPath()+"/login");
		} else {
			chain.doFilter(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
