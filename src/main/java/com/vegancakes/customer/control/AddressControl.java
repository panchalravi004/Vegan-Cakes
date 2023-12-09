package com.vegancakes.customer.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vegancakes.database.Database;
import com.vegancakes.entity.Address;

public class AddressControl {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    private Address queryGetAddress(String query) {
        Address address = new Address();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                address.setId(resultSet.getInt("Id"));
                address.setLine1(resultSet.getString("Address_Line1"));
                address.setLine2(resultSet.getString("Address_Line2"));
                address.setCity(resultSet.getString("City"));
                address.setPin(resultSet.getInt("PostalCode"));
                address.setCountry(resultSet.getString("Country"));
                address.setPhone(resultSet.getInt("Telephone"));

                return address;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    private List<Address> getListAddressQuery(String query) {
        List<Address> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Address address = new Address();
                address.setId(resultSet.getInt("Id"));
                address.setLine1(resultSet.getString("Address_Line1"));
                address.setLine2(resultSet.getString("Address_Line2"));
                address.setCity(resultSet.getString("City"));
                address.setPin(resultSet.getInt("PostalCode"));
                address.setCountry(resultSet.getString("Country"));
                address.setPhone(resultSet.getInt("Telephone"));

                list.add(address);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Address> getAddressAll() {
        String query = "SELECT * FROM address";
        return getListAddressQuery(query);
    }

    public Address getAddress(int id) {
        String query = "SELECT * FROM address WHERE Id = " + id;
        return queryGetAddress(query);
    }
    
    public Address getAddressByUser(int id) {
        String query = "SELECT * FROM address WHERE User = " + id;
        return queryGetAddress(query);
    }

    public void createAddress(String line1, String line2, String city, int pin, String country, int phone, int userId) {
        String query = "INSERT INTO address (User, Address_Line1, Address_Line2, City, PostalCode, Country, Telephone, CreatedDate, ModifiedDate) VALUES (?, ?, ?, ?, ?, ?, ?, now(), now())";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, line1);
            preparedStatement.setString(3, line2);
            preparedStatement.setString(4, city);
            preparedStatement.setInt(5, pin);
            preparedStatement.setString(6, country);
            preparedStatement.setInt(7, phone);
            preparedStatement.executeUpdate();
            

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void updateAddressInformation(int id, String line1, String line2, String city, int pin, String country, int phone, int userId) {
        String query = "UPDATE address SET " +
                "User = ?, " +
                "Address_Line1 = ?, " +
                "Address_Line2 = ?, " +
                "City = ?, " +
                "PostalCode = ?, " +
                "Country = ?, " +
                "Telephone = ? " +
                "WHERE Id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, line1);
            preparedStatement.setString(3, line2);
            preparedStatement.setString(4, city);
            preparedStatement.setInt(5, pin);
            preparedStatement.setString(6, country);
            preparedStatement.setInt(7, phone);
            preparedStatement.setInt(8, id);
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Update address catch: " + e.getMessage());
        }
    }

    public void deleteAddress(int id) {
        String query = "DELETE FROM address WHERE Id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Delete Address catch: " + e.getMessage());
        }
    }
}
