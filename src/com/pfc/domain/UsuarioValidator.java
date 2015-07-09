package com.pfc.domain;

import org.springframework.validation.Validator;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import com.pfc.domain.Usuario;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UsuarioValidator implements Validator{
	
	@Override
    public boolean supports(Class clazz) {
    	return Usuario.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
	    
	     Usuario usuario = (Usuario) target;
	     Pattern p,p1,p2;
	     Matcher m,m1,m2;
	     
	     if(!usuario.getUsername().equals("")){
	    	 if(usuario.getUsername().length()>80)
	    		 errors.rejectValue("username","email.longitud");
	    	 else{
	    		 p1 = Pattern.compile("@\\w+([.-]?\\w+)*(\\.\\w{2,3})+$");
			     p2 = Pattern.compile("^\\w+([.-]?\\w+)*@");
			     m1 = p1.matcher(usuario.getUsername());
			     m2 = p2.matcher(usuario.getUsername());			     
			     if (!(m1.find()&& m2.find()))
		        	errors.rejectValue("username","email.incorrecto"); 
	    	 }   
	     }else
	    	 errors.rejectValue("username","email.requerido");
	     
	     if(!usuario.getPassword().equals("")){
	    	 if(usuario.getPassword().length()>45)
	    		 errors.rejectValue("password","password.longitud");
	    	 else{
			     p = Pattern.compile("^\\w{6,}");
			     m = p.matcher(usuario.getPassword());
			     if(!m.find())
	    	     	 errors.rejectValue("password","password.incorrecto"); 
	    	 }
	     }else
	    	 errors.rejectValue("password","password.requerido");

	     if(usuario.getNombre().equals(""))
	    	 errors.rejectValue("nombre","nombre.requerido");
	     else if (usuario.getNombre().length()>45)
	    		 errors.rejectValue("nombre","nombre.longitud");	
	     
	     if(usuario.getApellidos().equals(""))
	    	 errors.rejectValue("apellidos","apellidos.requerido");
	     else if (usuario.getApellidos().length()>45)
	    		 errors.rejectValue("apellidos","apellidos.longitud");

	     if(usuario.getDireccion().equals(""))
	    	 errors.rejectValue("direccion","direccion.requerido");
	     else if (usuario.getDireccion().length()>45)
	    		 errors.rejectValue("direccion","direccion.longitud");
	     
	     if (usuario.getTelefono().length()>45)
	    	 errors.rejectValue("telefono","telefono.longitud");     
	     
	     if(usuario.getCodigo_postal().equals(""))
	    	 errors.rejectValue("codigo_postal","codigo_postal.requerido");
	     else if (usuario.getCodigo_postal().length()>45)
	    		 errors.rejectValue("codigo_postal","codigo_postal.longitud");

	     
	     ValidationUtils.rejectIfEmpty(errors, "pais", "pais.requerido"); 
	     
	     if (usuario.getSexo()!=null){
		     if (usuario.getSexo().length()>45)
		    	 errors.rejectValue("sexo","longitud");
		     }

	     if (usuario.getDia_nacimiento()!=null){	     
		     if (usuario.getDia_nacimiento().length()>45)
		    	 errors.rejectValue("dia_nacimiento","longitud");
	     }   
	     
	     if (usuario.getMes_nacimiento()!=null){	     
		     if (usuario.getMes_nacimiento().length()>45)
		    	 errors.rejectValue("mes_nacimiento","longitud");	  
	     }
		    
	     if (usuario.getAno_nacimiento()!=null){	  	     
		     if (usuario.getAno_nacimiento().length()>45)
		    	 errors.rejectValue("ano_nacimiento","longitud");		
	     }
	     
	     if (usuario.getPais()!=null){	  	     
		     if (usuario.getPais().length()>45)
		    	 errors.rejectValue("pais","longitud");	
	     }
	     
	     if(usuario.getProvincia().equals("") && usuario.getPais().equals("España"))
	    	     errors.rejectValue("provincia","provincia.requerido");
	     else if(usuario.getProvincia().length()>45)     
		    	 errors.rejectValue("provincia","longitud");
	     
    }
    
    
}
