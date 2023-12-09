package com.vegancakes.admin.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.admin.control.ProductControl;

/**
 * Servlet implementation class ProductActivation
 */
@WebServlet("/admin/product-activation")
public class ProductActivation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ProductControl pc = new ProductControl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		Boolean status = Boolean.valueOf(request.getParameter("status"));
		
		System.out.println(Boolean.valueOf(request.getParameter("status")));
		
		pc.handleProductActivation(Integer.parseInt(id), status);
		String alert = "<div class=\"alert alert-success alert-dismissible wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Status Update successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("manage-product.jsp");
				
	}

}
