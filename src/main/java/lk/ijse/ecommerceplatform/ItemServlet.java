package lk.ijse.ecommerceplatform;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerceplatform.dto.ProductDTO;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

@WebServlet(name = "product", value = "/products")
public class ItemServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Connection connection = dataSource.getConnection();
            if (connection == null) {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database connection error.");
                return;
            }

            ResultSet resultSet = connection.prepareStatement("SELECT * FROM products").executeQuery();

            ArrayList<Object> products = new ArrayList<>();
            while (resultSet.next()){
                int product_id = resultSet.getInt(1);
                int category_id = resultSet.getInt(2);
                String name = resultSet.getString(3);
                String description = resultSet.getString(4);
                double price = resultSet.getDouble(5);
                int quantity = resultSet.getInt(6);
                String image_url = resultSet.getString(7);

                products.add(new ProductDTO(product_id, category_id, name, description, price, quantity, image_url));
            }
            connection.close();
            request.setAttribute("products", products);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("pages/products.jsp");
            requestDispatcher.forward(request, resp);
        }catch (Exception e){
            e.printStackTrace();
            request.setAttribute("products", null);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("pages/products.jsp");
            requestDispatcher.forward(request, resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
