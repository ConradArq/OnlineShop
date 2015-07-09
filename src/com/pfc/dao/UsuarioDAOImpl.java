package com.pfc.dao;

import com.pfc.domain.Usuario;
import com.pfc.domain.Autoridades;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import java.util.List;

public class UsuarioDAOImpl implements UsuarioDAO{
	
	private HibernateTemplate hibernateTemplate;
    
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
	}	
	
	
	@Override
	public void saveUser(Usuario usuario){
		usuario.setEnabled(true);
		hibernateTemplate.save(usuario); 
		Autoridades autoridades=new Autoridades("ROLE_USER",usuario.getUsername());
	    hibernateTemplate.save(autoridades); 
	}	
	
	@Override
	public void updateUser(Usuario usuario){
		usuario.setEnabled(true);
		hibernateTemplate.update(usuario); 
	}	
	
	@Override	
	@SuppressWarnings("unchecked")
	public List<Usuario> listUser(String username){
		return hibernateTemplate.find("from Usuario where username=?",username);
	}

}
