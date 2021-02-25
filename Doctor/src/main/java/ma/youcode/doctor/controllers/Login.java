package ma.youcode.doctor.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.mindrot.jbcrypt.BCrypt;

import ma.youcode.doctor.config.HybernateConfig;
import ma.youcode.doctor.entity.User;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HybernateConfig hybernateConfig = null;
	List<User> user = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		
		// Get data from user
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		try {
			// Start transaction
			session.beginTransaction();
			
			// Query users and get user
			Query hql = session.createQuery("FROM User");
			user = hql.getResultList();
			
			// Create http session
			HttpSession httpSession = request.getSession();
			
			// Get value if user logged in or not
			int isLoggedIn = this.isAuth(email, password, httpSession, user);
			
			// Check if user exists and its role
			switch (isLoggedIn) {
				// when user does not exists OR user exists and is normal user 
				case 0: 
				case 2: {
			        // redirect to home page
			        response.sendRedirect("/Doctor/");
			        
			        break;
				}
				// when user exists and is admin 
				case 1: {
			        // redirect to home page
			        response.sendRedirect("/Doctor/admin.jsp");
			        
			        break;
				}

				default: {
			        // redirect to home page
			        response.sendRedirect("/Doctor/");
			        
			        break;
				}
			}
			
			// Commit transaction
			session.getTransaction().commit();

			
		} finally {
			// Close factory
			factory.close();
		}
	}
	
	// Create user session
	public User createUserSession(User user, HttpSession session) {
		session.setAttribute("user", user);
		return user;
	}
	
	// Is User Auth
	private int isAuth(String email, String password, HttpSession httpSession, List<User> list) {
		int isLoggedIn = 0;
		
		// check if list is contains some users
		if (list.size() > 0) {
			// Loop through users
			for (User userInfo : list) {

				// Check info
				if (userInfo.getEmail().equals(email) && BCrypt.checkpw(password, userInfo.getPassword()) && userInfo.getRole().equals("admin")) {
			        // set reacted message
					httpSession.setAttribute("isLoggedIn", true);
					this.createUserSession(userInfo, httpSession);
			        
			        // return user exists and role is admin
					isLoggedIn = 1;
					
					// break the loop
					break;
			        
				} if (userInfo.getEmail().equals(email) && BCrypt.checkpw(password, userInfo.getPassword()) && userInfo.getRole().equals("user")) {
			        // set reacted message
					httpSession.setAttribute("isLoggedIn", true);
					this.createUserSession(userInfo, httpSession);
			        
			        // return user exists and role is user
					isLoggedIn = 2;
					
					// break the loop
					break;
					
				} else {
			        // set reacted message
					httpSession.setAttribute("isLoggedIn", false);
			        
			        // return user does not exists
					isLoggedIn = 0;
				}
			}
		}else {
	        // set reacted message
				httpSession.setAttribute("isLoggedIn", false);
		        
		        // return user does not exists
				isLoggedIn = 0;
		}
		
		// return isLoggedIn
		return isLoggedIn;
	}

}
