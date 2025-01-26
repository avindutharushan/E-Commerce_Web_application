package lk.ijse.ecommerceplatform;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerceplatform.dto.CartDTO2;
import lk.ijse.ecommerceplatform.dto.ProductDTO;

import javax.json.*;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "cart", value = "/cart")
public class CartServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userIdString = req.getParameter("user");

        if (userIdString == null || userIdString.isEmpty() || userIdString.equals("null")) {
            resp.sendRedirect("pages/login.jsp?error=Please login first");
            return;
        }
        try {
            Connection connection = dataSource.getConnection();
            if (connection == null) {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database connection error.");
                return;
            }

            ResultSet resultSet = connection.prepareStatement("SELECT * FROM cart where user_id = '"+req.getParameter("user")+"'").executeQuery();
            ArrayList<CartDTO2> list = new ArrayList<>();
            while (resultSet.next()){
                int cart_id = resultSet.getInt(1);
                int user_id = resultSet.getInt(2);
                int product_id = resultSet.getInt(3);
                int quantity = resultSet.getInt(4);
                String image_url = resultSet.getString(5);

                ResultSet resultSet1 = connection.prepareStatement("SELECT * from products where product_id = '" + product_id + "'").executeQuery();

                if (resultSet1.next()){
                    String name = resultSet1.getString(3);
                    String description = resultSet1.getString(4);
                    double price = resultSet1.getDouble(5);

                    ProductDTO productDTO = new ProductDTO(name, description, price);
                    list.add(new CartDTO2(cart_id, user_id, product_id, quantity, image_url, productDTO));
                }


            }
            if (list.isEmpty()){
                resp.sendRedirect("pages/cart.jsp?error=empty cart");
                return;
            }
            req.setAttribute("products", list);
            req.getRequestDispatcher("pages/cart.jsp").forward(req, resp);

            connection.close();
        }catch (Exception e){
            e.printStackTrace();
            resp.sendRedirect("cart.jsp?error=empty cart");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        JsonObject jsonObject = null;
        if (action == null || action.isEmpty() || action.equals("null")) {
             jsonObject = Json.createReader(req.getReader()).readObject();
             action = jsonObject.getString("action");
        }
        switch (action) {
            case "add":
                addToCart(jsonObject, resp);
                break;
            case "remove":
                removeFromCart(req, resp);
                break;
            case "update":
                updateCart(req, resp);
                break;
            default:
                sendErrorResponse(resp, "Invalid action", HttpServletResponse.SC_BAD_REQUEST);
                break;
        }
    }

    private void addToCart(JsonObject jsonObject, HttpServletResponse resp) {
        String userIdString = jsonObject.getString("userId");

        if (userIdString == null || userIdString.isEmpty() || userIdString.equals("null")) {
            sendErrorResponse(resp, "Login first", HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int userId = Integer.parseInt(userIdString);
        int productId = Integer.parseInt(jsonObject.getString("productId"));
        int qty = Integer.parseInt(jsonObject.getString("quantity"));
        String image_url = jsonObject.getString("image_url");

        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO cart(user_id, product_id, quantity,image_url) VALUES (?, ?, ? ,?)");
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, productId);
            preparedStatement.setInt(3, qty);
            preparedStatement.setString(4, image_url);
            int i = preparedStatement.executeUpdate();

            if (i > 0) {
                sendSuccessResponse(resp, jsonObject, "Item added to cart successfully");
            } else {
                sendErrorResponse(resp, "Failed to add item to cart", HttpServletResponse.SC_BAD_REQUEST);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            sendErrorResponse(resp, "Database error: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void removeFromCart(HttpServletRequest req, HttpServletResponse resp) {
        int userId = Integer.parseInt(req.getParameter("user"));
        int productId = Integer.parseInt(req.getParameter("product"));
        int cartId = Integer.parseInt(req.getParameter("cart"));

        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM cart WHERE user_id = ? AND product_id = ? AND cart_id = ?");
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, productId);
            preparedStatement.setInt(3, cartId);
            int i = preparedStatement.executeUpdate();

            if (i > 0) {
                resp.sendRedirect("cart?user=" + userId);
            } else {
                sendErrorResponse(resp, "Failed to remove item from cart", HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
            sendErrorResponse(resp, "Database error: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void updateCart(HttpServletRequest req, HttpServletResponse resp) {
        int userId = Integer.parseInt(req.getParameter("user"));
        int productId = Integer.parseInt(req.getParameter("product"));
        int cartId = Integer.parseInt(req.getParameter("cart"));
        int qtyChange = Integer.parseInt(req.getParameter("quantity"));

        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement getCurrentQtyStmt = connection.prepareStatement("SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?");
            getCurrentQtyStmt.setInt(1, userId);
            getCurrentQtyStmt.setInt(2, productId);
            ResultSet resultSet = getCurrentQtyStmt.executeQuery();

            if (resultSet.next()) {
                int currentQty = resultSet.getInt("quantity");
                int newQty = currentQty + qtyChange;

                if (newQty < 0) {
                    newQty = 0;
                }

                PreparedStatement updateStmt = connection.prepareStatement("UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?");
                updateStmt.setInt(1, newQty);
                updateStmt.setInt(2, userId);
                updateStmt.setInt(3, productId);
                int i = updateStmt.executeUpdate();

                if (i > 0) {
                    resp.sendRedirect("cart?user=" + userId);
                } else {
                    sendErrorResponse(resp, "Failed to update cart", HttpServletResponse.SC_BAD_REQUEST);
                }
            } else {
                sendErrorResponse(resp, "Product not found in cart", HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
            sendErrorResponse(resp, "Database error: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void sendSuccessResponse(HttpServletResponse resp, JsonObject jsonObject, String message) {
        JsonObjectBuilder response = Json.createObjectBuilder();
        response.add("data", jsonObject);
        response.add("status", HttpServletResponse.SC_OK);
        response.add("message", message);
        resp.setStatus(HttpServletResponse.SC_OK);
        resp.setContentType("application/json");
        try {
            resp.getWriter().print(response.build());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void sendErrorResponse(HttpServletResponse resp, String message, int statusCode){
        JsonObjectBuilder response = Json.createObjectBuilder();
        response.add("data", "");
        response.add("status", statusCode);
        response.add("message", message);
        resp.setStatus(statusCode);
        resp.setContentType("application/json");
        try {
            resp.getWriter().print(response.build());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}