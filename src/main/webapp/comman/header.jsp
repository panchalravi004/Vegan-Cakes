<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="com.vegancakes.entity.Cart"%>
<%@page import="com.vegancakes.entity.Customer"%>
<%@page import="com.vegancakes.customer.control.CartControl"%>
<%@page import="java.util.List"%>
<%

	Customer o = (Customer) session.getAttribute("customer");
	
	if(o != null){
		
		/* out.println(o.getId());*/
		 
		CartControl uc = new CartControl();
		List<Cart> cartList = uc.getCartAll(o.getId());
		
		int total = 0;
		
		for(Cart c : cartList){
			total += c.getQuantity() * c.getProduct().getPrice();
		}
		
		pageContext.setAttribute("cartSize", cartList.size());
		pageContext.setAttribute("total", total);
		
	}
	

%>
<!-- Humberger Begin -->
<div class="humberger__menu__overlay"></div>
<div class="humberger__menu__wrapper">
    <div class="humberger__menu__logo">
        <!-- <a href="#"><img src="img/logo.png" alt=""></a> -->
        <h3>Vegan Cakes</h3>
    </div>
    <div class="humberger__menu__cart">
        <ul>
            <li><a href="shoping-cart.jsp"><i class="fa fa-shopping-bag"></i> <span>${pageScope.cartSize}</span></a></li>
        </ul>
        <div class="header__cart__price">item: <span>$${pageScope.total}</span></div>
    </div>
    <div class="humberger__menu__widget">
	    <c:if test="${sessionScope.customer == null}">
	        <div class="header__top__right__auth">
	            <a href="login.jsp"><i class="fa fa-user"></i> Login</a>
	        </div>
        </c:if>
    </div>
    <nav class="humberger__menu__nav mobile-menu">
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="./shop-grid.html">Shop</a></li>
            <c:if test="${sessionScope.customer != null}">
	            <li><a href="#">Profile</a>
	                <ul class="header__menu__dropdown">
	                    <li><a href="#">${customer.firstName} Profile</a></li>
	                    <li><a href="shoping-cart.jsp">Shoping Cart</a></li>
	                    <li><a href="shoping-order.jsp">Orders</a></li>
	                    <li><a href="logout">Logout</a></li>
	                </ul>
	            </li>
            </c:if>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>
    </nav>
    <div id="mobile-menu-wrap"></div>
    <div class="humberger__menu__contact">
        <ul>
            <li><i class="fa fa-envelope"></i> hello@colorlib.com</li>
        </ul>
    </div>
</div>
<!-- Humberger End -->

<!-- Header Section Begin -->
<header class="header">
    <div class="header__top">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="header__top__left">
                        <ul>
                            <li><i class="fa fa-envelope"></i> hello@colorlib.com</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="header__top__right">
	                    <c:if test="${sessionScope.customer == null}">
	                        <div class="header__top__right__auth">
	                            <a href="login.jsp"><i class="fa fa-user"></i> Login</a>
	                        </div>
                        </c:if>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="header__logo">
                    <!-- <a href="./index.html"><img src="img/logo.png" alt=""></a> -->
                    <h3>Vegan Cakes</h3>
                </div>
            </div>
            <div class="col-lg-6">
                <nav class="header__menu">
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="shop-grid.jsp">Shop</a></li>
                        
	                        <li>
	                        <c:if test="${sessionScope.customer != null}">
	                        	<a href="#">Profile</a>
	                            <ul class="header__menu__dropdown">
	                                <li><a href="profile.jsp">${customer.firstName} Profile</a></li>
	                                <li><a href="shoping-cart.jsp">Shoping Cart</a></li>
	                                <li><a href="shoping-order.jsp">Orders</a></li>
	                                <li><a href="logout">Logout</a></li>
	                            </ul>
	                            </c:if>
	                        </li>
                        
                        
                        <li><a href="contact.jsp">Contact</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-lg-3">
                <div class="header__cart">
                    <ul>
                        <li><a href="shoping-cart.jsp"><i class="fa fa-shopping-bag"></i> <span>${pageScope.cartSize}</span></a></li>
                    </ul>
                    <div class="header__cart__price">item: <span>$${pageScope.total}</span></div>
                </div>
            </div>
        </div>
        <div class="humberger__open">
            <i class="fa fa-bars"></i>
        </div>
    </div>
</header>
<!-- Header Section End -->

<!-- Hero Section Begin -->
<section class="hero">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 d-flex justify-content-center">
                <div class="hero__search">
                    <div class="hero__search__form">
                        <form action="#">
                            <input type="text" placeholder="What do yo u need?">
                            <button type="submit" class="site-btn">SEARCH</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Hero Section End -->