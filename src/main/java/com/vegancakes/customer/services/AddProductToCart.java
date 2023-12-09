package com.vegancakes.customer.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.customer.control.CartControl;

/**
 * Servlet implementation class AddProductToCart
 */
@WebServlet("/add-to-cart")
public class AddProductToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	CartControl cc = new CartControl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("user");
		String pro = request.getParameter("pro");
		
		cc.addItemToCart(Integer.parseInt(user),Integer.parseInt(pro), 1);
        String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Item Added successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("shoping-cart.jsp");
		
		
	}

}
