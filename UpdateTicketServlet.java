package com.tickets.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateTicketServlet
 */
@WebServlet("/UpdateTicket")
public class UpdateTicketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
        try (Connection conn = DBUtils.getConnection()) {
            String sql = "SELECT * FROM tickets WHERE ticket_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, id);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        Map<String, String> target = new HashMap<>();
                        target.put("ticket_id", rs.getString("ticket_id"));
                        target.put("seat_number", rs.getString("seat_number"));
                        target.put("base_price", String.valueOf(rs.getDouble("base_price")));
                        target.put("ticket_type", rs.getString("ticket_type"));
                        target.put("extra_fee", String.valueOf(rs.getDouble("extra_fee")));
                        target.put("snack", rs.getString("snack"));
                        request.setAttribute("ticket", target);
                    }
                }
            }
            request.getRequestDispatcher("updateTicket.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String ticketId = request.getParameter("ticketId");
            String seatNumber = request.getParameter("seatNumber");
            double basePrice = Double.parseDouble(request.getParameter("basePrice"));
            String ticketType = request.getParameter("ticketType");
            
            double finalPrice = basePrice;
            double extraFee = 0.0;
            String snack = null;

            if ("VIP".equalsIgnoreCase(ticketType)) {
                extraFee = Double.parseDouble(request.getParameter("extraFee"));
                snack = request.getParameter("snack");
                finalPrice = basePrice + extraFee;
            }

            try (Connection conn = DBUtils.getConnection()) {
                String sql = "UPDATE tickets SET seat_number=?, base_price=?, extra_fee=?, snack=?, final_price=? WHERE ticket_id=?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, seatNumber);
                    stmt.setDouble(2, basePrice);
                    stmt.setDouble(3, extraFee);
                    stmt.setString(4, snack);
                    stmt.setDouble(5, finalPrice);
                    stmt.setString(6, ticketId);
                    stmt.executeUpdate();
                }
            }
            response.sendRedirect("ReadTickets");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}