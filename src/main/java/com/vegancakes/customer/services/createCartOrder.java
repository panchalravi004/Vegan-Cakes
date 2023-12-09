package com.vegancakes.customer.services;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.admin.control.ProductControl;
import com.vegancakes.customer.control.CartControl;
import com.vegancakes.customer.control.Helper;
import com.vegancakes.customer.control.OrderControl;
import com.vegancakes.customer.control.OrderItemControl;
import com.vegancakes.entity.Cart;
import com.vegancakes.entity.Customer;
import com.vegancakes.entity.OrderItem;

@WebServlet("/create-cart-order")
public class createCartOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	OrderControl oc = new OrderControl();
	OrderItemControl oic = new OrderItemControl();
	CartControl cc = new CartControl();
	ProductControl pc = new ProductControl();
	Helper help = new Helper();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Customer user = (Customer) request.getSession().getAttribute("customer");
		
		List<Cart> cartList = cc.getCartAll(user.getId());
		int total = help.getCartTotal(cartList);
		
		int orderId = oc.createOrder(user.getId(), total, (int) System.currentTimeMillis(),"Pending");
		
		for(Cart cart : cartList) {
			oic.createOrderItem(orderId, cart.getProductId(), cart.getQuantity());
			pc.updateProductStock(cart.getProductId(), cart.getQuantity());
			cc.deleteItemFromCart(cart.getId());
		}
		
		String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Create order successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("shoping-cart.jsp");
		
	}

}
