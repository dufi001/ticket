<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Session Verification Guard Clause
    String activeUser = (String) session.getAttribute("loggedUser");
    if (activeUser == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unity Tickets - Dashboard Hub</title>
    <style>
        /* Modern System Baseline Settings */
        * { 
            box-sizing: border-box; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0;
            padding: 0;
        }
        
        body { 
            /* Matches the premium dark slate background of your platform identity */
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); 
            min-height: 100vh;
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            justify-content: space-between; 
            padding: 30px 20px;
        }

        /* Center Layout Wrapper Main Station */
        .main-wrapper {
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            flex-grow: 1;
            justify-content: center;
        }
        
        .dashboard-card {
            background: #ffffff;
            padding: 45px 40px;
            border-radius: 14px;
            max-width: 580px; /* Wider boundaries to give elements text breathing room */
            width: 100%;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            margin-top: 30px;
            border-top: 6px solid #2ECC71; /* Emerald green accent indicating active user zone */
        }

        /* 🌟 ENLARGED: Big, warm welcome title text */
        .welcome-title {
            color: #1e293b;
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 15px;
            letter-spacing: 0.3px;
        }

        /* 🌟 ENLARGED: Crisp accessible contextual info text */
        .dashboard-card p {
            color: #4A5568;
            font-size: 17px; /* Medium accessibility scaling text */
            line-height: 1.6;
            margin-bottom: 35px;
        }

        /* Responsive Action Grid Tray */
        .action-links {
            display: flex;
            gap: 20px;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap; /* Automatically scales safely on mobile view screens */
        }

        /* 🌟 ENLARGED: Highly responsive and readable buttons */
        .btn-primary {
            background-color: #4A90E2;
            padding: 16px 28px;
            color: white;
            text-decoration: none;
            font-weight: 700;
            font-size: 16px;
            border-radius: 8px;
            transition: background-color 0.2s, transform 0.1s;
            box-shadow: 0 4px 10px rgba(74, 144, 226, 0.25);
        }

        .btn-primary:hover {
            background-color: #357ABD;
        }

        .btn-secondary {
            background-color: #2ECC71;
            padding: 16px 28px;
            color: white;
            text-decoration: none;
            font-weight: 700;
            font-size: 16px;
            border-radius: 8px;
            transition: background-color 0.2s;
            box-shadow: 0 4px 10px rgba(46, 204, 113, 0.25);
        }

        .btn-secondary:hover {
            background-color: #27AE60;
        }

        /* High Visibility Text Logout Link */
        .btn-logout {
            color: #ef4444;
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            padding: 10px 15px;
            transition: color 0.2s;
        }

        .btn-logout:hover {
            color: #dc2626;
            text-decoration: underline;
        }

        /* Universal System Main Page Footer component */
        .system-footer {
            width: 100%;
            text-align: center;
            padding: 25px 0 10px 0;
            color: #64748b; 
            font-size: 14px;
            border-top: 1px solid #334155; 
            margin-top: 50px;
        }
    </style>
</head>
<body>

    <div class="main-wrapper">
        
        <%@ include file="ownershipBanner.jsp" %>

        <div class="dashboard-card">
            <div class="welcome-title">Welcome back, <%= activeUser %>! 👋</div>
            <p>Your client profile session has been securely validated and initialized against the system registry ledger core context.</p>
            
            <div class="action-links">
                <a href="<%= request.getContextPath() %>/buyTicket.jsp" class="btn-primary">Book New Ticket</a>
                
             <a href="<%= request.getContextPath() %>/ReadTickets" class="btn-secondary">View Transactions</a>
                
                <a href="<%= request.getContextPath() %>/Logout" class="btn-logout">Logout</a>
            </div>
        </div>
    </div>

    <footer class="system-footer">
        Unity Tickets Core System Framework Engine •Islael Dufitimana • 2026
    </footer>

</body>
</html>