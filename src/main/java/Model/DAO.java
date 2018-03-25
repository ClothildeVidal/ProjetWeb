package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;

public class DAO {

    public final DataSource myDataSource;

    public DAO(DataSource dataSource) {
        this.myDataSource = dataSource;
    }

    public CustomerEntity findCustomer(int customerID, String emailCustomer) throws DAOException {
        CustomerEntity result = null;

        String sql = "SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = ? AND CUSTOMER_EMAIL = ?";
        try (Connection connection = myDataSource.getConnection(); // On crée un statement pour exécuter une requête
                PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, customerID);
            stmt.setString(2, emailCustomer);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) { // On a trouvé
                    String name = rs.getString("NAME");
                    String adresse = rs.getString("ADRESSE");
                    // On crée l'objet "entity"
                    result = new CustomerEntity(customerID, emailCustomer);
                } // else on n'a pas trouvé, on renverra null
            }
        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new DAOException(ex.getMessage());
        }

        return result;
    }

}
