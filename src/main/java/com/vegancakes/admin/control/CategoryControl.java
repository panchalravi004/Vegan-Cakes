package com.vegancakes.admin.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vegancakes.database.Database;
import com.vegancakes.entity.Category;
import com.vegancakes.entity.User;

public class CategoryControl {
	Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    
    // Method to execute get account query.
    private Category queryGetCategory(String query) {
    	Category cat = new Category();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
            	cat.setId(resultSet.getInt(1));
            	cat.setName(resultSet.getString(2));
            	cat.setPath(resultSet.getString(3));
            	
            	System.out.println(cat);
            	
                return cat;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    
    // Method to execute query to get list users.
    private List<Category> getListCategoryQuery(String query) {
        List<Category> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
            	Category cat = new Category();
            	cat.setId(resultSet.getInt(1));
            	cat.setName(resultSet.getString(2));
            	cat.setPath(resultSet.getString(3));

                list.add(cat);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public List<Category> getCategoryAll(){
    	String query = "SELECT * FROM category";
        return getListCategoryQuery(query);
    }

	// Method to get user by id.
    public Category getCategory(int id) {
        String query = "SELECT * FROM category WHERE Id = " + id;
        return queryGetCategory(query);
    }

    // Method to create an user.
    public void createCategory(String name, String path) {
        String query = "INSERT INTO category (`Name`, `Path`, `CreatedDate`, `ModifiedDate`) VALUES (?, ?, now(), now())";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, path);
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    // Method to update profile information.
    public void updateCategoryInformation(int id, String name, String path) {
        String query = "UPDATE category SET " +
                "Name = ?, " +
                "Path = ? " +
                "WHERE Id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, path);
            preparedStatement.setInt(3, id);
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Update category catch: " + e.getMessage());
        }
    }
    
    
    public void deleteCategory(int id) {
    	
    	String query ="DELETE FROM category WHERE Id = ?";
    	
    	try {
    		
    		Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
		} catch (Exception e) {
			System.out.println("Delete Category catch: " + e.getMessage());
		}
    	
    }

}
