package Servlet;

import Model.DAOException;
import Model.DataSourceFactory;
import Model.ExtendedDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "StateForm", urlPatterns = {"/StateForm"})
public class ProductForm extends HttpServlet {

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

		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Formulaire dynamique</title>");
			out.println("</head>");
			out.println("<body>");
			try {
				ExtendedDAO dao = new ExtendedDAO(DataSourceFactory.getDataSource());
				List<String> produit = dao.existingProducts();

				// Formulaire 
//				out.println("<form action='ListProduitsJsonServlet'>");
//				out.println("<select name='produit'>");

				for (String s : produit) {
					// Mettre un état dans la liste de choix			
					out.printf("<option value='%s'>%s</option>%n",
						s,
						s);
				}
				out.println("</select>");
				out.println("<input type='submit'>");
				out.println("</form>");
			} catch (DAOException e) {
				out.printf("<h3>Erreur : %s</h3>", e.getMessage());
			}
			out.printf("<hr><a href='%s'>Retour au menu</a>",request.getContextPath());			
			out.println("</body>");
			out.println("</html>");
		} catch (Exception ex) {
			Logger.getLogger("servlet").log(Level.SEVERE, "Erreur de traitement", ex);
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
