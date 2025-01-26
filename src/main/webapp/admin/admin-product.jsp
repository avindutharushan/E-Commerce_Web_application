<%@ page import="lk.ijse.ecommerceplatform.dto.ProductDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: shan
  Date: 1/26/25
  Time: 6:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meduza Products</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #343a40;
        }
        .nav-link {
            border-radius: 20px;
            color: #fff;
        }
        .nav-link:hover {
            background-color: #495057;
        }
        .card-dashboard {
            transition: transform 0.2s;
        }
        .card-dashboard:hover {
            transform: translateY(-5px );
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 d-none d-md-block sidebar p-3">
            <div class="text-center mb-4">
                <img src="/assets/images/logo.png" alt="Logo" class="img-fluid bg-white rounded-circle mb-3" style="width: 80px" />
                <h5 class="text-white">Meduza</h5>
            </div>
            <div class="position-sticky d-flex justify-content-center">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#dashboard">
                            <i class="fas fa-tachometer-alt me-2"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#products">
                            <i class="fas fa-tshirt me-2"></i>
                            Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#orders">
                            <i class="fas fa-shopping-cart me-2"></i>
                            Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#customers">
                            <i class="fas fa-users me-2"></i>
                            Customers
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#reports">
                            <i class="fas fa-chart-bar me-2"></i>
                            Reports
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#settings">
                            <i class="fas fa-cog me-2"></i>
                            Settings
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="col-md-10 ms-sm-auto px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1>Products</h1>
                <button class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Add New Product
                </button>
            </div>

            <!-- Product Cards Grid -->
            <div class="row">
                <%
                    List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
                    for (ProductDTO product : products) {
                %>
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <img src="<%= product.getImage_url() %>" class="card-img-top" alt="<%= product.getName() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.getName() %></h5>
                            <p class="card-text"><%= product.getDescription() %></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="h5 mb-0">$<%= product.getPrice() %></span>
                                <span class="badge bg="<%= product.getQuantity() > 0 ? "success" : "danger" %>">
                                <%= product.getQuantity() > 0 ? "In Stock" : "Out of Stock" %>
                                </span>
                            </div>
                        </div>
                        <div class="card-footer bg-white border-top-0">
                            <div class="btn-group w-100">
                                <button class="btn btn-outline-primary">Edit</button>
                                <button class="btn btn-outline-danger">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </main>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
