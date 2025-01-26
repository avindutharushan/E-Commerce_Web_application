package lk.ijse.ecommerceplatform;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

@WebServlet(name = "dashboard", value = "/dashboard")
public class DashbordServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("sdfgghj");
        try (Connection connection = dataSource.getConnection()) {
            String ordersCountQuery = "SELECT COUNT(*) AS total FROM orders";
            PreparedStatement ordersStmt = connection.prepareStatement(ordersCountQuery);
            ResultSet ordersResult = ordersStmt.executeQuery();
            String totalOrders = null;
            if (ordersResult.next()) {
                totalOrders = String.valueOf(ordersResult.getInt("total"));
            }

            String productsCountQuery = "SELECT COUNT(*) AS total FROM products";
            PreparedStatement productsStmt = connection.prepareStatement(productsCountQuery);
            ResultSet productsResult = productsStmt.executeQuery();
            String totalProducts = null;
            if (productsResult.next()) {
                totalProducts = String.valueOf(productsResult.getInt("total"));
            }

            String customersCountQuery = "SELECT COUNT(*) AS total FROM users where role = 'CUSTOMER'";
            PreparedStatement customersStmt = connection.prepareStatement(customersCountQuery);
            ResultSet customersResult = customersStmt.executeQuery();
            String totalCustomers = null;
            if (customersResult.next()) {
                totalCustomers = String.valueOf(customersResult.getInt("total"));
            }


                JsonArrayBuilder data = Json.createArrayBuilder();
            data.add(totalOrders);
            data.add(totalProducts);
            data.add(totalCustomers);

            JsonObjectBuilder response = Json.createObjectBuilder();
            response.add("data", data.build());
            response.add("status", HttpServletResponse.SC_OK);
            response.add("message", "Success");

            JsonObject jsonObject = response.build();
            resp.setContentType("application/json");
            resp.getWriter().print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}