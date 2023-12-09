<%@page import="com.vegancakes.entity.Cart"%>
<%@page import="java.util.List"%>
<%@page import="com.vegancakes.customer.control.CartControl"%>
<%@page import="com.vegancakes.entity.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
                        <h2>Checkout</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.jsp">Home</a>
                            <span>Checkout</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                <h4>Billing Details</h4>
                <form action="create-cart-order" method="post">
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                        	<div class="row">
                        		<div class="col-lg-12">
                        			<div class="checkout__input">
		                                <p>Card Number<span>*</span></p>
		                                <input type="text" name="card-number" value="" placeholder="0000-0000-0000-0000">
		                            </div>
                        		</div>
                        		<div class="col-lg-6">
                        			<div class="checkout__input">
		                                <p>CVV<span>*</span></p>
		                                <input type="text" name="cvv" value="" placeholder="0000">
		                            </div>
                        		</div>
                        		<div class="col-lg-6">
                        			<div class="checkout__input">
		                                <p>Expiry Date<span>*</span></p>
		                                <input type="text" name="date" value="" placeholder="00/00">
		                            </div>
                        		</div>
                        	</div>
                        	<div class="row">
                        	
                        		<div class="col-lg-6 my-2">Firstname : <span>${customer.firstName}</span> </div>
                        		<div class="col-lg-6 my-2">Lastname : <span>${customer.lastName}</span> </div>
                        		<div class="col-lg-6 my-2">Email : <span>${customer.email}</span> </div>
                        		<div class="col-lg-6 my-2">Mobile : <span>${customer.mobile}</span> </div>
                        	</div>
                        	<div class="row">
                        		<div class="col-lg-12 my-2"> Address 1 : <span>${customer.getAddress().getLine1()}</span> </div>
                        		<div class="col-lg-12 my-2"> Address 2 : <span>${customer.getAddress().getLine2()}</span> </div>
                        		<div class="col-lg-12 my-2"> City : <span>${customer.getAddress().getCity()}</span> </div>
                        		<div class="col-lg-12 my-2"> Country : <span>${customer.getAddress().getCountry()}</span> </div>
                        		<div class="col-lg-12 my-2"> Pin : <span>${customer.getAddress().getPin()}</span> </div>
                        		<div class="col-lg-12 my-2"> Phone : <span>${customer.getAddress().getPhone()}</span> </div>
                        		
                        	</div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="checkout__order">
                                <h4>Your Order</h4>
                                <div class="checkout__order__products">Products <span>Total</span></div>
                                <ul>
	                                <c:forEach items="${pageScope.cartList}" var="item" >
	                                    <li>${item.product.name} <span>$${item.getTotal()}</span></li>
                                    </c:forEach>
                                </ul>
                                <div class="checkout__order__subtotal">Subtotal <span>$${pageScope.total}</span></div>
                                <div class="checkout__order__total">Total <span>$${pageScope.total}</span></div>
                                <button type="submit" class="site-btn">PLACE ORDER</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->
    
    <jsp:include page="comman/footer.jsp"/>

    <!-- Js Plugins -->
    <script src="static/js/jquery-3.3.1.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/jquery.nice-select.min.js"></script>
    <script src="static/js/jquery-ui.min.js"></script>
    <script src="static/js/jquery.slicknav.js"></script>
    <script src="static/js/mixitup.min.js"></script>
    <script src="static/js/owl.carousel.min.js"></script>
    <script src="static/js/main.js"></script>

 

</body>

</html>