package com.vegancakes.entity;

public class OrderItem {
    
    private int id;
    private int orderId;
    private int productId;
    private int quantity;
    private Product product;
    private Order order;

    public OrderItem() {

    }

    public OrderItem(int id, int orderId, int productId, int quantity) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }
    
    

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getString() {
        return "{\"id\":" + id + ", \"orderId\":" + orderId + ", \"productId\":" + productId + ", \"quantity\":" + quantity + "}";
    }
}
