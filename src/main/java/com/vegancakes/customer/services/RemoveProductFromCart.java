package com.vegancakes.customer.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.admin.control.CategoryControl;
import com.vegancakes.customer.control.CartControl;

/**
 * Servlet implementation class RemoveProductFromCart
 */
@WebServlet("/remove-from-cart")
public class RemoveProductFromCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CartControl cc = new CartControl();
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		cc.deleteItemFromCart(Integer.parseInt(id));
        String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Remove Item successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("shoping-cart.jsp");
	}

}
