package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;
import javax.sql.DataSource;

public class ExtendedDAO extends DAO {

    public ExtendedDAO(DataSource dataSource) {
        super(dataSource);
    }

    public List<String> commandesExistantes() throws DAOException {
        List<String> result = new LinkedList<>();
        String sql = "SELECT PRODUCT_ID FROM PURCHASE_ORDER WHERE CUSTOMER_ID=?";
        try (Connection connection = myDataSource.getConnection();
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                String commande = rs.getString("PRODUCT_ID");
                result.add(commande);
            }
        } catch (SQLException e) {
            throw new DAOException(e.getMessage());
        }
        return result;
    }
}
