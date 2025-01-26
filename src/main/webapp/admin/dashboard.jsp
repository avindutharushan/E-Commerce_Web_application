<%--
  Created by IntelliJ IDEA.
  User: shan
  Date: 1/26/25
  Time: 6:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meduza Store Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <!-- Font Awesome -->
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            rel="stylesheet"
    />
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
            transform: translateY(-5px);
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
                <img
                        src="../assets/images/logo.png"
                        alt="Logo"
                        class="img-fluid bg-white rounded-circle mb-3"
                        style="width: 80px"
                />
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
                    <li class="nav-item">
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
                        <a class="nav-link " href="../admin/category.jsp">
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
            <div
                    class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom"
            >
                <h1>Dashboard</h1>
            </div>

            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div
                            class="card border-left-primary shadow h-100 py-2 card-dashboard"
                    >
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div
                                            class="text-xs font-weight-bold text-primary text-uppercase mb-1"
                                    >
                                        Total Sales
                                    </div>
                                    <div id="order" class="h5 mb-0 font-weight-bold text-gray-800">

                                    </div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div
                            class="card border-left-success shadow h-100 py-2 card-dashboard"
                    >
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div
                                              class="text-xs font-weight-bold text-success text-uppercase mb-1"
                                    >
                                        Orders
                                    </div>
                                    <div id="order1" class="h5 mb-0 font-weight-bold text-gray-800">
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-shopping-bag fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div
                            class="card border-left-info shadow h-100 py-2 card-dashboard"
                    >
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div
                                            class="text-xs font-weight-bold text-info text-uppercase mb-1"
                                    >
                                        Products
                                    </div>
                                    <div id="product" class="h5 mb-0 font-weight-bold text-gray-800">
                                     </div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-tshirt fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div
                            class="card border-left-warning shadow h-100 py-2 card-dashboard"
                    >
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div
                                            class="text-xs font-weight-bold text-warning text-uppercase mb-1"
                                    >
                                        Customers
                                    </div>
                                    <div id="cus" class="h5 mb-0 font-weight-bold text-gray-800">

                                    </div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-users fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Orders Table -->
            <div class="card shadow mb-4">
                <div
                        class="card-header py-3 d-flex justify-content-between align-items-center"
                >
                    <h6 class="m-0 font-weight-bold text-primary">Meduza</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <img src="../assets/images/ALMZV.jpeg" class="w-100">
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="../js/jquery-3.7.1.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        $.ajax({
            url: "http://localhost:8080/Meduza/dashboard",
            type: "GET",
            success: function (res){
                $("#product").append(res.data[1])
                $("#order").append(res.data[0])
                $("#order1").append(res.data[0])
                $("#cus").append(res.data[2])

            }

        });
    });
</script>
</body>
</html>

