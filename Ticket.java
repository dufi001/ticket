/*
 * Student 1: RegNo_FullName1 | Class: A/B/C
 * Student 2: RegNo_FullName2 | Class: A/B/C
 */
package com.tickets.tickettypes;

import com.tickets.interfaces.IBookable;
import java.util.ArrayList;
import java.util.List;

public abstract class Ticket implements IBookable {
    // Final field and static field metrics required by rubric
    protected final String ticketNumber;
    public static int totalTickets = 0;
    public static List<Ticket> allTickets = new ArrayList<>();

    protected int userId;
    protected String seatNumber;
    protected double basePrice;

    public Ticket(String ticketNumber, int userId, String seatNumber, double basePrice) {
        this.ticketNumber = ticketNumber;
        this.userId = userId;
        this.seatNumber = seatNumber;
        this.basePrice = basePrice;
        totalTickets++;
    }

    public String getTicketNumber() { return ticketNumber; }
    public int getUserId() { return userId; }
    public String getSeatNumber() { return seatNumber; }
    public double getBasePrice() { return basePrice; }

    public abstract String getTicketType();
    public abstract double calculateFinalPrice();

    @Override
    public void buy() { /* Operational business hooks */ }
    @Override
    public void cancel() { /* Operational business hooks */ }
}