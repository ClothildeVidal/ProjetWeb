package Filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProtectedPagesFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {
		try {
			HttpSession session = ((HttpServletRequest) request).getSession(false);
			if (session != null && session.getAttribute("userName") != null) {
				// connecté, on traite la requête			
				chain.doFilter(request, response);
			} else {
				// Pas connecté, on va vers la page de login (racine)
				((HttpServletResponse) response).sendRedirect(((HttpServletRequest) request).getContextPath() + "/");
			}
		} catch (IOException | ServletException t) {
		}

	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void destroy() {
	}
}
