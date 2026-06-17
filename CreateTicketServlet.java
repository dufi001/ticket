/*
 * Student 1: RegNo_FullName1 | Class: A/B/C
 * Student 2: RegNo_FullName2 | Class: A/B/C
 */
package com.tickets.servlets;

import com.tickets.tickettypes.StandardTicket;
import com.tickets.tickettypes.Ticket;
import com.tickets.tickettypes.VIPTicket;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// FIXED: URL mapping matched to exactly what your form action demands ("CreateTicket")
@WebServlet("/CreateTicket")
public class CreateTicketServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // SAFE GET FALLBACK: Prevents the 405 Method Not Supported Error
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("addTicket.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String ticketType = request.getParameter("ticketType");
            String seatNumber = request.getParameter("seatNumber");
            double basePrice = Double.parseDouble(request.getParameter("basePrice"));
            
            // Invoke your clean IdGenerator
            String generatedId = IdGenerator.newId();
            Ticket ticketInstance;

            if ("VIP".equalsIgnoreCase(ticketType)) {
                double vipFee = Double.parseDouble(request.getParameter("vipFee"));
                String snack = request.getParameter("snack");
                ticketInstance = new VIPTicket(generatedId, userId, seatNumber, basePrice, vipFee, snack);
            } else {
                ticketInstance = new StandardTicket(generatedId, userId, seatNumber, basePrice);
            }

            try (Connection conn = DBUtils.getConnection()) {
                // Skips serial_id entirely so your MySQL table increments it independently without collisions
                String sql = "INSERT INTO tickets (ticket_id, user_id, ticket_type, seat_number, base_price, extra_fee, snack, final_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, ticketInstance.getTicketNumber());
                    stmt.setInt(2, ticketInstance.getUserId());
                    stmt.setString(3, ticketInstance.getTicketType());
                    stmt.setString(4, ticketInstance.getSeatNumber());
                    stmt.setDouble(5, ticketInstance.getBasePrice());
                    
                    if (ticketInstance instanceof VIPTicket) {
                        stmt.setDouble(6, ((VIPTicket) ticketInstance).getVipFee());
                        stmt.setString(7, ((VIPTicket) ticketInstance).getSnack());
                    } else {
                        stmt.setDouble(6, 0.00);
                        stmt.setNull(7, java.sql.Types.VARCHAR);
                    }
                    stmt.setDouble(8, ticketInstance.calculateFinalPrice());
                    stmt.executeUpdate();
                }
            }
            
            // FIXED: Cleanly routes to the ReadTickets servlet endpoint to fetch and reload the table records view
            response.sendRedirect("ReadTickets");
            
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}