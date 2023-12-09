package com.vegancakes.entity;

public class Address {
    
    private int id;
    private User user;
    private int userId;
    private String line1;
    private String line2;
    private String city;
    private int pin;
    private String country;
    private int phone;

    public Address() {

    }

    public Address(int id, String line1, String line2, String city, int pin, String country, int phone) {
        this.id = id;
        this.line1 = line1;
        this.line2 = line2;
        this.city = city;
        this.pin = pin;
        this.country = country;
        this.phone = phone;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user= user;
    }
    
    public String getLine1() {
        return line1;
    }

    public void setLine1(String line1) {
        this.line1 = line1;
    }

    public String getLine2() {
        return line2;
    }

    public void setLine2(String line2) {
        this.line2 = line2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getPin() {
        return pin;
    }

    public void setPin(int pin) {
        this.pin = pin;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }
    
    public String getString() {
        return "{\"id\":" + id + ",\"userId\" : "+userId+", \"line1\":\"" + line1 + "\", \"line2\":\"" + line2 + "\", \"city\":\"" + city +
                "\", \"pin\":" + pin + ", \"country\":\"" + country + "\", \"phone\":" + phone + "}";
    }
}
