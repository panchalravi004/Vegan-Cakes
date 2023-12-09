package com.vegancakes.admin.services;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.admin.control.ProductControl;
import com.vegancakes.entity.Product;

/**
 * Servlet implementation class GetProductDetail
 */
@WebServlet("/admin/get-product-detail")
public class GetProductDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	ProductControl pc = new ProductControl();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		Product pro = pc.getProduct(Integer.parseInt(id));
		
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print(pro.getString());
        out.flush();
	}


}
