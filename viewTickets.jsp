<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unity Tickets - System Audit Ledger</title>
    <style>
        /* Modern Lightweight Baseline Configuration Settings */
        * { 
            box-sizing: border-box; 
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif; 
            margin: 0;
            padding: 0;
        }
        
        body { 
            background-color: #f8fafc; /* Crisp, clean minimalist background tint */
            color: #0f172a; 
            padding: 40px 30px; 
        }

        /* Clean Medium Title Header Formatting */
        h2 { 
            color: #0f172a; 
            font-size: 26px; 
            font-weight: 700; 
            margin-top: 25px;
            margin-bottom: 20px;
            letter-spacing: -0.5px;
        }

        /* Professional Audit Report Layout Components Table Container */
        .table-container { 
            width: 100%; 
            overflow-x: auto; 
            background: #ffffff; 
            border-radius: 8px; 
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03); 
            border: 1px solid #e2e8f0; 
        }
        
        /* Accessible, structured medium data cells values */
        table { 
            width: 100%; 
            border-collapse: collapse; 
            text-align: left; 
            font-size: 16px; 
        }
        
        th, td { 
            padding: 16px 20px; /* Spacious cell margins to make report data easily scannable */
            border-bottom: 1px solid #e2e8f0; 
        }
        
        th { 
            background-color: #f1f5f9; /* Flat corporate reporting sub-header block panel colors */
            color: #334155; 
            font-weight: 700; 
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        /* Zebra striping rows logic */
        tr:nth-child(even) {
            background-color: #f8fafc;
        }
        
        tr:hover { 
            background-color: #f1f5f9; 
        }
        
        /* Classification badges structural visual definitions */
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 700;
        }
        
        .badge-std {
            background-color: #e0f2fe;
            color: #0369a1;
        }
        
        .badge-vip {
            background-color: #fef3c7;
            color: #b45309;
        }
        
        /* Action mutations execution link styling rules */
        .action-link { 
            text-decoration: none; 
            font-weight: 600;
            font-size: 15px;
        }
        
        .modify-btn { 
            color: #3b82f6; 
        }
        .modify-btn:hover {
            text-decoration: underline;
        }
        
        .drop-btn { 
            color: #ef4444; 
        }
        .drop-btn:hover {
            text-decoration: underline;
        }

        /* 🌟 Bottom Navigational Control Links Layout */
        .nav-links { 
            margin-top: 25px; 
            text-align: center;
            font-size: 16px; 
            font-weight: 600;
            padding: 10px 0;
        }
        
        .nav-links a { 
            color: #3b82f6; 
            text-decoration: none; 
            transition: color 0.15s ease;
            padding: 4px 8px;
        }
        
        .nav-links a:hover { 
            color: #1d4ed8;
            text-decoration: underline; 
        }
        
        .separator { 
            color: #cbd5e0; 
            font-weight: 400;
        }
        
        .logout-link { 
            color: #ef4444 !important; 
        }
        
        .logout-link:hover {
            color: #b91c1c !important;
        }
    </style>
</head>
<body>

    <%@ include file="ownershipBanner.jsp" %>

    <h2>Purchased System Tickets Database Record</h2>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Unique ID Code</th>
                    <th>Client Customer</th>
                    <th>Tier</th>
                    <th>Seat Location</th>
                    <th>Add-On Snack Included</th>
                    <th>Aggregated Price Paid</th>
                    <th>Administrative Mutations</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Map<String, String>> tickets = (List<Map<String, String>>) request.getAttribute("registeredTickets");
                    if (tickets != null && !tickets.isEmpty()) {
                        for (Map<String, String> ticket : tickets) {
                            String type = ticket.get("ticket_type");
                %>
                            <tr>
                                <td><strong>#<%= ticket.get("ticket_id") %></strong></td>
                                <td><%= ticket.get("customer") != null ? ticket.get("customer") : "Unassigned Account Record" %></td>
                                <td>
                                    <span class="badge <%= "VIP".equalsIgnoreCase(type) ? "badge-vip" : "badge-std" %>">
                                        <%= type %>
                                    </span>
                                </td>
                                <td><code style="font-family: monospace; font-size: 15px; font-weight: 700; color: #475569;"><%= ticket.get("seat_number") %></code></td>
                                <td><%= ticket.get("snack") %></td>
                                <td style="font-weight: 700; color: #16a34a;">$<%= ticket.get("final_price") %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/UpdateTicket?id=<%= ticket.get("ticket_id") %>" class="action-link modify-btn">Modify</a>
                                    <span style="color:#cbd5e0; margin: 0 4px;">|</span>
                                    <a href="<%= request.getContextPath() %>/DeleteTicket?id=<%= ticket.get("ticket_id") %>" class="action-link drop-btn" onclick="return confirm('Are you sure you want to completely delete record code #<%= ticket.get("ticket_id") %> from ledger directory?');">Drop</a>
                                </td>
                            </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="7" style="text-align: center; color: #64748b; padding: 35px; font-weight: 500;">No registered ledger records currently exist inside active data vectors.</td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/dashboard.jsp">Return Dashboard Hub</a>
        <span class="separator">|</span>
        <a href="<%= request.getContextPath() %>/buyTicket.jsp">Process Alternative Booking</a>
        <span class="separator">|</span>
        <a href="<%= request.getContextPath() %>/Logout" class="logout-link">Logout</a>
    </div>

</body>
</html>