<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tickets.servlets.DBUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unity Tickets - Process Booking</title>
    <style>
        /* Lightweight Professional Baseline */
        * { 
            box-sizing: border-box; 
            font-family: 'Segoe UI', Arial, sans-serif; 
            margin: 0;
            padding: 0;
        }
        
        body { 
            background-color: #f8fafc; /* Very light subtle gray background */
            color: #1e293b;
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .form-wrapper {
            width: 100%;
            max-width: 520px;
            background-color: #ffffff;
            padding: 35px;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        /* 🌟 Medium Accessible Header */
        h2 { 
            color: #0f172a; 
            margin-bottom: 25px;
            font-size: 26px;
            font-weight: 700;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 12px;
        }
        
        .form-group { 
            margin-bottom: 22px; 
            width: 100%; 
        }
        
        /* 🌟 Medium Accessible Labels */
        .form-group label { 
            display: block; 
            margin-bottom: 8px; 
            font-weight: 600; 
            color: #334155; 
            font-size: 16px;
        }
        
        /* High-contrast, clean input design without being visually heavy */
        .form-group input, .form-group select { 
            width: 100%; 
            padding: 12px 14px; 
            border: 1px solid #cbd5e0; 
            border-radius: 6px; 
            font-size: 16px; 
            color: #0f172a;
            background-color: #ffffff;
            transition: border-color 0.15s ease;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #4A90E2;
        }

        /* VIP Light Highlight Container Box */
        #vipSection {
            background-color: #fffbeb; /* Soft light amber background tint */
            border: 1px solid #fde68a; 
            border-left: 4px solid #d97706; 
            padding: 20px; 
            margin: 25px 0; 
            border-radius: 6px;
        }

        #vipSection h4 {
            color: #b45309;
            font-size: 16px;
            margin-bottom: 15px;
            font-weight: 700;
        }
        
        /* Simplified Action Row Controls */
        .actions-tray {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-top: 30px;
        }

        .btn-submit { 
            padding: 14px 24px; 
            background-color: #4A90E2; 
            color: white; 
            border: none; 
            border-radius: 6px; 
            font-weight: 600; 
            cursor: pointer; 
            font-size: 16px; 
            transition: background-color 0.15s ease; 
        }
        
        .btn-submit:hover { 
            background-color: #2563eb; 
        }

        .btn-cancel {
            font-size: 16px;
            color: #64748b;
            text-decoration: none;
            font-weight: 600;
            padding: 10px 5px;
        }

        .btn-cancel:hover {
            color: #0f172a;
            text-decoration: underline;
        }

        /* Elegant and light system footer alignment */
        .system-footer {
            text-align: center;
            color: #94a3b8; 
            font-size: 13px;
            margin-top: 40px;
        }
    </style>
    <script>
        function toggleVipFields() {
            var type = document.getElementById("ticketType").value;
            var vipSection = document.getElementById("vipSection");
            vipSection.style.display = (type === "VIP") ? "block" : "none";
        }
    </script>
</head>
<body onload="toggleVipFields()">

    <%@ include file="ownershipBanner.jsp" %>

    <div class="form-wrapper">
        <h2>Purchase Ticket Workflow</h2>
        
        <form action="<%= request.getContextPath() %>/CreateTicket" method="post">
            
            <div class="form-group">
                <label for="userId">Customer Profile:</label>
                <select name="userId" id="userId" required>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            conn = DBUtils.getConnection();
                            // Matches your exact MySQL table column variables: user_id and full_name
                            String query = "SELECT user_id, full_name FROM users"; 
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(query);
                            
                            while(rs.next()) {
                                int id = rs.getInt("user_id");
                                String name = rs.getString("full_name");
                    %>
                                <option value="<%= id %>"><%= name %></option>
                    <%
                            }
                        } catch(Exception e) {
                    %>
                            <option value="1">Nina (Fallback User)</option>
                            <option value="2">Lucas (Fallback User)</option>
                    <%
                        } finally {
                            if(rs != null) try { rs.close(); } catch(Exception e) {}
                            if(stmt != null) try { stmt.close(); } catch(Exception e) {}
                            if(conn != null) try { conn.close(); } catch(Exception e) {}
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label for="ticketType">Ticket Tier Classification:</label>
                <select name="ticketType" id="ticketType" onchange="toggleVipFields()">
                    <option value="Standard">Standard Ticket Tier</option>
                    <option value="VIP">VIP Priority Ticket Tier</option>
                </select>
            </div>

            <div class="form-group">
                <label for="seatNumber">Seat Allocation Mapping:</label>
                <input type="text" id="seatNumber" name="seatNumber" required placeholder="e.g. A1, B2">
            </div>

            <div class="form-group">
                <label for="basePrice">Base Token Value Pricing ($):</label>
                <input type="number" id="basePrice" name="basePrice" step="0.01" value="10.00" required>
            </div>
            
            <div id="vipSection">
                <h4>VIP Supplemental Specifications</h4>
                <div class="form-group" style="margin-bottom: 15px;">
                    <label for="vipFee">Access Surcharge Suffix ($):</label>
                    <input type="number" id="vipFee" name="vipFee" step="0.01" value="5.00">
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <label for="snack">Included Refreshment Package:</label>
                    <input type="text" id="snack" name="snack" value="Popcorn">
                </div>
            </div>
            
            <div class="actions-tray">
                <button type="submit" class="btn-submit">Authorize Ledger Booking</button>
                <a href="<%= request.getContextPath() %>/dashboard.jsp" class="btn-cancel">Abort Operation</a>
            </div>
        </form>
    </div>

    <footer class="system-footer">
        Unity Tickets Core System Framework Engine • Powered by Islael Dufitimana • 2026
    </footer>

</body>
</html>