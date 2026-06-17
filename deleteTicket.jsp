<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Destructive Operations Confirm Panel</title></head>
<body style="font-family:sans-serif; margin:30px;">
    <%@ include file="ownershipBanner.jsp" %>
    <h2 style="color:red;">Destructive Transactional Authorization Request</h2>
    <p>Are you completely sure you want to drop ticket ID reference <strong><%= request.getAttribute("targetId") %></strong> from the active operational registry database?</p>
    
    <form action="DeleteTicket" method="post">
        <input type="hidden" name="ticketId" value="<%= request.getAttribute("targetId") %>"/>
        <input type="submit" value="Confirm Drop Instruction" style="background-color:#d9534f; color:white; padding:8px 16px; border:none; cursor:pointer;"/>
        <a href="ReadTickets" style="margin-left:15px;">Abort Safety Recovery Loop</a>
    </form>
</body>
</html>