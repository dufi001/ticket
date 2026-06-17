/*
 * Student 1: Islael Dufi | Class: A/B/C
 */
package com.tickets.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReadTicketsServlet
 */
@WebServlet("/ReadTickets")
public class ReadTicketsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // SECURE APPLIED: Clear browser cache right at the backend controller level
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies
        
        List<Map<String, String>> tableRows = new ArrayList<>();
        
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT t.*, u.full_name FROM tickets t JOIN users u ON t.user_id = u.user_id";
            
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
                while (rs.next()) {
                    Map<String, String> row = new HashMap<>();
                    row.put("ticket_id", rs.getString("ticket_id"));
                    row.put("customer", rs.getString("full_name"));
                    row.put("ticket_type", rs.getString("ticket_type"));
                    row.put("seat_number", rs.getString("seat_number"));
                    row.put("final_price", String.valueOf(rs.getDouble("final_price")));
                    row.put("snack", rs.getString("snack") != null ? rs.getString("snack") : "None");
                    tableRows.add(row);
                }
            }
            
            request.setAttribute("registeredTickets", tableRows);
            request.getRequestDispatcher("viewTickets.jsp").forward(request, response);
            
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}