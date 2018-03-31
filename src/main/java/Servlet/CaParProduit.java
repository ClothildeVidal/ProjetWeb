package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.*;
import java.sql.SQLException;
import java.util.Collections;
import java.util.Properties;
import Model.DAO;
import Model.DAOException;
import Model.DataSourceFactory;

@WebServlet(name = "CaParProduit", urlPatterns = {"/CaParProduit"})
public class CaParProduit extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, DAOException {
        DAO dao = new DAO(DataSourceFactory.getDataSource());
        // Properties est une Map<clé, valeur> pratique pour générer du JSON
        Properties resultat = new Properties();
        resultat.put("records", dao.CaParProduit());

        try (PrintWriter out = response.getWriter()) {
            // On spécifie que la servlet va générer du JSON
            response.setContentType("application/json;charset=UTF-8");
            // Générer du JSON
            // Gson gson = new Gson();
            // setPrettyPrinting pour que le JSON généré soit plus lisible
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            String gsonData = gson.toJson(resultat);
            out.println(gsonData);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CaParProduit.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DAOException ex) {
            Logger.getLogger(CaParProduit.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CaParProduit.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DAOException ex) {
            Logger.getLogger(CaParProduit.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

/**
 * Returns a short description of the servlet.
 *
 * @return a String containing servlet description
 */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }
