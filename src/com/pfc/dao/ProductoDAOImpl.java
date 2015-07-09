package com.pfc.dao;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.hibernate.Criteria;
import org.hibernate.Transaction;
import org.hibernate.criterion.*;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.pfc.domain.Pedido;
import com.pfc.domain.Producto;
import com.pfc.domain.Usuario;


public class ProductoDAOImpl implements ProductoDAO {
	
	private HibernateTemplate hibernateTemplate;
    private Session session;
    private SessionFactory sessionFactory;
    
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
		this.sessionFactory=sessionFactory;
	}

	
	@Override
	@SuppressWarnings("unchecked")
	public List<Producto> listProducto() {
		return hibernateTemplate.find ("from Producto");
	}

	@Override
	public List<Producto> ofertasProducto(){
		
		session=sessionFactory.openSession();
		
		List<Producto> p=session.createCriteria(Producto.class) 
		.addOrder( Order.asc("precio") )
		.addOrder( Order.desc("cantidad") )		
		.setMaxResults(6)
   		.list();
		
		session.close();
		return p;
		
	}
	
	
	
	
	@Override
	@SuppressWarnings("unchecked")
	public List<Producto> listaPagProducto(int paginaActual, int resultadosPorPagina) {
		
		session=sessionFactory.openSession();
		
		Criteria criteria=session.createCriteria(Producto.class);
		criteria.addOrder(Order.asc("producto"));
		criteria.setFirstResult(paginaActual*resultadosPorPagina-resultadosPorPagina);
		criteria.setMaxResults(resultadosPorPagina);
		List<Producto> lp=criteria.list();
		
		session.close();
		return lp;
		
	}	
	
	@Override
	public Producto getProducto(int idproductos){
		return (Producto)hibernateTemplate.get(Producto.class, idproductos); 
	}
	
	@Override	
	@SuppressWarnings("unchecked")
	public List<Producto> listaProductoPorCategoria(String categoria){
		return hibernateTemplate.find("from Producto where categoria=?",categoria);
	}
	
	@Override	
	@SuppressWarnings("unchecked")
	public List<Producto> listaProductoPorCategoriaCarousel(String categoria){
		
		session=sessionFactory.openSession();
		
		Criteria criteria=session.createCriteria(Producto.class);
		criteria.add(Restrictions.eq("categoria",categoria));
		criteria.addOrder(Order.desc("idproductos"));
		criteria.setMaxResults(20);
		List<Producto> lp=criteria.list();
		
		session.close();
		return lp;
		
	}
	
	@Override	
	@SuppressWarnings("unchecked")
	public List<Producto> listaPagProductoPorCategoria(String categoria, int paginaActual, int resultadosPorPagina){
		
		session=sessionFactory.openSession();
		Criteria criteria=session.createCriteria(Producto.class);
		criteria.addOrder(Order.asc("producto"))
		.add(Restrictions.eq("categoria", categoria));
		criteria.setFirstResult(paginaActual*resultadosPorPagina-resultadosPorPagina);
		criteria.setMaxResults(resultadosPorPagina);
		List<Producto> lp=criteria.list();
		session.close();
		return lp;
	}
	
	
	@Override	
	@SuppressWarnings("unchecked")
	public List<Producto> buscarProducto(String parametro_busqueda){
		return hibernateTemplate.findByNamedParam("from Producto where producto like :cadena", "cadena", '%' + parametro_busqueda + '%');
	}
	
	@Override	
	@SuppressWarnings("unchecked")
	public List<Producto> listaPagBuscarProducto(String parametro_busqueda, int paginaActual, int resultadosPorPagina){
		
		session=sessionFactory.openSession();
		Criteria criteria=session.createCriteria(Producto.class);
		criteria.addOrder(Order.asc("producto"))
		.add(Restrictions.like("producto", "%"+parametro_busqueda+"%"));
		criteria.setFirstResult(paginaActual*resultadosPorPagina-resultadosPorPagina);
		criteria.setMaxResults(resultadosPorPagina);
		
		List<Producto> lp=criteria.list();
		session.close();
		return lp;
	}
	
	
	@Override	
	@SuppressWarnings("unchecked")
	public List<Producto> buscarProductoAvanzada(String titulo, String autor, String ISBN, String editorial){
		
		session=sessionFactory.openSession();
		List<Producto> l=new ArrayList();
		Criteria criteria=session.createCriteria(Producto.class);
		criteria.addOrder(Order.asc("producto"));
		

		if (titulo != "") {
			criteria.add(Restrictions.like("producto","%"+titulo+"%"));
		}
		if (autor != "") {
			criteria.add(Restrictions.like("autor","%"+autor+"%"));
		}
		if (ISBN != "") {
			criteria.add(Restrictions.eq("ISBN",ISBN));
		}
		if (editorial != "") {
			criteria.add(Restrictions.like("editorial","%"+editorial+"%"));
		}
		
		if((titulo != "") || (autor != "") || (ISBN != "") || (editorial != ""))
			l=criteria.list();
		
		session.close();
		
		return l;		
	}
		
	@Override	
	@SuppressWarnings("unchecked")
	public List<Producto> listaPagbuscarProductoAvanzada(String titulo, String autor, String ISBN, String editorial, int paginaActual, int resultadosPorPagina){
	
		session=sessionFactory.openSession();
		
		List<Producto> l=new ArrayList();
		Criteria criteria=session.createCriteria(Producto.class);
		criteria.addOrder(Order.asc("producto"))
		.setFirstResult(paginaActual*resultadosPorPagina-resultadosPorPagina)
		.setMaxResults(resultadosPorPagina);
		
		if (titulo != "") {
			criteria.add(Restrictions.like("producto","%"+titulo+"%"));
		}
		if (autor != "") {
			criteria.add(Restrictions.like("autor","%"+autor+"%"));
		}
		if (ISBN != "") {
			criteria.add(Restrictions.eq("ISBN",ISBN));
		}
		if (editorial != "") {
			criteria.add(Restrictions.like("editorial","%"+editorial+"%"));
		}
		
		if((titulo != "") || (autor != "") || (ISBN != "") || (editorial != ""))
			l=criteria.list();
		
		session.close();
		return l;		
		
	}
}


