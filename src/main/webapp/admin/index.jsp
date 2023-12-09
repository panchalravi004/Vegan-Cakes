
<%@page import="com.vegancakes.entity.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.vegancakes.customer.control.OrderControl"%>
<%@page import="com.vegancakes.admin.control.CategoryControl"%>
<%@page import="com.vegancakes.admin.control.ProductControl"%>
<%
	if(session.getAttribute("admin") == null){
		response.sendRedirect("login.jsp");
	}

	ProductControl uc = new ProductControl();
	CategoryControl cc = new CategoryControl();
	OrderControl oc = new OrderControl();
	
	int totalProduct = uc.getProductAll().size();
	int totalCat = cc.getCategoryAll().size();
	List<Order> orders = oc.getOrderAll();

	int totalOrder = orders.size();
	int totalSale = 0;
	
	for(Order order : orders){
		totalSale += order.getTotal();
	}
	
	
	pageContext.setAttribute("totalProduct", totalProduct);
	pageContext.setAttribute("totalCat", totalCat);
	pageContext.setAttribute("totalOrder", totalOrder);
	pageContext.setAttribute("totalSale", totalSale);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../static/css/styles-admin.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
    
    	<jsp:include page="../comman/admin-header.jsp"/>
        <!-- Header -->
        <div id="layoutSidenav">
            <!-- Side nav bar -->
            <jsp:include page="../comman/admin-sidebar.jsp"/>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">Total Product</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        ${pageScope.totalProduct}
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body">Total Category</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        ${pageScope.totalCat}
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div class="card-body">Total Orders</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        ${pageScope.totalOrder}
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                    <div class="card-body">Total Sale</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                       $ ${pageScope.totalSale}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        
        
        
        <script src="../static/js/scripts-admin.js"></script>
        <script src="../static/assets/demo/chart-area-demo.js"></script>
        <script src="../static/assets/demo/chart-bar-demo.js"></script>
        <script src="../static/js/datatables-simple-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    </body>
</html>
