<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@page import="com.vegancakes.entity.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.vegancakes.admin.control.CategoryControl"%>

<%
	if(session.getAttribute("admin") == null){
		response.sendRedirect("login.jsp");
	}

	CategoryControl uc = new CategoryControl();
	List<Category> catList = uc.getCategoryAll();
	
	pageContext.setAttribute("catList", catList);

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Category - Admin</title>
        
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
	                    <div class="d-flex justify-content-between align-items-center">
	                        <h3 class="mt-4">Manage Category</h3>
	                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Add</button>
                        </div>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active">Category</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Users
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>Name</th>
                                            <th>Action</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
	                                    <c:forEach var="cat" items="${pageScope.catList}" >
		                                    <tr>
	                                            <th>${cat.name}</th>
	                                          	<th>
	                                            	<button type="button" data-id="${cat.id}" onclick="getCategoryDetail(this)" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#categoryEditModal">
	                                            		<i class="fa-solid fa-pen"></i>
	                                            	</button>
	                                            	<a href="remove-category?id=${cat.id}" type="button" class="btn btn-danger btn-sm">
	                                            		<i class="fa-solid fa-trash"></i>
	                                            	</a>
	                                            </th>
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
        
       
        <!-- Add Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <form class="modal-content" method="post" action="add-category" enctype="multipart/form-data">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Add New Category </h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
				  <div class="form-group">
				    <label for="name">Name</label>
				    <input type="text" class="form-control" name="name"  id="name" placeholder="Enter Name" required>
				  </div>
				  <div class="form-group">
				    <label for="cat-image">Category Image</label>
				    <input type="file" class="form-control-file" id="cat-image" name="cat-image" >
				  </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" name="submit" class="btn btn-primary">Save</button>
		      </div>
		    </form>
		  </div>
		</div>
		
		<!-- Edit Modal -->
		<div class="modal fade" id="categoryEditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <form class="modal-content" method="post" action="update-category" enctype="multipart/form-data">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Edit Category </h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
 				  <input type="hidden" name="id" id="edit-id" >
 				  <input type="hidden" name="old-path" id="edit-path" >
		      
				  <div class="form-group">
				    <label for="name">Name</label>
				    <input type="text" class="form-control" name="name"  id="edit-name" placeholder="Enter Name" required>
				  </div>
				  
				  <div class="form-group">
				    <label for="cat-image">Category Image</label>
				    <input type="file" class="form-control-file" id="cat-image" name="cat-image" >
				  </div>
				  
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" name="submit" class="btn btn-primary">Update</button>
		      </div>
		    </form>
		  </div>
		</div>
        
    </body>
    
    <script type="text/javascript">
    	async function getCategoryDetail(event) {
    		
    		console.log(event.dataset.id);
    		fetch("/Vegan-Cakes/admin/get-category-detail?id="+event.dataset.id, {})
            .then(response => response.text())
            .then((result) => {
                result = JSON.parse(result);
                console.log('result',result);
                
                var id = document.querySelector("#edit-id");
                var name = document.querySelector("#edit-name");
                var oldPath = document.querySelector("#edit-path");
                
                id.value = result.id;
                name.value = result.name;
                oldPath.value = result.path;
                
                console.log(id);
                
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
