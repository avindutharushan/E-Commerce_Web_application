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
import java.sql.ResultSet;

@WebServlet(name = "category", value = "/category")
public class CategoryServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Connection connection = dataSource.getConnection();
            if (connection == null) {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database connection error.");
                return;
            }

            ResultSet resultSet = connection.prepareStatement("SELECT * FROM categories").executeQuery();

            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            while (resultSet.next()){
                int id = resultSet.getInt(1);
                String name = resultSet.getString(2);
                String description = resultSet.getString(3);
                String image_url = resultSet.getString(4);

                JsonObjectBuilder category = Json.createObjectBuilder();
                category.add("id", id);
                category.add("name", name);
                category.add("description", description);
                category.add("image_url", image_url);
                arrayBuilder.add(category.build());
            }
            JsonObjectBuilder response = Json.createObjectBuilder();
            response.add("data", arrayBuilder);
            response.add("status", HttpServletResponse.SC_OK);
            response.add("message", "Success");

            JsonObject jsonObject = response.build();
            resp.setContentType("application/json");
            resp.getWriter().print(jsonObject);

            connection.close();
        }catch (Exception e){
            e.printStackTrace();
            JsonObjectBuilder response = Json.createObjectBuilder();
            response.add("data", "");
            response.add("status", HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.add("message", e.getMessage());
        }
    }

}
