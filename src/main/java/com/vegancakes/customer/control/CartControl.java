package com.vegancakes.customer.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vegancakes.admin.control.ProductControl;
import com.vegancakes.admin.control.UserControl;
import com.vegancakes.database.Database;
import com.vegancakes.entity.Cart;
import com.vegancakes.entity.Product;

public class CartControl {
	
	Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    
    private Cart queryGetCart(String query) {
    	
    	Cart cart = new Cart();
    	
    	UserControl uc = new UserControl();
    	ProductControl pc = new ProductControl();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
            	
            	cart.setId(resultSet.getInt(1));
            	cart.setUserId(resultSet.getInt(2));
            	cart.setProductId(resultSet.getInt(3));
            	cart.setUser(uc.getUser(resultSet.getInt(2)));
            	cart.setProduct(pc.getProduct(resultSet.getInt(3)));
            	cart.setQuantity(resultSet.getInt(4));
            	
            	System.out.println(cart);
            	
                return cart;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    
 // Method to execute query to get list users.
    private List<Cart> getListCartQuery(String query) {
        List<Cart> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
            	Cart cart = new Cart();
            	cart.setId(resultSet.getInt(1));
            	cart.setUserId(resultSet.getInt(2));
            	cart.setProductId(resultSet.getInt(3));
            	cart.setQuantity(resultSet.getInt(4));

            	Product pro = new Product();
            	pro.setId(resultSet.getInt("p_Id"));
            	pro.setName(resultSet.getString("p_Name"));
            	pro.setPrice(resultSet.getInt("p_Price"));
            	pro.setPath(resultSet.getString("p_Path"));
            	pro.setStock(resultSet.getInt("p_Stock"));
            	
            	cart.setProduct(pro);
            	
                list.add(cart);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public List<Cart> getCartAll(int userId){
    	String query = "SELECT cart.*, product.Id AS p_Id, product.Name AS p_Name, product.Price AS p_Price, product.Path AS p_Path, product.Stock AS p_Stock FROM cart JOIN product ON cart.Product = product.Id WHERE User = "+userId;
        return getListCartQuery(query);
    }
	
	// Method to get user by id.
    public Cart getCart(int id) {
        String query = "SELECT * FROM cart WHERE Id = " + id;
        return queryGetCart(query);
    }
    
 
    public void addItemToCart(int user, int pro, int qty) {
        String query = "INSERT INTO cart (`User`, `Product`, `QTY`, `CreatedDate`, `ModifiedDate`) VALUES (?, ?, ?, now(), now())";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, user);
            preparedStatement.setInt(2, pro);
            preparedStatement.setInt(3, qty);
            
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public void updateQuantity(int id, int qty) {
        String query = "UPDATE cart SET " +
                "QTY = ? " +
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
            System.out.println("updateQuantity catch: " + e.getMessage());
        }
    }
    
    
    public void deleteItemFromCart(int id) {
    	
    	String query ="DELETE FROM cart WHERE Id = ?";
    	
    	try {
    		
    		Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
		} catch (Exception e) {
			System.out.println("Delete Cart Item catch: " + e.getMessage());
		}
    	
    }

}
