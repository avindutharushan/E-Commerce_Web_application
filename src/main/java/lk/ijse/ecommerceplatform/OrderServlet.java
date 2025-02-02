package lk.ijse.ecommerceplatform;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerceplatform.dto.OrderDetailDTO;
import lk.ijse.ecommerceplatform.dto.OrderDetailDTO2;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "order", value = "/order")
public class OrderServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("user"));
        String shippingAddress = req.getParameter("address");
        Connection connection = null;
        try {
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try  {
            connection.setAutoCommit(false);

            // Retrieve cart items for the user
            String cartQuery = "SELECT product_id, quantity FROM cart WHERE user_id = ?";
            PreparedStatement cartStmt = connection.prepareStatement(cartQuery);
            cartStmt.setInt(1, userId);
            ResultSet cartResult = cartStmt.executeQuery();

            double totalAmount = 0;
            List<OrderDetailDTO2> orderDetails = new ArrayList<>();

            while (cartResult.next()) {
                int productId = cartResult.getInt("product_id");
                int quantity = cartResult.getInt("quantity");

                // Get product price
                String productQuery = "SELECT price, name FROM products WHERE product_id = ?";
                PreparedStatement productStmt = connection.prepareStatement(productQuery);
                productStmt.setInt(1, productId);
                ResultSet productResult = productStmt.executeQuery();

                if (productResult.next()) {
                    double price = productResult.getDouble("price");
                    String name = productResult.getString("name");
                    double total = price * quantity;
                    totalAmount += total;

                    orderDetails.add(new OrderDetailDTO2(productId, name, quantity, price));
                }
            }

            // Create the order
            String orderQuery = "INSERT INTO orders (user_id, total_amount, status, shipping_address) VALUES (?, ?, 'PENDING', ?)";
            PreparedStatement orderStmt = connection.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, totalAmount);
            orderStmt.setString(3, shippingAddress);
            orderStmt.executeUpdate();

            // Get the generated order ID
            ResultSet generatedKeys = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            //  Insert order details
            String orderDetailQuery = "INSERT INTO order_details (order_id, product_id, quantity, price_at_time) VALUES (?, ?, ?, ?)";
            PreparedStatement orderDetailStmt = connection.prepareStatement(orderDetailQuery);

            for (OrderDetailDTO2 detail : orderDetails) {
                orderDetailStmt.setInt(1, orderId);
                orderDetailStmt.setInt(2, detail.getProductId());
                orderDetailStmt.setInt(3, detail.getQuantity());
                orderDetailStmt.setDouble(4, detail.getPrice());
                orderDetailStmt.executeUpdate();
            }

            // Clear the cart
            String clearCartQuery = "DELETE FROM cart WHERE user_id = ?";
            PreparedStatement clearCartStmt = connection.prepareStatement(clearCartQuery);
            clearCartStmt.setInt(1, userId);
            clearCartStmt.executeUpdate();

            connection.commit();

            req.setAttribute("orderDetails", orderDetails);
            req.getRequestDispatcher("pages/orderSuccess.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            resp.sendRedirect("cart.jsp?error=order not placed");
        }
    }
}
