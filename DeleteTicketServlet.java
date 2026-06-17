package com.tickets.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteTicketServlet
 */
@WebServlet("/DeleteTicket")
public class DeleteTicketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("targetId", request.getParameter("id"));
        request.getRequestDispatcher("deleteTicket.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Inside your DeleteTicketServlet.java doPost method:
    	String ticketId = request.getParameter("ticketId");
    	try (Connection conn = DBUtils.getConnection()) {
    	    String sql = "DELETE FROM tickets WHERE ticket_id = ?";
    	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
    	        stmt.setString(1, ticketId);
    	        stmt.executeUpdate();
    	    }
    	    response.sendRedirect("ReadTickets");
    	}
        catch (Exception e) {
            throw new ServletException(e);
        }
    }
}