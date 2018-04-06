package Controller;

import Model.DAO;
import Model.DAOException;
import Model.DataSourceFactory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginController extends HttpServlet {

    private boolean isClient = false;
    private boolean isAdmin = false;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Quelle action a appelé cette servlet ?
        String action = request.getParameter("action");
        if (null != action) {
            switch (action) {
                case "ConnexionAdministrateur":
                    checkLoginAdmin(request);
                    break;
               /* case "ConnexionClient":
                    checkLoginClient(request);
                    break;*/
                case "logout":
                    doLogout(request);
                    break;
            }
        }

        String userName = findUserInSession(request);
        String jspView;
        
        if (isClient == false && isAdmin == false) { // L'utilisateur n'est pas connecté
            // On choisit la page de login
            jspView = "index.jsp";

        } else {
            if (isAdmin) {
                jspView = "admin.jsp";
            } else {
                jspView = "client.jsp";
            }

        }
        // On va vers la page choisie
        request.getRequestDispatcher(jspView).forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /*
    Renvoie une courte description de la Servlet.
    @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private boolean connexion(HttpServletRequest request) throws DAOException {
        boolean result = false;
        String loginParamC = request.getParameter("loginParamC");
        String passwordParamC = request.getParameter("passwordParamC");
        DAO dao = new DAO(DataSourceFactory.getDataSource());
        Model.CustomerEntity client = dao.findCustomer(loginParamC, passwordParamC);
        /*   Logger.getLogger("DiscountEditor").log(Level.INFO, "Database already exists");*/
        result = true;
        return result;
    }

    /*private void checkLoginClient(HttpServletRequest request) {
        // Les paramètres transmis dans la requête
        String loginParamC = request.getParameter("loginParamC");
        String passwordParamC = request.getParameter("passwordParamC");
        // Fonction du DAO
        Model.CustomerEntity client;
        try {
            client = Model.DAO.findCustomer(loginParamC, passwordParamC);
        } catch (DAOException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
        String login = client.getEmail();
        String password = Integer.toString(client.getCustomerId());
        String userName = getInitParameter("userName");

        Connection connection = null;
        Statement stmt = null;
        try {
            connection = getConnectionWithDriverManager();
            stmt = connection.createStatement();
        } catch (SQLException ex) {
        }
        if ((login.equals(loginParamC) && (password.equals(passwordParamC)))) {
            // On a trouvé la combinaison login / password
            // On stocke l'information dans la session
            HttpSession session = request.getSession(true); // démarre la session
            session.setAttribute("userName", userName);
            session.setAttribute("true", isClient);
        } else {
            try {
                if (connexion(request)) {
                    HttpSession session = request.getSession(true); // démarre la session
                    session.setAttribute("userName", userName);
                } else { // On positionne un message d'erreur pour l'afficher dans la JSP
                    request.setAttribute("errorMessage", "Login/Password incorrect");
                }
            } catch (DAOException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }*/

    private void checkLoginAdmin(HttpServletRequest request) {
        // Les paramètres transmis dans la requête
        String loginParam = request.getParameter("loginParam");
        String passwordParam = request.getParameter("passwordParam");
        // Le login/password défini dans web.xml
        String login = getInitParameter("login");
        String password = getInitParameter("password");
        String userName = getInitParameter("userName");

        Connection connection = null;
        Statement stmt = null;
        try {
            connection = getConnectionWithDriverManager();
            stmt = connection.createStatement();
        } catch (SQLException ex) {
        }
        if ((login.equals(loginParam) && (password.equals(passwordParam)))) {
            // On a trouvé la combinaison login / password
            // On stocke l'information dans la session
            HttpSession session = request.getSession(true); // démarre la session
            session.setAttribute("userName", userName);
            session.setAttribute("true", isAdmin);
        } else {
            try {
                if (connexion(request)) {
                    HttpSession session = request.getSession(true); // démarre la session
                    session.setAttribute("userName", userName);
                    session.setAttribute("true", isAdmin);
                } else { // On positionne un message d'erreur pour l'afficher dans la JSP
                    request.setAttribute("errorMessage", "Login/Password incorrect");
                }
            } catch (DAOException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private void doLogout(HttpServletRequest request) {
        // On termine la session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    private String findUserInSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session == null) ? null : (String) session.getAttribute("userName");
    }

    public static Connection getConnectionWithDriverManager() throws SQLException {
        String URL = "jdbc:derby://localhost:1527/sample";
        String USERNAME = "app";
        String PASSWORD = "app";
        // On se connecte au serveur
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

}
