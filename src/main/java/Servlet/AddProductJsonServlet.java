package Servlet;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.DAO;
import Model.DataSourceFactory;
import java.net.URLDecoder;


@WebServlet(name = "addProduct", urlPatterns = {"/addProduct"})
//servlet de type httpServlet 
public class AddProductJsonServlet extends HttpServlet {

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		DAO dao = new DAO(DataSourceFactory.getDataSource());
		String prodIDS = request.getParameter("produitID");
                int prodID = Integer.parseInt(prodIDS);
		String qteS = request.getParameter("qte");
                int qte = Integer.parseInt(qteS);
                String IDS = request.getParameter("userID");
                int ID = Integer.parseInt(IDS);
		String message;
		try {
			dao.addCommande(prodID, qte, ID);
			message = String.format("Commande %s ajoutée", prodID);
		} catch (NumberFormatException | SQLException ex) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			message = ex.getMessage();
		}
		
		Properties resultat = new Properties();
		resultat.put("message", message);

		try (PrintWriter out = response.getWriter()) {
			// On spécifie que la servlet va générer du JSON
			response.setContentType("application/json;charset=UTF-8");
			// Générer du JSON
			Gson gson = new Gson();
                        //données de la forme json
			out.println(gson.toJson(resultat));
		}
	}

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
        //analyse les paramètres de la requête et écrit réponse
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
        
        //recueille les paramètres pour les traiter et générer la réponse
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
