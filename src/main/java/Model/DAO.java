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

    public List<CustomerEntity> allCustomers() throws SQLException {

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
     * Contenu de la table DISCOUNT_CODE
     *
     * @return Liste des discount codes
     * @throws SQLException renvoyées par JDBC
     */
    public List<DiscountCode> allCodes() throws SQLException {

        List<DiscountCode> result = new LinkedList<>();

        String sql = "SELECT * FROM DISCOUNT_CODE ORDER BY DISCOUNT_CODE";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String id = rs.getString("DISCOUNT_CODE");
                float rate = rs.getFloat("RATE");
                DiscountCode c = new DiscountCode(id, rate);
                result.add(c);
            }
        }
        return result;
    }

    public List<Commandes> commandesParClient(String email) throws SQLException {
        List<Commandes> result = new LinkedList<>();
        // Une requête SQL paramétrée
        String sql = "SELECT order_num, product_id, quantity, shipping_cost, description FROM product inner join purchase_order using (product_id) inner join customer using(customer_id) WHERE email = ?";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // On récupère les champs nécessaires de l'enregistrement courant
                    int OrderNum = rs.getInt("order_num");
                    int produitId = rs.getInt("product_id");
                    int quantite = rs.getInt("quantity");
                    float cout = rs.getFloat("shipping_cost");
                    String description = rs.getString("description");
                    // On crée l'objet entité
                    Commandes c = new Commandes(OrderNum, produitId, quantite, cout, description);
                    // On l'ajoute à la liste des résultats
                    result.add(c);
                }
            }
        }
        return result;
    }

    public List<String> existingProducts() throws DAOException {
        List<String> result = new LinkedList<>();
//        String sql = "SELECT PRODUCT_ID, PRODUCT_CODE, PURCHASE_COST, DESCRIPTION FROM PRODUCT";
        String sql = "SELECT DISTINCT DESCRIPTION FROM PRODUCT";
        try (Connection connection = myDataSource.getConnection();
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
//                int productID = rs.getInt("PRODUCT_ID");
//                int productCode = rs.getInt("PRODUCT_CODE");
//                float cost = rs.getFloat("PURCHASE_COST");
                String description = rs.getString("DESCRIPTION");
                result.add(description);
//                Produits p = new Produits(productID, productCode, 0, cost, description);
//                
//                result.add(p);
            }
        } catch (SQLException e) {
            throw new DAOException(e.getMessage());
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
     * Detruire un enregistrement dans la table CUSTOMER
     *
     * @param customerId la clé du client à détruire
     * @return le nombre d'enregistrements détruits (1 ou 0 si pas trouvé)
     * @throws DAOException
     */
    /**
     * Ajout d'un enregistrement dans la table DISCOUNT_CODE
     *
     * @param code le code (non null)
     * @param rate le taux (positive or 0)
     * @return 1 si succès, 0 sinon
     * @throws SQLException renvoyées par JDBC
     */
    public int addDiscountCode(String code, float rate) throws SQLException {
        int result = 0;
        String sql = "INSERT INTO DISCOUNT_CODE VALUES (?, ?)";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, code);
            stmt.setFloat(2, rate);
            result = stmt.executeUpdate();
        }
        return result;
    }

    /*
    public String addProduct(String description, float prix) throws SQLException {
        String result = null;
        String sql = "INSERT INTO PURCHASE_ORDER VALUES (?, ?, ?, ?)";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, code);
            stmt.setFloat(2, rate);
            result = stmt.executeUpdate();
        }
        return result;
    }*/

    public int deleteCustomer(int customerId) throws DAOException {

        // Une requête SQL paramétrée
        String sql = "DELETE FROM CUSTOMER WHERE CUSTOMER_ID = ?";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Définir la valeur du paramètre
            stmt.setInt(1, customerId);

            return stmt.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new DAOException(ex.getMessage());
        }
    }

    /**
     * Supprime un enregistrement dans la table DISCOUNT_CODE
     *
     * @param code la clé de l'enregistrement à supprimer
     * @return le nombre d'enregistrements supprimés (1 ou 0)
     * @throws java.sql.SQLException renvoyées par JDBC
     *
     */
    public int deleteDiscountCode(String code) throws SQLException {
        int result = 0;
        String sql = "DELETE FROM DISCOUNT_CODE WHERE DISCOUNT_CODE = ?";
        try (Connection connection = myDataSource.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, code);
            result = stmt.executeUpdate();
        }
        return result;
    }

    /**
     * Trouver un Customer à partir de sa clé
     *
     * @param customerID la clé du CUSTOMER à rechercher
     * @return l'enregistrement correspondant dans la table CUSTOMER, ou null si
     * pas trouvé
     * @throws DAOException
     */
    public CustomerEntity findCustomer(int customerID) throws DAOException {
        CustomerEntity result = null;

        String sql = "SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = ?";
        try (Connection connection = myDataSource.getConnection(); // On crée un statement pour exécuter une requête
                PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, customerID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) { // On a trouvé
                    String email = rs.getString("EMAIL");
                    // On crée l'objet "entity"
                    result = new CustomerEntity(customerID, email);
                } // else on n'a pas trouvé, on renverra null
            }
        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new DAOException(ex.getMessage());
        }

        return result;
    }

    public CustomerEntity findClient(String email, String customerID) throws DAOException {
        CustomerEntity result = null;

        String sql = "SELECT * FROM CUSTOMER WHERE EMAIL = ? AND CUSTOMER_ID = ?";
        try (Connection connection = myDataSource.getConnection(); // On crée un statement pour exécuter une requête
                PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, customerID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) { // On a trouvé
                    // On crée l'objet "entity"
                    email = rs.getString("EMAIL");
                    customerID = rs.getString("CUSTOMER_ID");
                    result = new CustomerEntity(Integer.parseInt(customerID), email);
                } // else on n'a pas trouvé, on renverra null
            }
        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new DAOException(ex.getMessage());
        }

        return result;
    }

    public Map<String, Double> CaParProduit() throws DAOException {
        Map<String, Double> result = new HashMap<>();
        String sql = "SELECT PRODUCT_CODE, SUM(PURCHASE_COST * QUANTITY) AS SALES FROM PRODUCT c INNER JOIN PURCHASE_ORDER o ON (c.PRODUCT_ID = o.PRODUCT_ID) GROUP BY PRODUCT_CODE";
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
        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new DAOException(ex.getMessage());
        }
        return result;
    }

    public Map<String, Double> CaParZone() throws DAOException {
        Map<String, Double> result = new HashMap<>();
        String sql = "SELECT STATE, SUM(SHIPPING_COST * QUANTITY) AS SALES FROM APP.CUSTOMER c INNER JOIN APP.PURCHASE_ORDER o ON (c.CUSTOMER_ID = o.CUSTOMER_ID) GROUP BY STATE";
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
        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new DAOException(ex.getMessage());
        }
        return result;
    }

    public Map<String, Double> CaParClient() throws DAOException {
        Map<String, Double> result = new HashMap<>();
        String sql = "SELECT NAME, SUM(PURCHASE_COST * QUANTITY) AS SALES FROM CUSTOMER c INNER JOIN PURCHASE_ORDER o ON (c.CUSTOMER_ID = o.CUSTOMER_ID)INNER JOIN PRODUCT p ON (o.PRODUCT_ID = p.PRODUCT_ID) GROUP BY NAME";
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
        } catch (SQLException ex) {
            Logger.getLogger("DAO").log(Level.SEVERE, null, ex);
            throw new DAOException(ex.getMessage());
        }
        return result;
    }

}
