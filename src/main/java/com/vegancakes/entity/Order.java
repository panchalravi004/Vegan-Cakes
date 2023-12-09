package com.vegancakes.entity;

import java.util.List;

public class Order {
    
    private int id;
    private int userId;
    private Customer user;
    private double total;
    private int paymentId;
    private String status;
    private List<OrderItem> orderItems;

    public Order() {

    }

    public Order(int id, int OrderItem, double total, int paymentId, String status) {
        this.id = id;
        this.userId = userId;
        this.total = total;
        this.paymentId = paymentId;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public List<OrderItem> getOrderItem() {
        return orderItems;
    }

    public void setOrderItem(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public Customer getUser() {
        return user;
    }

    public void setUser(Customer user) {
        this.user = user;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getString() {
        return "{\"id\":" + id + ", \"userId\":" + userId + ", \"total\":" + total + ", \"paymentId\":" + paymentId +
                ", \"status\":\"" + status + "\"}";
    }
}
