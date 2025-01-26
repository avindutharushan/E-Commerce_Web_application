<%@ page import="lk.ijse.ecommerceplatform.dto.OrderDetailDTO2" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.ecommerceplatform.dto.OrderDTO" %><%--
  Created by IntelliJ IDEA.
  User: shan
  Date: 1/26/25
  Time: 7:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meduza Orders</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
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
        .active{
            background-color: #495057;
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
                        <a class="nav-link active" href="dashboard">
                            <i class="fas fa-tachometer-alt me-2"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin-product">
                            <i class="fas fa-tshirt me-2"></i>
                            Products
                        </a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="order">
                            <i class="fas fa-shopping-cart me-2"></i>
                            Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="user?action=customer">
                            <i class="fas fa-users me-2"></i>
                            Customers
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " href="category.jsp">
                            <i class="fas fa-tags me-2"></i>
                            Categories
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
                <h1>Orders</h1>
            </div>

            <!-- Orders Table -->
            <div class="card shadow mb-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Products</th>
                                <th>Total</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                List<OrderDTO> orders = (List<OrderDTO>) request.getAttribute("orders");
                                for (OrderDTO order : orders) {
                            %>
                            <tr>
                                <td>#<%= order.getOrderId() %></td>
                                <td><%= order.getUserName() %></td>
                                <td>$<%= order.getTotal() %></td>
                                <select class="form-select form-select-sm">
                                    <option <%= order.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                                    <option <%= order.getStatus().equals("Processing") ? "selected" : "" %>>Processing</option>
                                    <option <%= order.getStatus().equals("Shipped") ? "selected" : "" %>>Shipped</option>
                                    <option <%= order.getStatus().equals("Delivered") ? "selected" : "" %>>Delivered</option>
                                </select>
                            </td>
                                <td>
                                    <div class="btn-group">
                                        <button class="btn btn-sm btn-info">View</button>
                                        <button class="btn btn-sm btn-danger">Cancel</button>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
