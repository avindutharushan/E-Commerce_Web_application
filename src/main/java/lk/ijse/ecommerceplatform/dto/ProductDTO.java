package lk.ijse.ecommerceplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDTO {
    private int product_id;
    private int category_id;
    private String name;
    private String description;
    private double price;
    private int quantity;
    private String image_url;
}
