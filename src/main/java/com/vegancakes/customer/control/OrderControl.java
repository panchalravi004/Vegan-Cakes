package com.vegancakes.customer.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vegancakes.admin.control.UserControl;
import com.vegancakes.database.Database;
import com.vegancakes.entity.Order;

public class OrderControl {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    private Order queryGetOrder(String query) {
        Order order = new Order();
        OrderItemControl oic = new OrderItemControl();
        CustomerControl uc = new CustomerControl();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                order.setId(resultSet.getInt("Id"));
                order.setUserId(resultSet.getInt("User"));
                order.setUser(uc.getCustomer(resultSet.getInt("User")));
                order.setTotal(resultSet.getDouble("Total"));
                order.setPaymentId(resultSet.getInt("Payment Id"));
                order.setStatus(resultSet.getString("Status"));
                order.setOrderItem(oic.getOrderItemByOrderId(resultSet.getInt("Id")));

                return order;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    private List<Order> getListOrderQuery(String query) {
        List<Order> list = new ArrayList<>();
        OrderItemControl oic = new OrderItemControl();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Order order = new Order();
                order.setId(resultSet.getInt("Id"));
                order.setUserId(resultSet.getInt("User"));
                order.setTotal(resultSet.getDouble("Total"));
                order.setPaymentId(resultSet.getInt("Payment Id"));
                order.setStatus(resultSet.getString("Status"));
                order.setOrderItem(oic.getOrderItemByOrderId(resultSet.getInt("Id")));

                list.add(order);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Order> getOrderAll() {
        String query = "SELECT * FROM orders";
        return getListOrderQuery(query);
    }
    
    public List<Order> getOrderAllWithOrderItem() {
        String query = "SELECT * FROM orders";
        return getListOrderQuery(query);
    }
    
    public List<Order> getOrderAllCurrentUser(int userId) {
        String query = "SELECT * FROM orders WHERE User = "+userId;
        return getListOrderQuery(query);
    }

    public Order getOrder(int id) {
        String query = "SELECT * FROM orders WHERE Id = " + id;
        return queryGetOrder(query);
    }

    public int createOrder(int userId, double total, int paymentId, String status) {
        String query = "INSERT INTO orders (`User`, `Total`, `Payment Id`, `Status`, `CreatedDate`, `ModifiedDate`) " +
                "VALUES (?, ?, ?, ?, NOW(), NOW())";
        String[] returnId = { "id" };
        int orderId = -1;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query, returnId);
            preparedStatement.setInt(1, userId);
            preparedStatement.setDouble(2, total);
            preparedStatement.setInt(3, paymentId);
            preparedStatement.setString(4, status);
            int affectedRows = preparedStatement.executeUpdate();
            
            try (ResultSet rs = preparedStatement.getGeneratedKeys()) {
                if (rs.next()) {
                    System.out.println("Create Order Id :: "+rs.getInt(1));
                    orderId = rs.getInt(1);
                }
                rs.close();
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }
        return orderId;
    }

    public void updateOrderInformation(int id, int userId, double total, int paymentId, String status) {
        String query = "UPDATE orders SET " +
                "`User` = ?, " +
                "`Total` = ?, " +
                "`Payment Id` = ?, " +
                "`Status` = ?, " +
                "`ModifiedDate` = NOW() " +
                "WHERE `Id` = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setDouble(2, total);
            preparedStatement.setInt(3, paymentId);
            preparedStatement.setString(4, status);
            preparedStatement.setInt(5, id);
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Update order catch: " + e.getMessage());
        }
    }
    
    public void updateOrderStatus(int id, String status) {
        String query = "UPDATE orders SET " +
                "`Status` = ?, " +
                "`ModifiedDate` = NOW() " +
                "WHERE `Id` = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, id);
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Update order catch: " + e.getMessage());
        }
    }

    public void deleteOrder(int id) {
        String query = "DELETE FROM orders WHERE `Id` = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Delete Order catch: " + e.getMessage());
        }
    }
}
