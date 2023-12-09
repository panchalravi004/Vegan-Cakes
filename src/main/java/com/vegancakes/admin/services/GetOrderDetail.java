package com.vegancakes.admin.services;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.entity.Order;
import com.vegancakes.customer.control.OrderControl;
import com.google.gson.Gson;
/**
 * Servlet implementation class GetOrderDetail
 */
@WebServlet("/admin/get-order-detail")
public class GetOrderDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	
	OrderControl oc = new OrderControl();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String orderId = request.getParameter("id");
		
		
		Order order = oc.getOrder(Integer.parseInt(orderId));
		
		//request.getSession().setAttribute("orderDetail", order);
		//response.sendRedirect("manage-order.jsp");
		
		PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print(new Gson().toJson(order));
        out.flush();
		
	}

	

}
