/*
 * Student 1: RegNo_FullName1 | Class: A/B/C
 * Student 2: RegNo_FullName2 | Class: A/B/C
 */
package com.tickets.users;

public class RegularUse extends User {
    public RegularUse(int userId, String name) {
        super(userId, name);
    }

    @Override
    public String getUserType() {
        return "RegularUser";
    }
}