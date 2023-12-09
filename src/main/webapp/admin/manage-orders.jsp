<%@page import="com.vegancakes.entity.Order"%>
<%@page import="com.vegancakes.customer.control.OrderControl"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@page import="java.util.List"%>


<%
	if(session.getAttribute("admin") == null){
		response.sendRedirect("login.jsp");
	}

	OrderControl uc = new OrderControl();
	List<Order> orderList = uc.getOrderAll();
	
	pageContext.setAttribute("orderList", orderList);
	
	//out.print(session.getAttribute("orderDetail"));

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Orders - Admin</title>
        
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        
        
        
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../static/css/styles-admin.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
    	<jsp:include page="../comman/admin-header.jsp"/>
        <!-- Header -->
        <div id="layoutSidenav">
            <!-- Side bar -->
             <jsp:include page="../comman/admin-sidebar.jsp"/>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h3 class="mt-4">Manage Order</h3>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active">Orders</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Orders
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>Id</th>
                                            <th>Total</th>
                                            <th>Payment</th>
                                            <th>Items</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>Id</th>
                                            <th>Total</th>
                                            <th>Payment</th>
                                            <th>Items</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    
                                    	<c:forEach var="order" items="${pageScope.orderList}" >
	                                        <tr>
	                                            <td>${order.id}</td>
	                                            <td>${order.total}</td>
	                                            <td>${order.paymentId}</td>
	                                            <td>${order.getOrderItem().size()}</td>
	                                            <td>${order.status}</td>
	                                            <td>
		                                            <a href="" data-id="${order.id}" type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#viewOrderModal" onclick="orderDetail(this)">
                                        				<i class="fa-solid fa-eye"></i>
	                                            	</a>
	                                            	<c:if test="${order.status == 'Pending'}">
		                                            	<a href="deliver-order?id=${order.id}" type="button" class="btn btn-success btn-sm">
		                                            		Deliverd
		                                            	</a>
	                                            	</c:if>
	                                            	<c:if test="${order.status == 'Deliverd'}">
		                                            	Deliverd
	                                            	</c:if>
	                                            	
	                                            </td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        
        <!-- View Order Modal -->
		<div class="modal fade" id="viewOrderModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">  View Order</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
	        	<div class="row">
	        		<div  class="col-lg-12"> 
	        			<div class="row">
                       		<div class="col-6">Firstname : <span class="user-fname"></span> </div>
                       		<div class="col-6 ">Lastname : <span class="user-lname"></span> </div>
                       		<div class="col-6 ">Email : <span class="user-email"></span> </div>
                       		<div class="col-6">Mobile : <span class="user-mobile"></span> </div>
                       	</div>
                       	<div class="row">
                       		<div class="col-6 "> Address 1 : <span class="user-line1"></span> </div>
                       		<div class="col-6"> Address 2 : <span class="user-line2"></span> </div>
                       		<div class="col-6 "> City : <span class="user-city"></span> </div>
                       		<div class="col-6"> Country : <span class="user-country"></span> </div>
                       		<div class="col-6 "> Pin : <span class="user-pin"></span> </div>
                       		<div class="col-6 "> Phone : <span class="user-phone"></span> </div>
                       		
                       	</div>
	        		</div>
			        <div class="col-12">
			        	<h6 class="my-2">Order Items :</h6>
			        	<div class="row product-list">
					        <!-- <div class="col-4">
					        	<img class="product-img" alt="" src="" width="55">
					        </div>
					        <div class="col-4">
					        	<span class="product-name">Tesing puspose</span>
					        </div>
					        <div class="col-4">
					        	<span class="product-price">$120</span>
					        </div> -->
					    </div>
			        </div>
			      </div>
		      </div>

		    </div>
		  </div>
		</div>
        
    </body>
    
    <script type="text/javascript">
    

    	function orderDetail(event){
    		
    		const productContainer = document.querySelector('.product-list');
    		productContainer.innerHTML = ''; 
    		
    		fetch("/Vegan-Cakes/admin/get-order-detail?id="+event.dataset.id, {})
            .then(response => response.text())
            .then((result) => {

                console.log('result',result);
             // Update user details
             var jsonData = JSON.parse(result);
                document.querySelector('.user-fname').textContent = jsonData.user.firstName;
                document.querySelector('.user-lname').textContent = jsonData.user.lastName;
                document.querySelector('.user-email').textContent = jsonData.user.email;
                document.querySelector('.user-mobile').textContent = jsonData.user.mobile;
                document.querySelector('.user-line1').textContent = jsonData.user.address.line1; // Update with user address details
                document.querySelector('.user-line2').textContent = jsonData.user.address.line2; // Update with user address details
                document.querySelector('.user-city').textContent = jsonData.user.address.city; // Update with user address details
                document.querySelector('.user-country').textContent = jsonData.user.address.country; // Update with user address details
                document.querySelector('.user-pin').textContent = jsonData.user.address.pin; // Update with user address details
                document.querySelector('.user-phone').textContent = jsonData.user.address.phone; // Update with user address details

                // Update product details
                const productContainer = document.querySelector('.product-list');
                jsonData.orderItems.forEach(item => {
                  const productDiv = document.createElement('div');
                  productDiv.classList.add('row');
                  productDiv.classList.add('my-1');

                  const imgDiv = document.createElement('div');
                  imgDiv.classList.add('col-2');

                  const img = document.createElement('img');
                  img.classList.add('product-img');
                  img.src = "/Vegan-Cakes/assets/products/" + item.product.path; // Assuming 'path' contains the image URL
                  img.alt = item.product.name;
                  img.width = '55';
                  imgDiv.appendChild(img);

                  const nameDiv = document.createElement('div');
                  nameDiv.classList.add('col-6');
                  nameDiv.textContent = item.product.name;

                  const priceDiv = document.createElement('div');
                  priceDiv.classList.add('col-4');
                  priceDiv.textContent = '$'+ item.product.price;

                  productDiv.appendChild(imgDiv);
                  productDiv.appendChild(nameDiv);
                  productDiv.appendChild(priceDiv);
                  productContainer.appendChild(productDiv);
                }); 
            })
            .catch((error) => {
                
                console.log('error', error);
                
            });    		
    	}

    </script>
    
    	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	   
	   
    	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../static/js/scripts-admin.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="../static/js/datatables-simple-demo.js"></script>
</html>
