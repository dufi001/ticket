/*
 * Student 1: RegNo_FullName1 | Class: A/B/C
 * Student 2: RegNo_FullName2 | Class: A/B/C
 */
package com.tickets.tickettypes;

public class StandardTicket extends Ticket {
    
    public StandardTicket(String ticketNumber, int userId, String seatNumber, double basePrice) {
        super(ticketNumber, userId, seatNumber, basePrice);
    }

    @Override
    public String getTicketType() { return "Standard"; }

    @Override
    public double calculateFinalPrice() {
        return this.basePrice; // Standard tickets carry no surcharges
    }

    @Override
    public String showTicketInfo() {
        return "Standard Ticket [" + ticketNumber + "] Seat: " + seatNumber + " Price: $" + calculateFinalPrice();
    }
}