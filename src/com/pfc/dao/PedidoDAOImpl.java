package com.pfc.dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.HibernateException;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.hibernate.criterion.*;


import com.pfc.domain.Usuario;
import com.pfc.domain.Producto;
import com.pfc.domain.Pedido;
import com.pfc.domain.LineaPedido;

public class PedidoDAOImpl implements PedidoDAO {

	private HibernateTemplate hibernateTemplate;
    private Session session;
    private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);		
		this.sessionFactory=sessionFactory;		
	}

	@Override
	public Pedido getPedidoByIdpedido(int idpedido){		
		session=sessionFactory.openSession();
		Pedido p=(Pedido)session.get(Pedido.class, idpedido); 
		session.close();
		return p;
	}

	
	@Override
	public List<Pedido> listPedidos(String username){
		
		session=sessionFactory.openSession();
		Usuario usuario=(Usuario)session.get(Usuario.class, username); 
		List<Pedido> p=session.createCriteria(Pedido.class) 
		.add( Restrictions.eq("usuario", usuario) )
		.add( Restrictions.eq("confirmado", true) )  
		.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
		.addOrder( Order.desc("idpedido") )
   		.list();
		session.close();
	
		return p;
	}
	
	@Override
	public List<Pedido> listaPagPedidos(String username, int paginaActual, int resultadosPorPagina){

		session=sessionFactory.openSession();
	    Usuario usuario=(Usuario)session.get(Usuario.class, username); 
		List<Pedido> p=session.createCriteria(Pedido.class) 
		.add( Restrictions.eq("usuario", usuario) )
		.add( Restrictions.eq("confirmado", true) )  
		.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
		.addOrder( Order.desc("idpedido") )
   		.list();
		session.close();
		
		int primer_resultado=paginaActual*resultadosPorPagina-resultadosPorPagina;
		int max_resultados=paginaActual*resultadosPorPagina-resultadosPorPagina+resultadosPorPagina;
		
		List<Pedido> pe;
		
		if(p.subList(primer_resultado,p.size()).size()<resultadosPorPagina)
			pe= p.subList(primer_resultado, p.size());
		else
			pe= p.subList(primer_resultado, max_resultados);

		return pe;
	}
	
	@Override
	public Pedido getPedidoCarrito(String username){
		
		session=sessionFactory.openSession();
		
		Pedido pedido=null;
		
		Usuario usuario=(Usuario)session.get(Usuario.class, username); 
		List<Pedido> p=session.createCriteria(Pedido.class) 
		.add( Restrictions.eq("usuario", usuario) )
		.add( Restrictions.eq("confirmado", false) )  
   		.list();
		
		if(p.size()>0)
			pedido=p.get(0);
		
		session.close();
		return pedido;		
	}
	
	
	public Pedido getPedidoCarritoSinSession(String username){
	
	Pedido pedido=null;

	Usuario usuario=(Usuario)session.get(Usuario.class, username); 
	List<Pedido> p=session.createCriteria(Pedido.class) 
	.add( Restrictions.eq("usuario", usuario) )
	.add( Restrictions.eq("confirmado", false) )  
	.list();
	
	if(p.size()>0)
		pedido=p.get(0);
	
	return pedido;
	
	}
	
	@Override
	public void addProductosCarrito(String username, int idproducto){
		
		session = sessionFactory.openSession();
		Transaction transaction = null;
		try {
			
			transaction = session.beginTransaction(); 
	        
			Usuario usuario=(Usuario)session.get(Usuario.class, username); 
			Producto producto=(Producto)session.get(Producto.class, idproducto); 
				
	
			Pedido p=getPedidoCarritoSinSession(username);
			
			
			Pedido pedido=new Pedido();
			LineaPedido lineapedido=new LineaPedido();
			lineapedido.setCantidad(1);
			lineapedido.setPrecio(producto.getPrecio());
			
			//Si no se ha creado el carrito lo creamos
			if (p==null){
				producto.addLineaPedido(lineapedido);			
				pedido.addLineaPedido(lineapedido);
				pedido.setConfirmado(false);
				usuario.addPedido(pedido);
			    session.save(usuario);   
			    session.save(producto);	
			    session.save(pedido);
			    session.save(lineapedido);
			}else{
				
				List<LineaPedido> lp=session.createCriteria(LineaPedido.class) 
				.add( Restrictions.eq("pedido", p) )
				.add( Restrictions.eq("producto", producto) )  
				.list();
				
				//Si se quiere añadir al carrito un producto del que aún no hay ninguna unidad, se añade
				if(lp.size()==0){
					p.addLineaPedido(lineapedido);
					producto.addLineaPedido(lineapedido);
					session.save(p);
					session.save(producto);
				    session.save(lineapedido);
				//Si ya hay unidades del producto, se suma una unidad del producto a la tabla LineaPedidos
				}else{
					lp.get(0).setCantidad(lp.get(0).getCantidad()+1);
					session.save(lp.get(0));
				}
			}
			
			//Actualizamos la tabla productos	
			producto.setCantidad(producto.getCantidad()-1);
			session.save(producto);
			
		    transaction.commit();	
		    
		} catch (HibernateException e) {
			
			transaction.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
	
	@Override
	public void restaProductosCarrito(String username, int idproducto){
		
		session = sessionFactory.openSession();
		Transaction transaction = null;
		try {
			
			transaction = session.beginTransaction(); 
	        
			Producto producto=(Producto)session.get(Producto.class, idproducto); 		
			Pedido p=getPedidoCarritoSinSession(username);
		
			if (p!=null){
				
				List<LineaPedido> lp=session.createCriteria(LineaPedido.class) 
				.add( Restrictions.eq("pedido", p) )
				.add( Restrictions.eq("producto", producto) )  
				.list();
				
				if (lp.size()!=0){
					//si hay mas de una unidad del producto se resta una unidad a la cantidad de producto
					if(lp.get(0).getCantidad()>1){
						lp.get(0).setCantidad(lp.get(0).getCantidad()-1);
						session.save(lp.get(0));
						producto.setCantidad(producto.getCantidad()+1);
						session.save(producto);	
						transaction.commit();	
						session.close();
					}else{
						transaction.commit();	
						session.close();
						borrarProductosCarrito(username, idproducto);						
					}
				}
			}	 
	    
		} catch (HibernateException e) {			
			transaction.rollback();
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void borrarProductosCarrito(String username, int idproducto){

		session = sessionFactory.openSession();
		Transaction transaction = null;
		try {
			
			transaction = session.beginTransaction();
			
			Producto producto=(Producto)session.get(Producto.class, idproducto); 
			Pedido p=getPedidoCarritoSinSession(username);
			
			if (p!=null){
				
				List<LineaPedido> lp=session.createCriteria(LineaPedido.class) 
				.add( Restrictions.eq("pedido", p) )
				.add( Restrictions.eq("producto", producto) )  
				.list();
				
				if (lp.size()!=0){
					
					int cantidad_productos=lp.get(0).getCantidad();
					
					//Si hay mas de 1 producto en el carrito, se borra sólo el producto del carrito
					if(p.getLineasPedido().size()>1){
						session.delete(lp.get(0));
					//Si sólo hay 1 producto en el carrito, se borra el producto del carrito y el carrito
					}else{
						session.delete(lp.get(0));
						session.delete(p);					
					}
					
					producto.setCantidad(producto.getCantidad()+cantidad_productos);
					session.save(producto);
					
				}			
				
			}
		
			transaction.commit();			 
	    
		} catch (HibernateException e) {			
			transaction.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		
	}
	
	@Override
	public void addPedido(String username, String fecha){

		session = sessionFactory.openSession();
		Transaction transaction = null;
		try {

			transaction = session.beginTransaction();
			
			Pedido p=getPedidoCarritoSinSession(username);
			
			if (p!=null){			
				p.setConfirmado(true);
				p.setFecha(fecha);
				session.save(p);
			}				
			transaction.commit();			 
		    
		} catch (HibernateException e) {			
			transaction.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
	
	

	@Override
	@SuppressWarnings("unchecked")
	public List<LineaPedido> masComprados() {

		List<LineaPedido> lp= hibernateTemplate.find ("from LineaPedido group by producto order by Sum(cantidad) desc");
		
		int numProductos=10;
		
		if(numProductos<=lp.size())
			return lp.subList(0,10);
		else
			return lp.subList(0, lp.size());
		
	}
	
}
