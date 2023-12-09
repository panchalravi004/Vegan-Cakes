package com.vegancakes.entity;

public class Product {
	
	private int id;
    private String name;
    private String desc;
    private Category category;
    private int categoryId;
    private int price;
    private String path;
    private int stock;
    private Boolean active;

    public Product() {

    }

    public Product(int id, String name,String desc, Category category, int categoryId, int price, String path, int stock, Boolean active ) {
        this.id = id;
        this.name = name;
        this.desc = desc;
        this.category = category;
        this.categoryId = categoryId;
        this.price = price;
        this.path = path;
        this.stock = stock;
        this.active = active;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
    
    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
    
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
    
    
    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
    
    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
    
    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    
    public String getString() {
        return "{\"id\":" + id +", \"name\":\"" + name +"\", \"desc\":\"" + desc +"\", \"price\":" + price +", \"stock\":" + stock +", \"active\":" + active +", \"categoryId\":" + categoryId +", \"path\": \"" +path+ "\"}";
    }

}
