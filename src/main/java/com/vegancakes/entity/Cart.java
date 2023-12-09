package com.vegancakes.entity;

public class Cart {
	
	private int id;
	private int qty;
    private int userId;
    private int productId;
    private User user;
    private Product product;

    public Cart() {

    }

    public Cart(int id, int userId, int productId) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public int getQuantity() {
        return qty;
    }

    public void setQuantity(int qty) {
        this.qty = qty;
    }

    
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
    public int getTotal() {
        return this.qty * this.product.getPrice();
    }
    
    public String getString() {
        return "{\"id\":" + id +", \"userId\":" + userId +", \"productId\":" + productId +"}";
    }

}
