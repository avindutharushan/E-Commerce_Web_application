package lk.ijse.ecommerceplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartDTO2 {
    private int cart_id;
    private int user_id;
    private int product_id;
    private int qty;
    private String imsge_url;
    private ProductDTO productDTO;


}
