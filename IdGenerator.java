package com.tickets.servlets;

// Final class constraint enforcement
public final class IdGenerator {
    private static int counter = 1000;
    
    private IdGenerator() {} // Prevent instantiation
    
    public static synchronized String newId() {
        return "TICK-" + (++counter);
    }
}	