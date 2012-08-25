/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.org.rbc1b.roms.controller.kingdomhall;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import uk.org.rbc1b.roms.db.KingdomHall;

/**
 *
 * @author oliver.elder.esq
 */
@Component
public class HibernateKingdomHallDao implements KingdomHallDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public KingdomHall findKingdomHall(String name) {
        return (KingdomHall) this.sessionFactory.getCurrentSession().get(KingdomHall.class, name);
    }

    @Override
    public List<KingdomHall> findKingdomHalls() {
        Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(KingdomHall.class);
        List<KingdomHall> halls = criteria.list();
        for (KingdomHall hall : halls) {
            //Hibernate.initialize(hall.getCongregation());
            //Hibernate.initialize(hall.getCongregations());
            hall.setCongregation(null);
            hall.setCongregations(null);
            hall.setProjects(null);
        }
        return halls;
    }

    @Override
    public void createKingdomHall(KingdomHall kingdomHall) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
}
