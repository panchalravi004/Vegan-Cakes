package com.vegancakes.customer.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vegancakes.admin.control.ProductControl;
import com.vegancakes.database.Database;
import com.vegancakes.entity.OrderItem;

public class OrderItemControl {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    private OrderItem queryGetOrderItem(String query) {
        OrderItem orderItem = new OrderItem();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                orderItem.setId(resultSet.getInt("Id"));
                orderItem.setOrderId(resultSet.getInt("Order"));
                orderItem.setProductId(resultSet.getInt("Product"));
                orderItem.setQuantity(resultSet.getInt("QTY"));

                return orderItem;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    private List<OrderItem> getListOrderItemQuery(String query) {
        List<OrderItem> list = new ArrayList<>();
        ProductControl pc = new ProductControl();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setId(resultSet.getInt("Id"));
                orderItem.setOrderId(resultSet.getInt("Order"));
                orderItem.setProductId(resultSet.getInt("Product"));
                orderItem.setProduct(pc.getProduct(resultSet.getInt("Product")));
                orderItem.setQuantity(resultSet.getInt("QTY"));

                list.add(orderItem);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<OrderItem> getOrderItemAll() {
        String query = "SELECT * FROM `order_items`";
        return getListOrderItemQuery(query);
    }
    
    public List<OrderItem> getOrderItemByOrderId(int orderId) {
        String query = "SELECT * FROM `order_items` WHERE `Order` = "+orderId;
        return getListOrderItemQuery(query);
    }

    public OrderItem getOrderItem(int id) {
        String query = "SELECT * FROM `order_items` WHERE Id = " + id;
        return queryGetOrderItem(query);
    }

    public void createOrderItem(int orderId, int productId, int quantity) {
        String query = "INSERT INTO `order_items` (`Order`, `Product`, `QTY`, `CreatedDate`, `ModifiedDate`) " +
                "VALUES (?, ?, ?, NOW(), NOW())";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, orderId);
            preparedStatement.setInt(2, productId);
            preparedStatement.setInt(3, quantity);
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void updateOrderItemInformation(int id, int orderId, int productId, int quantity) {
        String query = "UPDATE `order_items` SET " +
                "`Order` = ?, " +
                "`Product` = ?, " +
                "`QTY` = ?, " +
                "`ModifiedDate` = NOW() " +
                "WHERE `Id` = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, orderId);
            preparedStatement.setInt(2, productId);
            preparedStatement.setInt(3, quantity);
            preparedStatement.setInt(4, id);
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Update order item catch: " + e.getMessage());
        }
    }

    public void deleteOrderItem(int id) {
        String query = "DELETE FROM `order_items` WHERE `Id` = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = new Database().getConnection();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Delete Order Item catch: " + e.getMessage());
        }
    }
}
