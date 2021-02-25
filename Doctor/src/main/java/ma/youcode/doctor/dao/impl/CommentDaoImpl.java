package ma.youcode.doctor.dao.impl;

import java.util.List;

import javax.persistence.Query;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ma.youcode.doctor.config.HybernateConfig;
import ma.youcode.doctor.dao.CommentDao;
import ma.youcode.doctor.entity.Comment;

public class CommentDaoImpl implements CommentDao {
	private List<Object[]> comments;
	private HybernateConfig hybernateConfig;
	private SessionFactory factory ;
	private Session session;

	@Override
	public List<Object[]> getAllComments() {
		// Instantiate HybernateConfig
		hybernateConfig = new HybernateConfig();
		
		// Create Session factory
		factory = hybernateConfig.getCommentSessionFactory();
		
		// Create session
		session = factory.getCurrentSession();
		
		try {
			// Start transaction
			session.beginTransaction();
		
			// Query comment and get comments
			Query hql = session.createNativeQuery("SELECT * FROM COMMENTS c, users u WHERE c.user_id = u.id");
			comments = hql.getResultList();
			
			// commit transaction
			session.getTransaction().commit();
			
			
		} finally {
			// close factory
			factory.close();
		}
		
		return comments;
	}

}
