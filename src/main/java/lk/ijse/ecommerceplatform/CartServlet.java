package lk.ijse.ecommerceplatform;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.json.JsonReader;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "cart", value = "/cart")
public class CartServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JsonReader reader = Json.createReader(req.getReader());
        JsonObject jsonObject = reader.readObject();

        String action = jsonObject.getString("action");
        switch (action) {
            case "add":
                addToCart(jsonObject, resp);
                break;
            case "remove":
                removeFromCart(jsonObject, resp);
                break;
            case "update":
                updateCart(jsonObject, resp);
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

        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO cart(user_id, product_id, quantity) VALUES (?, ?, ?)");
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, productId);
            preparedStatement.setInt(3, qty);
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

    private void removeFromCart(JsonObject jsonObject, HttpServletResponse resp) {
        String userIdString = jsonObject.getString("userId", null);
        if (userIdString == null || userIdString.isEmpty()) {
            sendErrorResponse(resp, "Login first", HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int userId = Integer.parseInt(userIdString);
        int productId = Integer.parseInt(jsonObject.getString("productId"));

        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM cart WHERE user_id = ? AND product_id = ?");
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, productId);
            int i = preparedStatement.executeUpdate();

            if (i > 0) {
                sendSuccessResponse(resp, jsonObject, "Item removed from cart successfully");
            } else {
                sendErrorResponse(resp, "Failed to remove item from cart", HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            sendErrorResponse(resp, "Database error: " + e.getMessage(), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void updateCart(JsonObject jsonObject, HttpServletResponse resp) {
        String userIdString = jsonObject.getString("userId", null);
        if (userIdString == null || userIdString.isEmpty()) {
            sendErrorResponse(resp, "Login first", HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int userId = Integer.parseInt(userIdString);
        int productId = Integer.parseInt(jsonObject.getString("productId"));
        int qty = Integer.parseInt(jsonObject.getString("quantity"));

        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?");
            preparedStatement.setInt(1, qty);
            preparedStatement.setInt(2, userId);
            preparedStatement.setInt(3, productId);
            int i = preparedStatement.executeUpdate();

            if (i > 0) {
                sendSuccessResponse(resp, jsonObject, "Cart updated successfully");
            } else {
                sendErrorResponse(resp, "Failed to update cart", HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (SQLException e) {
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