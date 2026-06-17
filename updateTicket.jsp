<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head><title>Update Booking Object</title></head>
<body style="font-family:sans-serif; margin:30px;">
    <%@ include file="ownershipBanner.jsp" %>
    <h2>Modify Entity Structural Metadata</h2>
    <% Map<String, String> entity = (Map<String, String>) request.getAttribute("ticket"); %>
    
    <form action="UpdateTicket" method="post">
        <input type="hidden" name="ticketId" value="<%= entity.get("ticket_id") %>"/>
        <input type="hidden" name="ticketType" value="<%= entity.get("ticket_type") %>"/>
        
        <p>Target Structural Hash: <code><%= entity.get("ticket_id") %></code> (<%= entity.get("ticket_type") %> Tier)</p>
        <p>Update Seat Target:<br/><input type="text" name="seatNumber" value="<%= entity.get("seat_number") %>" required/></p>
        <p>Update Base Token Valuation ($):<br/><input type="number" name="basePrice" step="0.01" value="<%= entity.get("base_price") %>" required/></p>
        
        <% if("VIP".equalsIgnoreCase(entity.get("ticket_type"))) { %>
            <div style="border:1px solid #aaa; padding:15px; margin-bottom:15px; background-color:#fffdf0;">
                <p>VIP Allocation Premium Cost ($):<br/><input type="number" name="extraFee" step="0.01" value="<%= entity.get("extra_fee") %>"/></p>
                <p>Configured Concession Item:<br/><input type="text" name="snack" value="<%= entity.get("snack") %>"/></p>
            </div>
        <% } %>
        
        <input type="submit" value="Commit Matrix Mutations" style="padding:5px 15px;"/>
        <a href="ReadTickets" style="margin-left:10px;">Discard Changes</a>
    </form>
</body>
</html>