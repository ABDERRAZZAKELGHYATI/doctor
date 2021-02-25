package ma.youcode.doctor.dao.impl;

import java.util.List;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ma.youcode.doctor.config.HybernateConfig;
import ma.youcode.doctor.dao.DateDao;
import ma.youcode.doctor.entity.Date;

public class DateDaoImpl implements DateDao {
	private List<Date> dates;
	private HybernateConfig hybernateConfig;
	private SessionFactory factory ;
	private Session session;

	@Override
	public List<Date> getAllDates() {
		// Instantiate HybernateConfig
		hybernateConfig = new HybernateConfig();
		
		// Create Session factory
		factory = hybernateConfig.getDateSessionFactory();
		
		// Create session
		session = factory.getCurrentSession();
		
		try {
			// Start transaction
			session.beginTransaction();
			
			
			// Hql dates and get dates
			Query hql = session.createQuery("from Date");
			dates = hql.getResultList();
			
			// commit transaction
			session.getTransaction().commit();
			
		} finally {
			factory.close();
		}
		
		return dates;
	}

}
