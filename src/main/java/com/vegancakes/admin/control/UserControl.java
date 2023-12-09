package com.vegancakes.admin.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vegancakes.database.Database;
import com.vegancakes.entity.User;

public class UserControl {
	
	Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    
    // Method to execute get account query.
    private User queryGetUser(String query) {
    	User user = new User();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
            	user.setId(resultSet.getInt(1));
            	user.setFirstName(resultSet.getString(2));
            	user.setLastName(resultSet.getString(3));
            	user.setEmail(resultSet.getString(4));
            	user.setPassword(resultSet.getString(5));
            	user.setMobile(resultSet.getString(6));
            	user.setType(resultSet.getString(7));
            	
            	System.out.println(user);
            	
                return user;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    
    // Method to execute query to get list users.
    private List<User> getListUserQuery(String query) {
        List<User> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
            	User user = new User();
            	user.setId(resultSet.getInt(1));
            	user.setFirstName(resultSet.getString(2));
            	user.setLastName(resultSet.getString(3));
            	user.setEmail(resultSet.getString(4));
            	user.setPassword(resultSet.getString(5));
            	user.setMobile(resultSet.getString(6));
            	user.setType(resultSet.getString(7));

                list.add(user);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public List<User> getNonAdminUser(){
    	String query = "SELECT * FROM user WHERE Type != 'Admin'";
        return getListUserQuery(query);
    }
	
	// Method to get user by id.
    public User getUser(int userId) {
        String query = "SELECT * FROM user WHERE Id = " + userId;
        return queryGetUser(query);
    }

    // Method to get login user from database.
    public User checkLoginUser(String email, String password) {
        String query = "SELECT * FROM user WHERE Email= '" + email + "' AND Password = '" + password + "' AND (Type = 'Admin' OR Type = 'Staff')";
        return queryGetUser(query);
    }

    // Method to check is email exist or not.
    public boolean checkEmailExists(String email) {
        String query = "SELECT * FROM user WHERE Email = '" + email + "'";
        return (queryGetUser(query) != null);
    }

    // Method to create an user.
    public void createUser(String fname, String lname, String email, String password, String mobile, String type) {
        String query = "INSERT INTO user (`Firstname`, `Lastname`, `Email`, `Password`, `Mobile`, `Type`, `CreatedDate`, `ModifiedDate`) VALUES (?, ?, ?, ?, ?, ?, now(), now())";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, fname);
            preparedStatement.setString(2, lname);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, password);
            preparedStatement.setString(5, mobile);
            preparedStatement.setString(6, type);
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    // Method to update profile information.
    public void updateProfileInformation(int id, String fname, String lname, String email, String password, String mobile) {
        String query = "UPDATE user SET " +
                "Firstname = ?, " +
                "Lastname = ?, " +
                "Email = ?, " +
                "Password = ?, " +
                "Mobile = ? " +
                "WHERE Id = ?";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, fname);
            preparedStatement.setString(2, lname);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, password);
            preparedStatement.setString(5, mobile);
            preparedStatement.setInt(6, id);
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Update profile catch: " + e.getMessage());
        }
    }
    
    
    public void deleteUser(int id) {
    	
    	String query ="DELETE FROM user WHERE Id = ?";
    	
    	try {
    		
    		Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
		} catch (Exception e) {
			System.out.println("Delete User catch: " + e.getMessage());
		}
    	
    }

}
