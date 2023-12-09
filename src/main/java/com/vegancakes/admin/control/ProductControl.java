package com.vegancakes.admin.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vegancakes.database.Database;
import com.vegancakes.entity.Category;
import com.vegancakes.entity.Product;

public class ProductControl {
	Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    
    // Method to execute get account query.
    private Product queryGetProduct(String query) {
    	Product product = new Product();
    	CategoryControl cc = new CategoryControl();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
            	
            	product.setId(resultSet.getInt(1));
            	product.setName(resultSet.getString(2));
            	product.setDesc(resultSet.getString(3));
            	product.setCategory(cc.getCategory(resultSet.getInt(4)));
            	product.setCategoryId(resultSet.getInt(4));
            	product.setPrice(resultSet.getInt(5));
            	product.setPath(resultSet.getString(6));
            	product.setStock(resultSet.getInt(7));
            	product.setActive(resultSet.getBoolean(8));
            	
            	System.out.println(product);
            	
                return product;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    
    // Method to execute query to get list users.
    private List<Product> getListProductQuery(String query) {
        List<Product> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
            	Product product = new Product();
            	product.setId(resultSet.getInt(1));
            	product.setName(resultSet.getString(2));
            	product.setDesc(resultSet.getString(3));
            	
            	Category c = new Category(resultSet.getInt("c_Id"),resultSet.getString("c_Name"));
            	product.setCategory(c);

            	product.setCategoryId(resultSet.getInt(4));
            	product.setPrice(resultSet.getInt(5));
            	product.setPath(resultSet.getString(6));
            	product.setStock(resultSet.getInt(7));
            	product.setActive(resultSet.getBoolean(8));

                list.add(product);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public List<Product> getProductAll(){
    	String query = "SELECT product.*, category.Id AS c_Id, category.Name AS c_Name FROM product JOIN category ON product.Category = category.Id";
        return getListProductQuery(query);
    }
    
    public List<Product> getProductActiveAll(){
    	String query = "SELECT product.*, category.Id AS c_Id, category.Name AS c_Name FROM product JOIN category ON product.Category = category.Id WHERE Active = true ";
        return getListProductQuery(query);
    }
    
    public List<Product> getRelatedProductAll(int catId){
    	String query = "SELECT product.*, category.Id AS c_Id, category.Name AS c_Name FROM product JOIN category ON product.Category = category.Id WHERE Category = "+catId;
        return getListProductQuery(query);
    }
	
	// Method to get user by id.
    public Product getProduct(int id) {
        String query = "SELECT * FROM product WHERE product.Id = " + id;
        return queryGetProduct(query);
    }

    // Method to create an product.
    public void createProduct(String name, String desc, int cat, int price, String path, int stock, Boolean active) {
        String query = "INSERT INTO product (`Name`, `Description`, `Category`, `Price`, `Path`, `Stock`, `Active`, `CreatedDate`, `ModifiedDate`) VALUES (?, ?, ?, ?, ?, ?, ?, now(), now())";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, desc);
            preparedStatement.setInt(3, cat);
            preparedStatement.setInt(4, price);
            preparedStatement.setString(5, path);
            preparedStatement.setInt(6, stock);
            preparedStatement.setBoolean(7, active);
            
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    // Method to update product information.
    public void updateProductInformation(int id, String name, String desc, int cat, int price, String path, int stock, Boolean active) {
        String query = "UPDATE product SET " +
                "Name = ?, " +
                "Description = ?, " +
                "Category = ?, " +
                "Price = ?, " +
                "Path = ?, " +
                "Stock = ?, " +
                "Active = ? " +
                "WHERE Id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, desc);
            preparedStatement.setInt(3, cat);
            preparedStatement.setInt(4, price);
            preparedStatement.setString(5, path);
            preparedStatement.setInt(6, stock);
            preparedStatement.setBoolean(7, active);
            preparedStatement.setInt(8, id);
            
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Update profile catch: " + e.getMessage());
        }
    }
    
    public void handleProductActivation(int id, Boolean active) {
        String query = "UPDATE product SET " +
                "Active = ? " +
                "WHERE Id = ?";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setBoolean(1, active);
            preparedStatement.setInt(2, id);
            
            preparedStatement.executeUpdate();
            System.out.println(query);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Activation Product catch: " + e.getMessage());
        }
    }
    
    public void updateProductStock(int id, int qty) {
        String query = "UPDATE product SET " +
                "Stock = Stock - ? " +
                "WHERE Id = ?";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, qty);
            preparedStatement.setInt(2, id);
            
            preparedStatement.executeUpdate();
            System.out.println(query);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("updateProductStock Product catch: " + e.getMessage());
        }
    }
    
    
    public void deleteProduct(int id) {
    	
    	String query ="DELETE FROM product WHERE Id = ?";
    	
    	try {
    		
    		Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
		} catch (Exception e) {
			System.out.println("Delete product catch: " + e.getMessage());
		}
    	
    }
}
