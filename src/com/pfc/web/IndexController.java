package com.pfc.web;

import java.util.*;
import java.lang.Integer;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pfc.dao.ProductoDAO;
import com.pfc.dao.UsuarioDAO;
import com.pfc.dao.PedidoDAO;
import com.pfc.domain.Usuario;
import com.pfc.domain.Producto;
import com.pfc.domain.LineaPedido;
import com.pfc.domain.Pedido;
import com.pfc.domain.UsuarioValidator;

public class IndexController{

	private ProductoDAO productoDAO;
	private UsuarioDAO usuarioDAO;
	private PedidoDAO pedidoDAO;
	private UsuarioValidator usuarioValidator;
	
	public void setProductoDAO(ProductoDAO productoDAO){
		this.productoDAO = productoDAO;
	}
	
	public void setUsuarioDAO(UsuarioDAO usuarioDAO){
		this.usuarioDAO = usuarioDAO;
	}
	
	public void setPedidoDAO(PedidoDAO pedidoDAO){
		this.pedidoDAO = pedidoDAO;
	}
	
	@Autowired	
	public IndexController(UsuarioDAO usuarioDAO, ProductoDAO productoDAO, PedidoDAO pedidoDAO, UsuarioValidator usuarioValidator) {
		this.productoDAO = productoDAO;
		this.usuarioValidator = usuarioValidator;
		this.usuarioDAO = usuarioDAO;
		this.pedidoDAO = pedidoDAO;
	}

	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelMap modelMap = new ModelMap();			
     
		datosUsuarioCarrito(request,modelMap);
		
		modelMap.addAttribute("autoayuda", productoDAO.listaProductoPorCategoriaCarousel("Autoayuda"));
		modelMap.addAttribute("ficcion", productoDAO.listaProductoPorCategoriaCarousel("Ficcion"));
		modelMap.addAttribute("didacticos", productoDAO.listaProductoPorCategoriaCarousel("Didacticos"));
		
		modelMap.addAttribute("vistaIndex", "vistaIndex");
        modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
		return new ModelAndView("index",modelMap);
	}	
	
	
	/* INFORMACIÓN DETALLADA DE DEL PRODUCTO */
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView info_producto(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelMap modelMap = new ModelMap();			
     
		datosUsuarioCarrito(request,modelMap);
		
		String idproductos=request.getParameter("id_producto");
		
		if((idproductos!=null)&&(!idproductos.equals(""))&&isInteger(idproductos))
			modelMap.addAttribute("info_producto", productoDAO.getProducto(Integer.parseInt(idproductos)));

		
        modelMap.addAttribute("masComprados", pedidoDAO.masComprados());		
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
		return new ModelAndView("index",modelMap);
	}
	
	
	/* REGISTRO */
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView registro(HttpServletRequest request, HttpServletResponse response,  @ModelAttribute("usuario") Usuario usuario, BindingResult result) throws Exception {
		
		ModelMap modelMap = new ModelMap();		

		datosUsuarioCarrito(request,modelMap);
		
		HttpSession sesion = request.getSession(); 
		Object context=sesion.getAttribute("SPRING_SECURITY_CONTEXT");
		
		if(context!=null)
			response.sendRedirect("micuenta.htm");
		else
	        modelMap.addAttribute("registro", "registro");
		
		
        modelMap.addAttribute("masComprados", pedidoDAO.masComprados());	        
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
		return new ModelAndView("index",modelMap);
		
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView registro_onsubmit(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("usuario") Usuario usuario, BindingResult result) throws Exception {
		
		usuarioValidator.validate(usuario, result);
		boolean passwordsIguales=request.getParameter("cpassword").equals(usuario.getPassword());
		
		ModelMap modelMap = new ModelMap();
		
		datosUsuarioCarrito(request,modelMap);
        
        modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
        
		if (result.hasErrors() || !passwordsIguales){
			if(!passwordsIguales)
				request.setAttribute("cpassword", "Las contraseñas no coinciden");				
	        modelMap.addAttribute("registro", "registro");	        
			return new ModelAndView("index",modelMap);
		}else if (usuarioDAO.listUser(usuario.getUsername()).size() != 0){
	        modelMap.addAttribute("registro", "registro");	
	        modelMap.addAttribute("email_usado", "El Email introducido ya esta en uso");	        
			return new ModelAndView("index",modelMap);			
		}else{	
			usuarioDAO.saveUser(usuario);
	        modelMap.addAttribute("login", "login");
	        modelMap.addAttribute("registro_exito", "Enhorabuena se ha registrado con éxito,<br>introduzca su email y su contraseña a continuación para poder acceder a su cuenta."); 
	        return new ModelAndView("index",modelMap);
		}
	}

	/* FIN REGISTRO */
	
	/* LOGIN */
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("usuario") Usuario usuario, BindingResult result) throws Exception {
		
		ModelMap modelMap = new ModelMap(); 
		
		datosUsuarioCarrito(request,modelMap);
			
        modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("login", "login");
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());  
        return new ModelAndView("index",modelMap);
	
	}
	
	
	/* CONTROLADORES VISTAS MI CUENTA Y MI CESTA */
	
	/* MI CUENTA */
	
	/* MI CUENTA > MI CUENTA (ACTUALIZAR DATOS) */
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView micuenta(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("usuario") Usuario usuario, BindingResult result) throws Exception {
		ModelMap modelMap = new ModelMap();	
		
		datosUsuarioCarrito(request,modelMap);
		
		HttpSession sesion = request.getSession(); 
		String username=(String) sesion.getAttribute("SPRING_SECURITY_LAST_USERNAME");
		
		modelMap.addAttribute("datos_usuario",usuarioDAO.listUser(username).get(0));
		
		modelMap.addAttribute("miCuenta", "miCuenta");	
		modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
        return new ModelAndView("index",modelMap);
	}
	
	/* MI CUENTA > MI CUENTA (ACTUALIZAR DATOS ONSUBMIT) */	
	
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView micuenta_onsubmit(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("usuario") Usuario usuario, BindingResult result) throws Exception {
		
		usuarioValidator.validate(usuario, result);
		boolean passwordsIguales=request.getParameter("cpassword").equals(usuario.getPassword());
		
		ModelMap modelMap = new ModelMap();
		HttpSession sesion = request.getSession();    
		boolean passwordAntiguo=false;
		
        String username=(String) sesion.getAttribute("SPRING_SECURITY_LAST_USERNAME");            
    	modelMap.addAttribute("datos_usuario",usuario);
    	if((usuarioDAO.listUser(username).size())>0)
    		passwordAntiguo=usuarioDAO.listUser(username).get(0).getPassword().equals(request.getParameter("apassword"));		
          
        
		datosUsuarioCarrito(request,modelMap);
        
        modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
        
		if (result.hasErrors() || !passwordsIguales || !passwordAntiguo){
			if(!passwordAntiguo)
				request.setAttribute("apassword", "Introduzca su contraseña correctamente");
			if(!passwordsIguales)
				request.setAttribute("cpassword", "Las contraseñas no coinciden");				
	        modelMap.addAttribute("miCuenta", "miCuenta");	        
			return new ModelAndView("index",modelMap);
		}else{	
			usuario.setUsername(username);
			usuarioDAO.updateUser(usuario);
	        modelMap.addAttribute("miCuenta", "miCuenta");
	        modelMap.addAttribute("modificar_micuenta_exito", "Sus datos se actualizaron correctamente.");
			return new ModelAndView("index",modelMap);
		}
	}


	
	// MI CUENTA > MIS PEDIDOS 
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView mispedidos(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelMap modelMap = new ModelMap();	
		
		HttpSession sesion = request.getSession();		
		String username=(String) sesion.getAttribute("SPRING_SECURITY_LAST_USERNAME");
		
		datosUsuarioCarrito(request,modelMap);
		
		//PAGINACION DE RESULTADOS
		
		int paginaActual;		
		int resultadosPorPagina=7; // >0 Introducimos el numero de resultados que se mostraran por pagina
		int numPaginasPorBloque=4; // >0 Introducimos el numero de paginas que habra en cada bloque 
		
		String idpedido=request.getParameter("idpedido");
		
        if(idpedido!=null && (!idpedido.equals(""))&&isInteger(idpedido)){      	
        	int id_pedido= Integer.parseInt(idpedido);          
        	if(pedidoDAO.getPedidoByIdpedido(id_pedido)!=null){
	        	if(pedidoDAO.getPedidoByIdpedido(id_pedido).getUsuario().getUsername().equals(username)){      	
		    		modelMap.addAttribute("detalle_pedido", pedidoDAO.getPedidoByIdpedido(id_pedido).getLineasPedido());
		    		modelMap.addAttribute("detalle_pedido_pedido", pedidoDAO.getPedidoByIdpedido(id_pedido));
		    		modelMap.addAttribute("id_pedido",id_pedido);
	        	}
        	}
        }else{
        	int numProductos=pedidoDAO.listPedidos(username).size();
        	
    		String pagina=(request.getParameter("pagina"));
    		
    		if((pagina!=null)&&(!pagina.equals(""))&&isInteger(pagina))
    			paginaActual=Integer.parseInt(pagina);
    		else
    			paginaActual=1;
		
        	paginarResultados(paginaActual,numPaginasPorBloque, numProductos, resultadosPorPagina, modelMap);
        	modelMap.addAttribute("misPedidos", pedidoDAO.listaPagPedidos(username,paginaActual,resultadosPorPagina));
        }
        
		modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
		return new ModelAndView("index",modelMap);
	}
	

	
	// MI CESTA 
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView micesta(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelMap modelMap = new ModelMap();	
		HttpSession sesion = request.getSession();	
		
		SimpleDateFormat formateador = new SimpleDateFormat("d'-'M'-'yyyy", new Locale("es_ES"));		
		Date fechaDate = new Date();		
		String fecha = formateador.format(fechaDate);
		 
		String username=(String) sesion.getAttribute("SPRING_SECURITY_LAST_USERNAME");
		       
        String paso=request.getParameter("paso");
        if(paso!=null && (!paso.equals(""))){
        	//MI CESTA > DIRECCION
	        if(paso.equals("1")){
	        	modelMap.addAttribute("direccion_entrega", usuarioDAO.listUser(username).get(0));
	        	modelMap.addAttribute("midireccion", "midireccion");
	        }
	        //MI CESTA > PAGO
	        if(paso.equals("2"))
	        	modelMap.addAttribute("pago", "pago");
	        
	        //MI CESTA > CONFIRMAR
	        if(paso.equals("confirmar")){
	        	
	        	pedidoDAO.addPedido(username,fecha);        
	        	modelMap.addAttribute("confirmar_pedido", "confirmar_pedido");       	
	        	
	        	List<Pedido> p=pedidoDAO.listPedidos(username);
	        	
	         	if(p.size()>0){
	         		List<LineaPedido> lp=p.get(0).getLineasPedido();	         		
		            modelMap.addAttribute("carrito_importe_confirmado", (double)((long)((Double.parseDouble(getPrecioCantidadPedido(lp).get(0))+5.22)*100))/100);    
	    	    }else
		            modelMap.addAttribute("carrito_importe_confirmado", 0);   	    	    	
	        	
	        }	        
	        
	        
	    //MI CESTA >RESUMEN    
        }else 
        	modelMap.addAttribute("carrito", "carrito");

       
		datosUsuarioCarrito(request,modelMap);
		
		modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
		return new ModelAndView("index",modelMap);
	}
	
	
	
	// MI CESTA > RESUMEN (OPERACIONES CON CESTA DE LA COMPRA) 
	
	// AÑADIR PRODUCTO A LA CESTA 
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView add_cesta(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelMap modelMap = new ModelMap();
		String idproducto=request.getParameter("idproductos");
		
		HttpSession sesion = request.getSession();		
		String username=(String) sesion.getAttribute("SPRING_SECURITY_LAST_USERNAME");
		
        
        if(idproducto!=null && !idproducto.equals("")&&isInteger(idproducto)){
        	
        	Producto p=productoDAO.getProducto(Integer.parseInt(idproducto));
        	
        	if(p!=null){
	        	if(p.getCantidad()>0)
	        		pedidoDAO.addProductosCarrito(username, Integer.parseInt(idproducto));
	        	else
	        		modelMap.addAttribute("producto_agotado", "producto_agotado");
        	}
        	
        }
        	
        	
        datosUsuarioCarrito(request,modelMap);
        	

		modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("carrito", "carrito");
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
		return new ModelAndView("index",modelMap);
	}
	
	
	// RESTAR PRODUCTO A LA CESTA 
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView restar_cesta(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelMap modelMap = new ModelMap();
		String idproducto=request.getParameter("idproductos");
		
		HttpSession sesion = request.getSession();		
		String username=(String) sesion.getAttribute("SPRING_SECURITY_LAST_USERNAME");
		
		
		 if(idproducto!=null && !idproducto.equals("")&&isInteger(idproducto)){
	        	
	        	Producto p=productoDAO.getProducto(Integer.parseInt(idproducto));
	        	
	        	if(p!=null)
		        	pedidoDAO.restaProductosCarrito(username, Integer.parseInt(idproducto));
	        	
	     }
		
		datosUsuarioCarrito(request,modelMap);		
         

		modelMap.addAttribute("masComprados", pedidoDAO.masComprados());	
        modelMap.addAttribute("carrito", "carrito");
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
		return new ModelAndView("index",modelMap);
	}
	
	
	// BORRAR PRODUCTO DE LA CESTA 
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView borrar_producto(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelMap modelMap = new ModelMap();
		String idproducto=request.getParameter("idproductos");
		
		HttpSession sesion = request.getSession();		
		String username=(String) sesion.getAttribute("SPRING_SECURITY_LAST_USERNAME");
		
		
		 if(idproducto!=null && !idproducto.equals("")&&isInteger(idproducto)){
	        	
	        	Producto p=productoDAO.getProducto(Integer.parseInt(idproducto));
	        	
	        	if(p!=null)
		        	pedidoDAO.borrarProductosCarrito(username, Integer.parseInt(idproducto));
	        	
	     }
		
        
        datosUsuarioCarrito(request,modelMap);	
         
		modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("carrito", "carrito");
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());
		return new ModelAndView("index",modelMap);
	}

	
	/* FIN OPERACIONES CON CESTA DE LA COMPRA */	
	
	
	/* BUSCAR */
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView buscar(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelMap modelMap = new ModelMap();		
		
	    int paginaActual;		
		int resultadosPorPagina=5; //>0 Introducimos el numero de resultados que se mostraran por pagina
		int numPaginasPorBloque=3; //>0 Introducimos el numero de paginas que habra en cada bloque 
		
		datosUsuarioCarrito(request,modelMap);
		
	    if(request.getParameter("campo_busqueda")!=null){
			if(request.getParameter("campo_busqueda").isEmpty()){
				modelMap.addAttribute("resultado_busqueda", "");
				modelMap.addAttribute("cantidad_producto_busqueda","0");			
			}else{
				
				int numProductos=productoDAO.buscarProducto(request.getParameter("campo_busqueda")).size();
				
				String pagina=(request.getParameter("pagina"));
				
				if((pagina!=null)&&(!pagina.equals(""))&&isInteger(pagina))
					paginaActual=Integer.parseInt(pagina);
				else
					paginaActual=1;
		    	
				
				paginarResultados(paginaActual,numPaginasPorBloque, numProductos, resultadosPorPagina, modelMap);
				
				modelMap.addAttribute("resultado_busqueda", productoDAO.listaPagBuscarProducto(request.getParameter("campo_busqueda"), paginaActual, resultadosPorPagina));	
				modelMap.addAttribute("parametro_busqueda", request.getParameter("campo_busqueda"));
				modelMap.addAttribute("cantidad_producto_busqueda", numProductos);				
			}
			
	    }else if(request.getParameter("categoria")!=null){
	    	
	    	int numProductos=productoDAO.listaProductoPorCategoria(request.getParameter("categoria")).size();
	    	
			String pagina=(request.getParameter("pagina"));
			
			if((pagina!=null)&&(!pagina.equals(""))&&isInteger(pagina))
				paginaActual=Integer.parseInt(pagina);
			else
				paginaActual=1;
	    	
			
			paginarResultados(paginaActual,numPaginasPorBloque, numProductos, resultadosPorPagina, modelMap);
			
			modelMap.addAttribute("categoria", request.getParameter("categoria"));	
	    	modelMap.addAttribute("resultado_busqueda_categoria", productoDAO.listaPagProductoPorCategoria(request.getParameter("categoria"), paginaActual, resultadosPorPagina));
			modelMap.addAttribute("cantidad_producto_busqueda_categoria", numProductos);	    
		
	    
	    }else if(request.getParameter("campo_busqueda")==null){
			modelMap.addAttribute("resultado_busqueda", "");
			modelMap.addAttribute("cantidad_producto_busqueda","0");		
	    }
	
	    
        modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());   
		return new ModelAndView("index",modelMap);
	}	
	
	
	/* BUSQUEDA AVANZADA */
	
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView avanzada(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelMap modelMap = new ModelMap();		
		
	    int paginaActual;		
		int resultadosPorPagina=2; //>0 Introducimos el numero de resultados que se mostraran por pagina
		int numPaginasPorBloque=2; //>0 Introducimos el numero de paginas que habra en cada bloque 
		
		datosUsuarioCarrito(request,modelMap);
		
		String titulo=request.getParameter("titulo");
		String autor=request.getParameter("autor");
		String ISBN=request.getParameter("ISBN");
		String editorial=request.getParameter("editorial");
		
		modelMap.addAttribute("titulo", titulo);
		modelMap.addAttribute("autor", autor);
		modelMap.addAttribute("ISBN", ISBN);
		modelMap.addAttribute("editorial", editorial);
			
		int numProductos=productoDAO.buscarProductoAvanzada(titulo, autor, ISBN, editorial).size();
		
		String pagina=(request.getParameter("pagina"));
		
		if((pagina!=null)&&(!pagina.equals(""))&&isInteger(pagina))
			paginaActual=Integer.parseInt(pagina);
		else
			paginaActual=1;
    	
		
		paginarResultados(paginaActual,numPaginasPorBloque, numProductos, resultadosPorPagina, modelMap);
		
		
		boolean busqueda_onsubmit =!(titulo==null && autor==null && ISBN==null && editorial==null);
		modelMap.addAttribute("busqueda_onsubmit", busqueda_onsubmit);
		
		
		modelMap.addAttribute("cantidad_producto_busqueda_avanzada", numProductos);
		modelMap.addAttribute("resultado_busqueda_avanzada", productoDAO.listaPagbuscarProductoAvanzada(titulo, autor, ISBN, editorial, paginaActual, resultadosPorPagina));	
		
		
        modelMap.addAttribute("avanzada", "login");
        modelMap.addAttribute("masComprados", pedidoDAO.masComprados());
        modelMap.addAttribute("ofertasList", productoDAO.ofertasProducto());   
		return new ModelAndView("index",modelMap);
	}
	
	//FUNCION COMPROBAR SI UNA CADENA SE PUEDE PARSEAR A INTEGER
	
    public boolean isInteger( String cadena )  
    {  
       try  
       {  
          Integer.parseInt( cadena );  
          return true;  
       }  
       catch(NumberFormatException nfe)  
       {  
          return false;  
       }  
    }  
	
	
	// FUNCIÓN PARA PONER EL NOMBRE DE USUARIO EN LA CABECERA Y LOS VALORES DEL CARRITO
	public void datosUsuarioCarrito(HttpServletRequest request, ModelMap modelMap){
		
		HttpSession sesion = request.getSession();    
		
		String username=(String) sesion.getAttribute("SPRING_SECURITY_LAST_USERNAME");    
		
		Object context=sesion.getAttribute("SPRING_SECURITY_CONTEXT");
		
	    if(context!=null){
	    	if((usuarioDAO.listUser(username).size())>0){
	    		modelMap.addAttribute("nombre", usuarioDAO.listUser(username).get(0).getNombre()); 	
	    		if(pedidoDAO.getPedidoCarrito(username)!=null){
	    			List<LineaPedido> lp=pedidoDAO.getPedidoCarrito(username).getLineasPedido();
		    		modelMap.addAttribute("productos_carrito", lp);
		    		List<String> l=getPrecioCantidadPedido(lp);
		            modelMap.addAttribute("carrito_importe", l.get(0));
		            modelMap.addAttribute("cantidad_libros_carrito", l.get(1));
		        }else{
		        	modelMap.addAttribute("carrito_importe", 0);
	            	modelMap.addAttribute("cantidad_libros_carrito", 0);
	    		}
	    	}
	    }else{
	    	modelMap.addAttribute("carrito_importe", 0);
	    	modelMap.addAttribute("cantidad_libros_carrito", 0);
	    }
         
	  
	}
	
	//FUNCION PARA CALCULAR EL PRECIO TOTAL DE UN CARRITO O PEDIDO Y LA CANTIDAD DEL PRODUCTOS
	
	public List<String> getPrecioCantidadPedido(List<LineaPedido> lineaPedido){
		double importe_total=0;
		int cantidad_total=0;
		for(LineaPedido lp:lineaPedido){
			importe_total=importe_total+lp.getPrecio()*lp.getCantidad();
			cantidad_total=cantidad_total+lp.getCantidad();
		} 
		long importePedidoTrunc=(long)(importe_total*100);	
		importe_total=(double)importePedidoTrunc/100;
		List<String> ls= new ArrayList();
		ls.add(Double.toString(importe_total));
		ls.add(Integer.toString(cantidad_total));
		return ls;
	}
	
	//FUNCION PARA PAGINAR RESULTADOS DE BUSQUEDA EN EL JSP
	
	public void paginarResultados(int paginaActual, int numPaginasPorBloque, int numProductos, int resultadosPorPagina, ModelMap modelMap){
	
		//Numero de paginas totales
		int numDePaginas=numProductos/resultadosPorPagina;
		
		if((numProductos%resultadosPorPagina)!=0)
			numDePaginas=numDePaginas+1;
		
		int pagina_inicial_bloque;
		
		//Calculamos a partir de una pagina que llega en la url, la pagina primera del bloque al que pertenece
		if((paginaActual%numPaginasPorBloque)==0){
			pagina_inicial_bloque=paginaActual-(numPaginasPorBloque-1);
		}else{
		    pagina_inicial_bloque=((paginaActual/numPaginasPorBloque)*numPaginasPorBloque)+1;
		}
		//Pagina final del bloque
		int pagina_final_bloque=pagina_inicial_bloque+(numPaginasPorBloque-1);
		
		modelMap.addAttribute("pagina_inicial_bloque", pagina_inicial_bloque);
		modelMap.addAttribute("pagina_final_bloque", pagina_final_bloque);
		
		modelMap.addAttribute("paginaActual", paginaActual);
		modelMap.addAttribute("numDePaginas", numDePaginas);
	}
	
}