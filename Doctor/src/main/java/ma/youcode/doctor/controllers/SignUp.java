package ma.youcode.doctor.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.mindrot.jbcrypt.BCrypt;

import ma.youcode.doctor.config.HybernateConfig;
import ma.youcode.doctor.entity.User;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/signup")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HybernateConfig hybernateConfig = null;
       
    public SignUp() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Instantiate HybernateConfig
		hybernateConfig = new HybernateConfig();
		
		// Get session factory
		SessionFactory factory = hybernateConfig.getUserSessionFactory();
		
		// Create session
		Session session = factory.getCurrentSession();
		
		try {
			// Get data from user
			String firstName = request.getParameter("firstname");
			String lastName = request.getParameter("lastname");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String hashPwd = BCrypt.hashpw(password, BCrypt.gensalt());
			
			// Create User Object
			User user = new User(firstName, lastName, email, hashPwd);
			
			// Begin transaction
			session.beginTransaction();
			
			// Save user object to database
			int isUserSingedUp = (int) session.save(user);
			
			// Create http session
	        HttpSession httpSession = request.getSession();
	        
			if (isUserSingedUp > 0) {
				// Commit transaction
				session.getTransaction().commit();
		        
				// send error login message to login page
		        httpSession.setAttribute("isUserSingedUp", true);
		        
		        // redirect to home page
		        response.sendRedirect("/Doctor/");
			} else {
		        
				// send error login message to login page
		        httpSession.setAttribute("isUserSingedUp", false);
		        
		        // redirect to home page
		        response.sendRedirect("/Doctor/");
			}
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			
		} finally {
			factory.close();
		}
	}

}
