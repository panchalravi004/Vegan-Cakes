package com.vegancakes.entity;

public class Category {
	
	private int id;
    private String name;
    private String path;

    public Category() {

    }

    public Category(int id, String name) {
        this.id = id;
        this.name = name;
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
    
    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    
    public String getString() {
        return "{\"id\":" + id +", \"name\":\"" + name +"\", \"path\":\"" + path +"\"}";
    }

}
