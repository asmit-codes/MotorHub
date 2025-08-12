package com.vehicle.model;

import java.time.LocalDate;

public class Booking {
    private int booking_id;
    private int user_id;
    private int owner_id;
    private int vehicle_id;
    private LocalDate date;

    public Booking() {
    }

    public Booking(int booking_id, int user_id, int owner_id, int vehicle_id, LocalDate date) {
        this.booking_id = booking_id;
        this.user_id = user_id;
        this.owner_id = owner_id;
        this.vehicle_id = vehicle_id;
        this.date = date;
    }

    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getOwner_id() {
        return owner_id;
    }

    public void setOwner_id(int owner_id) {
        this.owner_id = owner_id;
    }

    public int getVehicle_id() {
        return vehicle_id;
    }

    public void setVehicle_id(int vehicle_id) {
        this.vehicle_id = vehicle_id;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }
}
