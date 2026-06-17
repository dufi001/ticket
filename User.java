/*
 * Student 1: RegNo_FullName1 | Class: A/B/C
 * Student 2: RegNo_FullName2 | Class: A/B/C
 */
package com.tickets.users;

public abstract class User {
    protected int userId;
    protected String name;

    public User(int userId, String name) {
        this.userId = userId;
        this.name = name;
    }

    public int getUserId() { return userId; }
    public String getName() { return name; }
    public abstract String getUserType();
}