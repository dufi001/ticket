<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.tickets.servlets.DBUtils" %>
<!DOCTYPE html>
<html>
<head>
    <title>Buy Ticket</title>
    <script>
        function toggleVipFields() {
            var type = document.getElementById("ticketType").value;
            var vipSection = document.getElementById("vipSection");
            vipSection.style.display = (type === "VIP") ? "block" : "none";
        }
    </script>
</head>
<body style="font-family:sans-serif; margin:30px;" onload="toggleVipFields()">
    <%@ include file="ownershipBanner.jsp" %>
    <h2>Purchase Ticket Workflow</h2>
    <form action="CreateTicket" method="post">
        
        <p>Customer Profile:<br/>
            <select name="userId" style="width:200px;">
                <%
                    // Dynamically rendering users directly from your MySQL DB
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        conn = DBUtils.getConnection(); // Utilizing your existing connection method
                        String query = "SELECT id, name FROM users"; // Adjust table/column names if different
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(query);
                        
                        while(rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                %>
                            <option value="<%= id %>"><%= name %></option>
                <%
                        }
                    } catch(Exception e) {
                        // Fallback defaults if the database drops connection
                %>
                        <option value="1">Nina (Fallback User)</option>
                        <option value="2">Lucas (Fallback User)</option>
                <%
                    } finally {
                        if(rs != null) rs.close();
                        if(stmt != null) stmt.close();
                        if(conn != null) conn.close();
                    }
                %>
            </select>
        </p>

        <p>Ticket Tier Classification:<br/>
            <select name="ticketType" id="ticketType" onchange="toggleVipFields()" style="width:200px;">
                <option value="Standard">Standard Ticket Tier</option>
                <option value="VIP">VIP Priority Ticket Tier</option>
            </select>
        </p>
        <p>Seat Allocation Mapping:<br/><input type="text" name="seatNumber" required placeholder="e.g. A1, B2"/></p>
        <p>Base Token Value Pricing ($):<br/><input type="number" name="basePrice" step="0.01" value="10.00" required/></p>
        
        <div id="vipSection" style="border:1px dashed #777; padding:10px; margin:10px 0; max-width:300px;">
            <h4>VIP Supplemental Specifications</h4>
            <p>Access Surcharge Suffix ($):<br/><input type="number" name="vipFee" step="0.01" value="5.00"/></p>
            <p>Included Refreshment Package:<br/><input type="text" name="snack" value="Popcorn"/></p>
        </div>
        
        <input type="submit" value="Authorize Ledger Booking" style="padding:5px 15px;"/>
        <a href="index.jsp" style="margin-left:10px;">Abort Operation</a>
    </form>
</body>
</html>