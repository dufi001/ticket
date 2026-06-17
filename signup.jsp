<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unity Tickets - Profile Registration</title>
    <style>
        /* Modern System Baseline Settings */
        * { 
            box-sizing: border-box; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0;
            padding: 0;
        }
        
        body { 
            /* Matches the premium dark slate background of your login page */
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); 
            min-height: 100vh;
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            justify-content: space-between; 
            padding: 20px;
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
        
        .auth-container { 
            background: #ffffff; 
            max-width: 420px; 
            width: 100%; 
            padding: 35px 30px; 
            border-radius: 12px; 
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3); 
            margin-top: 25px; 
            border-top: 5px solid #2ECC71; /* Emerald green accent identity for signups */
        }
        
        h2 { 
            color: #2C3E50; 
            margin-bottom: 25px;
            text-align: center;
            font-size: 24px;
            font-weight: 700;
        }
        
        .form-group { 
            margin-bottom: 20px; 
            width: 100%; 
        }
        
        .form-group label { 
            display: block; 
            margin-bottom: 8px; 
            font-weight: 600; 
            color: #4A5568; 
            font-size: 14px;
        }
        
        .form-group input { 
            width: 100%; 
            padding: 12px 14px; 
            border: 1px solid #cbd5e0; 
            border-radius: 5px; 
            font-size: 14px; 
            color: #2d3748;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #2ECC71;
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.15);
        }
        
        .btn { 
            width: 100%; 
            padding: 14px; 
            background-color: #2ECC71; 
            color: white; 
            border: none; 
            border-radius: 5px; 
            font-weight: bold; 
            cursor: pointer; 
            font-size: 16px; 
            letter-spacing: 0.5px;
            transition: background-color 0.2s; 
            margin-top: 10px;
        }
        
        .btn:hover { 
            background-color: #27AE60; 
        }
        
        .error-msg { 
            color: #E53E3E; 
            background: #FFF5F5; 
            padding: 12px; 
            border-radius: 5px; 
            margin-bottom: 20px; 
            font-size: 14px; 
            border-left: 4px solid #E53E3E; 
            width: 100%; 
        }

        .success-msg {
            color: #38A169;
            background: #F0FFF4;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
            border-left: 4px solid #38A169;
            width: 100%;
        }
        
        .link-text { 
            margin-top: 25px; 
            text-align: center; 
            font-size: 14px; 
            color: #718096;
        }
        
        .link-text a { 
            color: #4A90E2; 
            text-decoration: none; 
            font-weight: bold;
            margin-left: 5px;
        }

        .link-text a:hover {
            text-decoration: underline;
        }

        /* Universal System Main Page Footer component */
        .system-footer {
            width: 100%;
            text-align: center;
            padding: 20px 0 10px 0;
            color: #64748b; 
            font-size: 13px;
            border-top: 1px solid #334155; 
            margin-top: 40px;
        }
    </style>
</head>
<body>

    <div class="main-wrapper">
        
        <%@ include file="ownershipBanner.jsp" %>

        <div class="auth-container">
            <h2>Create Profile Identity</h2>
            
            <%-- Dynamic conditional message display blocks for feedback --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-msg"><%= request.getAttribute("errorMessage") %></div>
            <% } %>
            
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="success-msg"><%= request.getAttribute("successMessage") %></div>
            <% } %>

            <form action="<%= request.getContextPath() %>/Signup" method="post">
                <div class="form-group">
                    <label for="fullName">Full Customer Name:</label>
                    <input type="text" id="fullName" name="fullName" required placeholder="Enter your full name">
                </div>
                
                <div class="form-group">
                    <label for="username">Preferred Username:</label>
                    <input type="text" id="username" name="username" required placeholder="Choose a system identity username">
                </div>
                
                <div class="form-group">
                    <label for="password">Secure Passkey Password:</label>
                    <input type="password" id="password" name="password" required placeholder="Create a secure password">
                </div>
                
                <button type="submit" class="btn">Register Profile Ledger</button>
            </form>
            
            <div class="link-text">
                Already registered?<a href="<%= request.getContextPath() %>/index.jsp">Log inside gateway here</a>
            </div>
        </div>
    </div>

    <footer class="system-footer">
        Unity Tickets Core System Framework Engine • Powered by Islael Dufitimana • 2026
    </footer>

</body>
</html>