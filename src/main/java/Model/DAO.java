package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;

public class DAO {

    public final DataSource myDataSource;

    public DAO(DataSource dataSource) {
        this.myDataSource = dataSource;
    }

    /**
     * Contenu de la table CUSTOMER
     *
     * @return Liste des customers
     * @throws SQLException renvoyées par JDBC
     */
    public List<CustomerEntity> allCodes() throws SQLException {

        List<CustomerEntity> result = new LinkedList<>();

        String sql = "SELECT * FROM CUSTOMER ORDER BY CUSTOMER_ID";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("CUSTOMER_ID");
                String email = rs.getString("EMAIL");
                CustomerEntity c = new CustomerEntity(id, email);
                result.add(c);
            }
        }
        return result;
    }

    /**
     * Ajout d'un enregistrement dans la table CUSTOMER
     *
     * @param code le code (non null)
     * @param rate le taux (positive or 0)
     * @return 1 si succès, 0 sinon
     * @throws SQLException renvoyées par JDBC
     */
//	public int addCustomer(int id, String email) throws SQLException {
//		int result = 0;
//		String sql = "INSERT INTO CUSTOMER VALUES (?, ?)";
//		try (Connection connection = myDataSource.getConnection(); 
//		     PreparedStatement stmt = connection.prepareStatement(sql)) {
//			stmt.setInt(1, id);
//			stmt.setString(2, email);
//			result = stmt.executeUpdate();
//		}
//		return result;
//	}
    /**
     * Supprime un enregistrement dans la table CUSTOMER
     *
     * @param customerID
     * @param emailCustomer
     * @param code la clé de l'enregistrement à supprimer
     * @return le nombre d'enregistrements supprimés (1 ou 0)
     * @throws Model.DAOException
     * @throws java.sql.SQLException renvoyées par JDBC
	 *
     */
//	public int deleteCustomer(int id) throws SQLException {
//		int result = 0;
//		String sql = "DELETE FROM CUSTOMER WHERE CUSTOMER_ID = ?";
//		try (Connection connection = myDataSource.getConnection(); 
//		     PreparedStatement stmt = connection.prepareStatement(sql)) {
//			stmt.setInt(1, id);
//			result = stmt.executeUpdate();
//		}
//		return result;
//	}
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

    public Map<String, Double> CaParProduit() throws SQLException {
        Map<String, Double> result = new HashMap<>();
        String sql = "SELECT PRODUCT_CODE, SUM(PURCHASE_COST * QUANTITY) AS SALES FROM APP.PRODUCT c INNER JOIN APP.PURCHASE_ORDER o ON (c.PRODUCT_ID = o.PRODUCT_ID) GROUP BY PRODUCT_CODE";
        try (Connection connection = myDataSource.getConnection();
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                // On récupère les champs nécessaires de l'enregistrement courant
                String produit = rs.getString("PRODUCT_CODE");
                double sales = rs.getDouble("SALES");
                // On l'ajoute à la liste des résultats
                result.put(produit, sales);
            }
        }
        return result;
    }

    public Map<String, Double> CaParZone() throws SQLException {
        Map<String, Double> result = new HashMap<>();
        String sql = "SELECT STATE, SUM(PURCHASE_COST * QUANTITY) AS SALES FROM APP.COSTUMER c INNER JOIN APP.PURCHASE_ORDER o ON (c.COSTUMER_ID = o.COSTUMER_ID) GROUP BY STATE";
        try (Connection connection = myDataSource.getConnection();
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                // On récupère les champs nécessaires de l'enregistrement courant
                String zone = rs.getString("STATE");
                double sales = rs.getDouble("SALES");
                // On l'ajoute à la liste des résultats
                result.put(zone, sales);
            }
        }
        return result;
    }
    
    public Map<String, Double> CaParClient() throws SQLException {
		Map<String, Double> result = new HashMap<>();
		String sql = "SELECT NAME, SUM(PURCHASE_COST * QUANTITY) AS SALES FROM APP.CUSTOMER c INNER JOIN PURCHASE_ORDER o ON (c.COSTUMER_ID = o.COSTUMER_ID) GROUP BY COSTUMER_ID";
		try (Connection connection = myDataSource.getConnection(); 
		     Statement stmt = connection.createStatement(); 
		     ResultSet rs = stmt.executeQuery(sql)) {
			while (rs.next()) {
				// On récupère les champs nécessaires de l'enregistrement courant
				String name = rs.getString("NAME");
				double sales = rs.getDouble("SALES");
				// On l'ajoute à la liste des résultats
				result.put(name, sales);
			}
		}
		return result;
	}

}
