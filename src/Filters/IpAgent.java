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
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class IpAgent
 */
@WebFilter("/*")
public class IpAgent implements Filter {
	/**
	 * Store Ip and User-Agent of client in session
	 */
	
    /**
     * Default constructor. 
     */
    public IpAgent() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession httpSession = httpRequest.getSession();

		String contextPath = request.getServletContext().getContextPath();
		// The current IP of the user, may be the same or different.
		String newIp = httpRequest.getRemoteAddr();
		// The current User-Agent of the user, may be the same or different.
		String newUserAgent = httpRequest.getHeader("user-agent");
		// The IP address as we may have already stored.
		String oldIp = (String) httpSession.getAttribute("userIp");
		// The User-Agent as we may have already stored.
		String oldUserAgent = (String) httpSession.getAttribute("userAgent");

		try {
			if (oldIp==null || (!newIp.equals(oldIp))) {
				httpSession.setAttribute("userIp", newIp);
			}
			if (oldUserAgent==null || (!newUserAgent.equals(oldUserAgent))) {
				httpSession.setAttribute("userAgent", newUserAgent);
			}
			// pass the request along the filter chain
			chain.doFilter(request, response);
		} catch(IllegalStateException e) {
			httpResponse.sendRedirect(contextPath + "/login");
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
