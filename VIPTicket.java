/*
 * Student 1: RegNo_FullName1 | Class: A/B/C
 * Student 2: RegNo_FullName2 | Class: A/B/C
 */
package com.tickets.tickettypes;

public class VIPTicket extends Ticket {
    private double vipFee;
    private String snack;

    public VIPTicket(String ticketNumber, int userId, String seatNumber, double basePrice, double vipFee, String snack) {
        super(ticketNumber, userId, seatNumber, basePrice);
        this.vipFee = vipFee;
        this.snack = snack;
    }

    public double getVipFee() { return vipFee; }
    public String getSnack() { return snack; }

    @Override
    public String getTicketType() { return "VIP"; }

    // Method Overriding required by grading scheme
    @Override
    public double calculateFinalPrice() {
        return this.basePrice + this.vipFee;
    }

    @Override
    public String showTicketInfo() {
        return "VIP Ticket [" + ticketNumber + "] Seat: " + seatNumber + " Price: $" + calculateFinalPrice() + " (Snack: " + snack + ")";
    }
}