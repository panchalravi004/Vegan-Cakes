<%@page import="com.vegancakes.entity.Order"%>
<%@page import="com.vegancakes.customer.control.OrderControl"%>
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
		 
		OrderControl uc = new OrderControl();
		List<Order> orderList = uc.getOrderAllCurrentUser(o.getId());
		
		pageContext.setAttribute("orderList", orderList);
		
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
    <title>Vegan Cakes - Orders</title>

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
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    
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
                        <h2>Shopping Orders</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.jsp">Home</a>
                            <span>Shopping Orders</span>
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
        	<h4 class="my-2">Order Items :</h4>
            <div class="row">
                <div class="col-lg-12 border p-2">
                    <c:forEach items="${pageScope.orderList}" var="item" >
                    		<div class="my-2 py-1 row" data-toggle="collapse" data-target="#collapseExample-${item.id}" aria-expanded="false" aria-controls="collapseExample-${item.id}">
							   
	                               	<div class="col-4">
	                               		<i class="fa-solid fa-eye mx-2"></i> Total Items : ${item.getOrderItem().size()} 
	                               	</div>
	                               	<div class="col-4">
	                               		${item.status} 
	                               	</div>
	                               	<div class="col-4">
	                               		$ ${item.total}
	                               	</div>
                             </div>
							<div class="collapse" id="collapseExample-${item.id}">
							  <div class="card card-body">
							    	<div class="row">
		                               	<div class="col-12">
		                                	<c:forEach items="${item.getOrderItem()}" var="item" >
			                                  <div class="row my-1">
			                                  	<div class="col"> <img src="/Vegan-Cakes/assets/products/${item.getProduct().getPath()}" width="40"> </div>
			                                  	<div class="col"> ${item.getProduct().getName() }</div>
			                                  	<div class="col">$${item.getProduct().getPrice() }</div>
			                                  	<div class="col"> ${item.quantity }</div>
			                                  	
			                                 	</div>
		                                 </c:forEach>
		                               	</div>
		                              </div>
							  </div>
							</div>
                   	</c:forEach>
                </div>
            </div>
        </div>
    </section>
    <!-- Shoping Cart Section End -->
    
    <jsp:include page="comman/footer.jsp"/>

    


</body>
    
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