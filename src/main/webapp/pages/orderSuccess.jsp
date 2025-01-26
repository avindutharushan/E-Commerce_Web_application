<%@ page import="lk.ijse.ecommerceplatform.dto.OrderDetailDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.ecommerceplatform.dto.OrderDetailDTO2" %><%--
  Created by IntelliJ IDEA.
  User: shan
  Date: 1/26/25
  Time: 12:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Order Success - Meduza</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
  <style>
    body {
      background-color: #f8f9fa;
    }
    .success-container {
      max-width: 600px;
      margin: 5rem auto;
      padding: 2rem;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .success-icon {
      font-size: 5rem;
      color: #28a745;
    }
    .order-details {
      margin-top: 2rem;
    }
    .order-details th, .order-details td {
      text-align: center;
    }
  </style>
</head>
<body>

<div class="success-container text-center">
  <i class="bi bi-check-circle success-icon"></i>
  <h1 class="mt-4">Order Placed Successfully!</h1>
  <p class="lead">Thank you for your order! Your order has been successfully placed and is being processed.</p>

  <h5 class="mt-4">Order Summary</h5>
  <table class="table table-bordered order-details">
    <thead>
    <tr>
      <th>Product</th>
      <th>Quantity</th>
      <th>Price</th>
    </tr>
    </thead>
    <tbody>
    <%
      // Example data, replace with actual order details from the session or request
      List<OrderDetailDTO2> orderDetails = (List<OrderDetailDTO2>) request.getAttribute("orderDetails");
      double totalAmount = 0;

      for (OrderDetailDTO2 detail : orderDetails) {
        double price = detail.getPrice();
        totalAmount += price * detail.getQuantity();
    %>
    <tr>
      <td><%= detail.getName() %></td>
      <td><%= detail.getQuantity() %></td>
      <td>$<%= String.format("%.2f", price) %></td>
    </tr>
    <% } %>
    </tbody>
  </table>

  <div class="mt-4">
    <h5>Total Amount: $<%= String.format("%.2f", totalAmount) %></h5>
  </div>

  <div class="mt-4">
    <a href="index.jsp" class="btn btn-success">Continue Shopping</a>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
