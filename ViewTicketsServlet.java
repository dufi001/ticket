package com.tickets.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// This annotation maps the servlet path directly to what your frontend dashboards call
@WebServlet("/ViewTickets")
public class ViewTicketsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Session Verification Safety Guard
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 2. Data Structures initialization matrix
        List<Map<String, String>> ticketList = new ArrayList<>();

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            
            // JOIN query to match user IDs with their actual full customer names
            String sql = "SELECT t.ticket_id, u.full_name, t.ticket_type, t.seat_number, t.snack, t.final_price " +
                         "FROM tickets t " +
                         "JOIN users u ON t.user_id = u.user_id " +
                         "ORDER BY t.ticket_id DESC";
            
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            // 3. Loop through database rows and map them into our memory list
            while (rs.next()) {
                Map<String, String> ticket = new HashMap<>();
                ticket.put("ticket_id", String.valueOf(rs.getInt("ticket_id")));
                ticket.put("customer", rs.getString("full_name"));
                ticket.put("ticket_type", rs.getString("ticket_type"));
                ticket.put("seat_number", rs.getString("seat_number"));
                ticket.put("snack", rs.getString("snack"));
                ticket.put("final_price", String.format("%.2f", rs.getDouble("final_price")));
                
                ticketList.add(ticket);
            }

            // 4. Bind the data array onto the request scope context
            request.setAttribute("registeredTickets", ticketList);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database extraction breakdown: " + e.getMessage());
        } finally {
            // Clean up resources to prevent connection leaks
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }

        // 5. Forward everything cleanly to your gorgeous viewTickets.jsp layout page
        request.getRequestDispatcher("/viewTickets.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}