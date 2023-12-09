package com.vegancakes.admin.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.customer.control.OrderControl;

/**
 * Servlet implementation class DeliverOrder
 */
@WebServlet("/admin/deliver-order")
public class DeliverOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	OrderControl oc = new OrderControl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		
		oc.updateOrderStatus(Integer.parseInt(id), "Deliverd");
		
		String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Deliverd successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("manage-orders.jsp");
		
		
	}

}
