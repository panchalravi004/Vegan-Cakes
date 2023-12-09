<%@page import="com.vegancakes.customer.control.Helper"%>
<%@page import="com.vegancakes.entity.Cart"%>
<%@page import="com.vegancakes.entity.Customer"%>
<%@page import="com.vegancakes.customer.control.CartControl"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	if(session.getAttribute("customer") == null){
		response.sendRedirect("login.jsp");
	}

	Customer o = (Customer) session.getAttribute("customer");
	
	if(o != null){
		
		/* out.println(o.getId());*/
		 
		CartControl uc = new CartControl();
		List<Cart> cartList = uc.getCartAll(o.getId());
		
		int total = 0;
		
		for(Cart c : cartList){
			total += c.getQuantity() * c.getProduct().getPrice();
		}
		
		pageContext.setAttribute("cartList", cartList);
		pageContext.setAttribute("total", total);
		
	}
	
	
	Helper help = new Helper();
	

%>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Vegan Cakes</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="static/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="static/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="static/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/style.css" type="text/css">
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    
    <jsp:include page="comman/header.jsp"/>

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="static/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Shopping Cart</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.jsp">Home</a>
                            <span>Shopping Cart</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Shoping Cart Section Begin -->
    <section class="shoping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th class="shoping__product">Products</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            	<c:forEach items="${pageScope.cartList}" var="item" >
                            		<tr>
	                                    <td class="shoping__cart__item">
	                                        <img src="/Vegan-Cakes/assets/products/${item.product.path}" width="70" alt="">
	                                        <h5>${item.product.name}</h5>
	                                    </td>
	                                    <td class="shoping__cart__price">
	                                        $ ${item.product.price}
	                                    </td>
	                                    <td class="shoping__cart__quantity">
	                                    	<div class="btn-group" role="group" aria-label="Basic example">
											  <button type="button" class="btn btn-secondary btn-sm" data-id="${item.id}" data-price="${item.product.price}" onclick="decQuantity(this)">-</button>
											  <button type="button" class="btn btn-secondary btn-sm"><span class="item-quantity-${item.id}">${item.getQuantity()}</span></button>
											  <button type="button" class="btn btn-secondary btn-sm" data-id="${item.id}" data-price="${item.product.price}" data-stock="${item.product.stock}" onclick="incQuantity(this)">+</button>
											</div>
	                                    </td>
	                                    <td class="shoping__cart__total">
	                                        $  <span class="item-total-${item.id}">${item.getTotal()}</span>
	                                    </td>
	                                    <td class="shoping__cart__item__close">
	                                    	<a href="remove-from-cart?id=${item.id}">
	                                        	<span class="icon_close"></span>
	                                    	</a>
	                                    </td>
	                                </tr>
                            	</c:forEach>
                                
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="shoping__checkout">
                        <h5>Cart Total</h5>
                        <ul>
                            <li>Subtotal <span>$<span class="cart-sub-total">${pageScope.total}</span></span> </li>
                            <li>Total <span>$<span class="cart-total">${pageScope.total}</span></span> </li>
                        </ul>
                        <a href="checkout.jsp" class="primary-btn">PROCEED TO CHECKOUT</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shoping Cart Section End -->
    
    <jsp:include page="comman/footer.jsp"/>

    


</body>

	<script type="text/javascript">
    	function incQuantity(event) {
    		console.log(event.dataset.id);
    		var a = document.querySelector(".item-quantity-"+event.dataset.id);
    		var subTotal = document.querySelector(".cart-sub-total");
    		var cartTotal = document.querySelector(".cart-total");
    		
    		if(Number(event.dataset.stock) > (Number(a.innerText) + 1)){
    			a.innerText = Number(a.innerText) + 1;
    			fetch("/Vegan-Cakes/update-item-quantity?id="+event.dataset.id+"&qty="+a.innerText, {})
                .then(response => response.text())
                .then((result) => {
                	console.log('result==='+result);
                	if(result == 'success'){
                		var b = document.querySelector(".item-total-"+event.dataset.id);
                		b.innerText = Number(a.innerText) * Number(event.dataset.price);
                		
                		subTotal.innerText = Number(subTotal.innerText) + Number(event.dataset.price);
                		cartTotal.innerText = Number(cartTotal.innerText) + Number(event.dataset.price);
                	}
            		
                })
                .catch((error) => {
                    console.log('error', error);
                });
    		}
    		
    		
		}
    	function decQuantity(event) {
    		console.log(event.dataset.id);
    		var a = document.querySelector(".item-quantity-"+event.dataset.id);
    		var subTotal = document.querySelector(".cart-sub-total");
    		var cartTotal = document.querySelector(".cart-total");
    		
    		if(0 < (Number(a.innerText) - 1)){
    			a.innerText = Number(a.innerText) - 1;
        		
        		fetch("/Vegan-Cakes/update-item-quantity?id="+event.dataset.id+"&qty="+a.innerText, {})
                .then(response => response.text())
                .then((result) => {
                	console.log('result==='+result);
                	
                	if(result == 'success'){
                		var b = document.querySelector(".item-total-"+event.dataset.id);
                		b.innerText = Number(a.innerText) * Number(event.dataset.price);
                		
                		subTotal.innerText = Number(subTotal.innerText) - Number(event.dataset.price);
                		cartTotal.innerText = Number(cartTotal.innerText) - Number(event.dataset.price);
                	}
                	
                })
                .catch((error) => {
                    console.log('error', error);
                });
    		}
    		
    		
		}
    </script>
    
    <!-- Js Plugins -->
    <script src="static/js/jquery-3.3.1.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/jquery.nice-select.min.js"></script>
    <script src="static/js/jquery-ui.min.js"></script>
    <script src="static/js/jquery.slicknav.js"></script>
    <script src="static/js/mixitup.min.js"></script>
    <script src="static/js/owl.carousel.min.js"></script>
    <script src="static/js/main.js"></script>

</html>