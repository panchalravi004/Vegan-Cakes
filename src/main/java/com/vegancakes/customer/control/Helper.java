package com.vegancakes.customer.control;

import java.util.List;

import com.vegancakes.entity.Cart;

public class Helper {
	
	public int getItemTotal(int price, int qty) {
		return price * qty;
	}
	
	
	public int getCartTotal(List<Cart> cartList) {
		int total = 0;
		
		for(Cart c : cartList){
			total += c.getQuantity() * c.getProduct().getPrice();
		}
		
		return total;
	}
}
