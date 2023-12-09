package com.vegancakes.customer.control;

import com.vegancakes.database.Database;
import com.vegancakes.entity.Customer;

import java.sql.*;

public class CustomerControl {
	
	Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    
    // Method to execute get account query.
    private Customer queryGetCustomer(String query) {
    	Customer customer = new Customer();
    	AddressControl ac = new AddressControl();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
            	customer.setId(resultSet.getInt(1));
            	customer.setFirstName(resultSet.getString(2));
            	customer.setLastName(resultSet.getString(3));
            	customer.setEmail(resultSet.getString(4));
            	customer.setPassword(resultSet.getString(5));
            	customer.setMobile(resultSet.getString(6));
            	customer.setType(resultSet.getString(7));
            	customer.setAddress(ac.getAddressByUser(resultSet.getInt(1)));
            	
            	System.out.println(customer);
            	
                return customer;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
	
	// Method to get customer by id.
    public Customer getCustomer(int customerId) {
        String query = "SELECT * FROM user WHERE Id = " + customerId;
        return queryGetCustomer(query);
    }

    // Method to get login customer from database.
    public Customer checkLoginCustomer(String email, String password) {
        String query = "SELECT * FROM user WHERE Email= '" + email + "' AND Password = '" + password + "'";
        return queryGetCustomer(query);
    }

    // Method to check is email exist or not.
    public boolean checkEmailExists(String email) {
        String query = "SELECT * FROM user WHERE Email = '" + email + "'";
        return (queryGetCustomer(query) != null);
    }

    // Method to create an account.
    public void createCustomer(String fname, String lname, String email, String password, String mobile, String type) {
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

}
