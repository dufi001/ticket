package com.tickets.servlets;

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
 * Global Session Interceptor Security Layer
 * Guards viewTickets.jsp, buyTicket.jsp, dashboard.jsp, and ReadTickets servlet
 */
@WebFilter(urlPatterns = { "/viewTickets.jsp", "/buyTicket.jsp", "/dashboard.jsp", "/ReadTickets" })
public class SessionGuardFilter implements Filter {

    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        // No custom lifecycle configuration needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // 1. Destroy all local web browser caches for these specific resources
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        httpResponse.setHeader("Pragma", "no-cache"); // HTTP 1.0
        httpResponse.setDateHeader("Expires", 0); // Proxies

        // 2. Validate current credential presence inside memory
        boolean loggedIn = (session != null && session.getAttribute("loggedUser") != null);

        if (loggedIn) {
            // User is authenticated! Continue execution safely down the chain pipeline
            chain.doFilter(request, response);
        } else {
            // User is logged out! Intercept navigation and send them back to the login gateway
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
        }
    }

    @Override
    public void destroy() {
        // Clean up allocation routines if required
    }
}