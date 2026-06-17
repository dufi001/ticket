<%-- 
    Student 1: RegNo_FullName1 | Class: A/B/C
    Student 2: RegNo_FullName2 | Class: A/B/C
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Unity Tickets - Purchase Ticket</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f4f6f9; color: #333; }
        .container { max-width: 500px; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { color: #2c3e50; margin-top: 0; }
        .form-group { margin-bottom: 18px; }
        label { display: block; font-weight: bold; margin-bottom: 6px; font-size: 14px; }
        input[type="text"], input[type="number"], select { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        #vipSection { background-color: #fff9e6; border-left: 4px solid #f39c12; padding: 15px; margin-top: 15px; display: none; border-radius: 0 4px 4px 0; }
        .btn-submit { background-color: #2ecc71; color: white; border: none; padding: 12px 20px; font-size: 16px; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .btn-submit:hover { background-color: #27ae60; }
        .btn-cancel { color: #7f8c8d; text-decoration: none; margin-left: 15px; font-size: 14px; }
        .btn-cancel:hover { text-decoration: underline; }
        .ownership-banner { background: #eef2f7; border: 1px solid #d0d7de; padding: 12px; margin-bottom: 20px; font-family: monospace; font-size: 12px; border-radius: 4px; }
    </style>
    <script>
        // Shows or hides extra VIP input boxes depending on selection
        function toggleTicketType() {
            var ticketType = document.getElementById("ticketType").value;
            var vipSection = document.getElementById("vipSection");
            if (ticketType === "VIP") {
                vipSection.style.display = "block";
            } else {
                vipSection.style.display = "none";
            }
        }
    </script>
</head>
<body>

    <div class="container">
        <div class="ownership-banner">
            <strong>PROJECT OWNERSHIP NODE:</strong><br/>
            Partner 1: Student_1_Name (RegNo_1) - Class: [A/B/C]<br/>
            Partner 2: Student_2_Name (RegNo_2) - Class: [A/B/C]
        </div>

        <h2>Create / Purchase Ticket</h2>
        <hr style="border: 0; border-top: 1px solid #eee; margin-bottom: 20px;"/>

        <form action="CreateTicketServlet" method="post">
            
            <div class="form-group">
                <label for="userId">Select Customer Account:</label>
                <select name="userId" id="userId">
                    <option value="1">Nina (Regular User)</option>
                    <option value="2">Lucas (Regular User)</option>
                </select>
            </div>

            <div class="form-group">
                <label for="ticketType">Ticket Classification Tier:</label>
                <select name="ticketType" id="ticketType" onchange="toggleTicketType()">
                    <option value="Standard">Standard Ticket ($10.00)</option>
                    <option value="VIP">VIP Priority Ticket ($10.00 + fee)</option>
                </select>
            </div>

            <div class="form-group">
                <label for="seatNumber">Seat Number Allocation:</label>
                <input type="text" name="seatNumber" id="seatNumber" placeholder="e.g., A1, B2" required />
            </div>

            <div class="form-group">
                <label for="basePrice">Base Ticket Price ($):</label>
                <input type="number" name="basePrice" id="basePrice" step="0.01" value="10.00" required />
            </div>

            <div id="vipSection">
                <h4 style="margin: 0 0 10px 0; color: #d35400;">VIP Custom Add-Ons</h4>
                <div class="form-group">
                    <label for="vipFee">Supplemental VIP Fee ($):</label>
                    <input type="number" name="vipFee" id="vipFee" step="0.01" value="5.00" />
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <label for="snack">Included Refreshment Item:</label>
                    <input type="text" name="snack" id="snack" value="Popcorn" />
                </div>
            </div>

            <div style="margin-top: 25px;">
                <button type="submit" class="btn-submit">Process Booking</button>
                <a href="index.jsp" class="btn-cancel">Cancel & Go Back</a>
            </div>
            
        </form>
    </div>

</body>
</html>