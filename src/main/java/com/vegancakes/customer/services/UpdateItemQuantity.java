package com.vegancakes.customer.services;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.customer.control.CartControl;

/**
 * Servlet implementation class UpdateItemQuantity
 */
@WebServlet("/update-item-quantity")
public class UpdateItemQuantity extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	CartControl cc = new CartControl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String qty = request.getParameter("qty");
		
		cc.updateQuantity(Integer.parseInt(id), Integer.parseInt(qty));
		
		PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print("success");
        out.flush();
		
	}

}
