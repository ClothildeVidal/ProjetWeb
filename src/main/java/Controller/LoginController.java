package Controller;

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Quelle action a appelé cette servlet ?
        String action = request.getParameter("action");
        if (null != action) {
            switch (action) {
                case "Connexion":
                    checkLogin(request);
                    break;
                case "logout":
                    doLogout(request);
                    break;
            }
        }

        String userName = findUserInSession(request);
        String jspView;
        if (null == userName) { // L'utilisateur n'est pas connecté
            // On choisit la page de login
            jspView = "index.jsp";

        } else {
            jspView = "affiche.jsp";

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

    private void checkLogin(HttpServletRequest request) {
        // Les paramètres transmis dans la requête
        String loginParam = request.getParameter("loginParam");
        String passwordParam = request.getParameter("passwordParam");

        // Le login/password défini dans web.xml
        String login = getInitParameter("login");
        String password = getInitParameter("password");
        String userName = getInitParameter("userName");
        Connection connection = null;
        Statement stmt = null;
        ResultSet loginC = null;
        ResultSet passwordC = null;
        try {
            connection = getConnectionWithDriverManager();
            stmt = connection.createStatement();
            loginC = stmt.executeQuery("SELECT EMAIL FROM CUSTOMER");
            passwordC = stmt.executeQuery("SELECT CUSTOMER_ID FROM CUSTOMER");
        } catch (SQLException ex) {
        }
        for(int i=0; i<13;i++){
            
        }
        if ((login.equals(loginParam) && (password.equals(passwordParam)))) {
            // On a trouvé la combinaison login / password
            // On stocke l'information dans la session
            HttpSession session = request.getSession(true); // démarre la session
            session.setAttribute("userName", userName);
        } else if ((loginC.equals(loginParam)) && (passwordC.equals(passwordParam))) {
            HttpSession session = request.getSession(true); // démarre la session
            session.setAttribute("userName", userName);
        } else { // On positionne un message d'erreur pour l'afficher dans la JSP
            request.setAttribute("errorMessage", "Login/Password incorrect");
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
