<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Tu libreria virtual</title>
	
	<link rel="stylesheet" type="text/css"  href="css/estilo_global.css"/>
    
	<script type="text/javascript" src="js/jquery-1.2.6.js"></script>
    <script type="text/javascript" src="js/jcarousellite_1.0.1.js"></script>

    <script type="text/javascript">
    
      $(function() {
          $(".carousel_mascomprados").jCarouselLite({
            vertical:   true,
            hoverPause: true, 
            visible:    4,
            auto:       2000,
            speed:      2000   		   });
        });
      
      $(function() {
          $(".carousel_categorias").jCarouselLite({
            vertical:   false,
            visible:    6,
            speed:      1000,   		
            btnNext: ".next",
            btnPrev: ".prev"
            });
        });
      
      $(function() {
          $(".carousel_categorias2").jCarouselLite({
            vertical:   false,
            visible:    6,
            speed:      1000,   		
            btnNext: ".next2",
            btnPrev: ".prev2"
            });
        });
  
      $(function() {
          $(".carousel_categorias3").jCarouselLite({
            vertical:   false,
            visible:    6,
            speed:      1000,   		
            btnNext: ".next3",
            btnPrev: ".prev3"
            });
        });
      function makevisible(cur,which){
    	  strength=(which==0)? 1 : 0.8;

		  if (cur.filters)
    	  	cur.filters.alpha.opacity=strength*100;
      }      
      
      </script>
	   
</head>
<body>
<div id="capaPrincipal">
	
	
	<!-- CAPA IZQUIERDA -->
	
	<!-- CATEGORIAS DE PRODUCTOS -->

	<div id="capaIzquierda">
		<div class="bloques_tags">
			<h4>CATEGORÍAS</h4>
		
			<div class="bloque_contenido">
				<ul>
					<li><a href="buscar.htm?categoria=Autoayuda">Autoayuda</a></li>
					<li><a href="buscar.htm?categoria=Aventuras">Aventuras</a></li>		
					<li><a href="buscar.htm?categoria=Ciencia">Ciencia</a></li>	
					<li><a href="buscar.htm?categoria=Ficcion">Ficción</a></li>										
					<li><a href="buscar.htm?categoria=Didacticos">Didácticos</a></li>		
					<li><a href="buscar.htm?categoria=Drama">Drama</a></li>						
					<li><a href="buscar.htm?categoria=Historicos">Históricos</a></li>									
					<li><a href="buscar.htm?categoria=Suspense">Suspense</a></li>
					<li><a href="buscar.htm?categoria=Terror">Terror</a></li>													
				</ul>
			</div>	
		</div>
		
		<!-- CARRUSEL -->
		
		<c:if test="${fn:length(masComprados) > 3}">
			<div id="bloque_mas_comprados" class="bloques_tags">
				<h4>LOS MÁS COMPRADOS</h4>
				<div class="carousel_mascomprados">
					<ul>
						<c:forEach items="${masComprados}" var="producto" varStatus="status">
							<li>									
								<div class="imagen_libro_portada">
									<a href="info_producto.htm?id_producto=${producto.producto.idproductos}">			
										<c:if test="${producto.producto.URL_portada!=null and producto.producto.URL_portada!=''}">  
											<img src="${producto.producto.URL_portada}"/>
										</c:if>
										<c:if test="${producto.producto.URL_portada==null or producto.producto.URL_portada==''}">
											<img src="img/portadas_libros/portada_no_disponible.jpg"/>
										</c:if>
									</a>								
								</div>
								<div class="carousel_texto_flotante">
									<div class="titulo_carousel"><a href="info_producto.htm?id_producto=${producto.producto.idproductos}">${producto.producto.producto}</a></div> 
									<div class="autor_carousel">${producto.producto.autor}</div>
									<div class="fecha_carousel">${producto.producto.fecha_edicion}</div>
								</div>														
							</li>
						</c:forEach>																				
					</ul>				
				</div>
			</div>
		</c:if>
	</div>
	

	<!-- CABECERA -->
		
	<div id="cabecera">
		<div id="busqueda">
			<form id="form_busqueda" action="buscar.htm" method="get">
				<input id="campo_busqueda" type="text" name="campo_busqueda" value="${parametro_busqueda}">
				<input class="button_buscar" type="submit" value="Buscar" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">
			</form>	
			
			<div id="busqueda_avanzada"><a href="avanzada.htm">Búsqueda avanzada »</a></div>
			
		</div>	
			
		<div id="registro_identificacion">
			<div>Hola, ¿eres nuevo? <a href="registro.htm">¡Regístrate ya!</a> </div>
			<div><a href="login.htm">Identificarse</a></div>
		</div>
		
		<sec:authorize ifAllGranted="ROLE_USER">
			<div id="usuario_cabecera">
				<span class="bienvenida">Bienvenido,<span class="nombre_bienvenida">${nombre}</span></span> <a href="<c:url value='/j_spring_security_logout'/>">(Salir)</a>
				<div id="cesta_cuenta_cabecera"><a href ="micuenta.htm">Mi cuenta</a> | <a href ="micesta.htm">Mi cesta</a></div>
			</div>
		</sec:authorize>
	</div>
	
	
	<!-- CAPA CENTRO -->

	<!-- VISTA INDEX DE TODOS LOS PRODUCTOS -->
	
	<c:if test="${vistaIndex!=null}">    

		<div class="capaCentro">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span></div>
			<div class="titulo">
			<a href="index.htm"><img src="img/titulo.gif" title="titulo" alt="titulo"/></a>
			</div>
			
			<div class="descripcion">
			Bienvenido a tu tienda de libros online. Aqui encontrarás toda clase de libros al mejor precio. Encuentra los libros que buscas a sólo un click. <a href="registro.htm">Regístrate</a> ya y comienza la compra! Puedes añadir a tu carrito de la compra tantos libros como desees siempre que haya existencias, ¿a qué esperas?
			</div>		
			
			<!-- LISTADO DE NOVEDADES POR CATEGORIAS -->

			<div class="cabeceraform cabeceraform_index"><img src="img/flecha_abajo.jpg"/>Novedades: Libros de Autoayuda <span class="ver_mas"><a href="buscar.htm?categoria=Autoayuda">Ver más »</a></span></div>			
			<c:if test="${fn:length(autoayuda) > 5}">
			
				<div class="carousel_categorias">
					<ul>
						<c:forEach items="${autoayuda}" var="producto" varStatus="status">
							<li>									
									<div class="imagen_libro_portada">
										<a href="info_producto.htm?id_producto=${producto.idproductos}">			
											<c:if test="${producto.URL_portada!=null  and producto.URL_portada!=''}">  
												<img src="${producto.URL_portada}"/>
											</c:if>
											<c:if test="${producto.URL_portada==null or producto.URL_portada==''}">
												<img src="img/portadas_libros/portada_no_disponible.jpg"/>
											</c:if>
										</a>								
									</div>												
									
									<div class="datos_libro">
										<div class="titulo_libro"><a href="info_producto.htm?id_producto=${producto.idproductos}">${producto.producto}</a></div>
										<div class="autor_libro">${producto.autor}</div>					
										<div class="precio_libro">${producto.precio}&#8364;</div>	
										<div class="disponiblidad">		
											<c:if test="${producto.cantidad > 0}">
												<img src="img/button_verde.jpg"/><span class="disponible">Disponible</span>
											</c:if>
											<c:if test="${producto.cantidad == 0}">
												<img src="img/button_rojo.jpg"/><span class="no_disponible">No disponible</span>
											</c:if>
									    </div>	
									</div>	
										
									<div class="add_cesta_index"><a href="add_cesta.htm?idproductos=${producto.idproductos}"><img src="img/AddCesta.jpg" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;"/></a></div>										
							</li>
						</c:forEach>																				
					</ul>
				<img class="prev" src="img/flecha_izquierda.png"/>
				<img class="next" src="img/flecha_derecha.png"/>
				</div>
							
			</c:if>	

			<div class="cabeceraform cabeceraform_index"><img src="img/flecha_abajo.jpg"/>Novedades: Libros de Ficción <span class="ver_mas"><a href="buscar.htm?categoria=Ficcion">Ver más » </a></span></div>			
			<c:if test="${fn:length(ficcion) > 5}">
			
				<div class="carousel_categorias2">
					<ul>
						<c:forEach items="${ficcion}" var="producto" varStatus="status">
							<li>								
									<div class="imagen_libro_portada">
										<a href="info_producto.htm?id_producto=${producto.idproductos}">			
											<c:if test="${producto.URL_portada!=null and producto.URL_portada!=''}">  
												<img src="${producto.URL_portada}"/>
											</c:if>
											<c:if test="${producto.URL_portada==null or producto.URL_portada==''}">
												<img src="img/portadas_libros/portada_no_disponible.jpg"/>
											</c:if>
										</a>								
									</div>												
									
									<div class="datos_libro">
										<div class="titulo_libro"><a href="info_producto.htm?id_producto=${producto.idproductos}">${producto.producto}</a></div>
										<div class="autor_libro">${producto.autor}</div>					
										<div class="precio_libro">${producto.precio}&#8364;</div>	
										<div class="disponiblidad">		
											<c:if test="${producto.cantidad > 0}">
												<img src="img/button_verde.jpg"/><span class="disponible">Disponible</span>
											</c:if>
											<c:if test="${producto.cantidad == 0}">
												<img src="img/button_rojo.jpg"/><span class="no_disponible">No disponible</span>
											</c:if>
									    </div>	
									</div>		
									<div class="add_cesta_index"><a href="add_cesta.htm?idproductos=${producto.idproductos}"><img src="img/AddCesta.jpg" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;"/></a></div>																	
							</li>
						</c:forEach>																				
					</ul>
				<img class="prev2" src="img/flecha_izquierda.png"/>
				<img class="next2" src="img/flecha_derecha.png"/>
				</div>
							
			</c:if>	

			<div class="cabeceraform cabeceraform_index"><img src="img/flecha_abajo.jpg"/>Novedades: Libros Didácticos <span class="ver_mas"><a href="buscar.htm?categoria=Didacticos"> Ver más » </a></span></div>				
			<c:if test="${fn:length(didacticos) > 5}">
			
				<div class="carousel_categorias3">
					<ul>
						<c:forEach items="${didacticos}" var="producto" varStatus="status">
							<li>									
								<div class="imagen_libro_portada">
									<a href="info_producto.htm?id_producto=${producto.idproductos}">			
										<c:if test="${producto.URL_portada!=null and producto.URL_portada!=''}">  
											<img src="${producto.URL_portada}"/>
										</c:if>
										<c:if test="${producto.URL_portada==null or producto.URL_portada==''}">
											<img src="img/portadas_libros/portada_no_disponible.jpg"/>
										</c:if>
									</a>								
								</div>												
								
								<div class="datos_libro">
									<div class="titulo_libro"><a href="info_producto.htm?id_producto=${producto.idproductos}">${producto.producto}</a></div>
									<div class="autor_libro">${producto.autor}</div>					
									<div class="precio_libro">${producto.precio}&#8364;</div>	
									<div class="disponiblidad">		
										<c:if test="${producto.cantidad > 0}">
											<img src="img/button_verde.jpg"/><span class="disponible">Disponible</span>
										</c:if>
										<c:if test="${producto.cantidad == 0}">
											<img src="img/button_rojo.jpg"/><span class="no_disponible">No disponible</span>
										</c:if>
								    </div>	
								</div>		
								<div class="add_cesta_index"><a href="add_cesta.htm?idproductos=${producto.idproductos}"><img src="img/AddCesta.jpg" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;"/></a></div>																			
							</li>
						</c:forEach>																				
					</ul>
				<img class="prev3" src="img/flecha_izquierda.png"/>
				<img class="next3" src="img/flecha_derecha.png"/>
				</div>
							
			</c:if>	
		</div>			
	</c:if>
	
	
	<!-- VISTA INFO PRODUCTO -->
	
	<c:if test="${info_producto!=null}">  
			<div class="capaCentro">
				<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><span class="info_producto_cabecera"><a href="info_producto.htm?id_producto=${info_producto.idproductos}">${info_producto.producto}</a></span></div>
			
				<div id="portada_libro_info">		
						<c:if test="${info_producto.URL_portada!=null and info_producto.URL_portada!=''}">  
							<img src="${info_producto.URL_portada}"/>
						</c:if>
						<c:if test="${info_producto.URL_portada==null or info_producto.URL_portada==''}">
							<img src="img/portadas_libros/portada_no_disponible.jpg"/>
						</c:if>							
				</div>
				
				<div id="titulo_libro_info">${info_producto.producto}</div>
				<div id="autor_libro_info"><span class="detalles_libro_info">Autor: </span>${info_producto.autor}</div>
				<div id="editorial_libro_info"><span class="detalles_libro_info">Editorial: </span>${info_producto.editorial}</div>
				<div id="fecha_libro_info"><span class="detalles_libro_info">Fecha de edición: </span>${info_producto.fecha_edicion}</div>	
				<div id="ISBN_libro_info"><span class="detalles_libro_info">ISBN: </span>${info_producto.ISBN}</div>
				<div id="categoria_libro_info"><span class="detalles_libro_info">Categoría: </span>${info_producto.categoria}</div>				
				<div id="precio_libro_info">${info_producto.precio}&#8364;</div>
				<div id="imagen_AddCesta_libro_info"><a href="add_cesta.htm?idproductos=${info_producto.idproductos}"><img src="img/AddCesta.jpg" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;"/></a></div>	
						
			    <div class="cabeceraform"><img src="img/flecha_abajo.jpg"/><span>Resumen</span></div>
			    <div id="resumen_libro_info">${info_producto.descripcion}</div>
			    
			    <div class="boton_atras_div">
			  		<a class="boton_atras" href="javascript:history.back()" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">« Atrás </a>
				</div>
			</div>
	</c:if>
	
	
	<!-- VISTA REGISTRO -->
	
	<c:if test="${registro!=null}">   
	
			<jsp:include page="registro.jsp" />
			
	</c:if>
	
	
	<!-- VISTA LOGIN -->
	
	<c:if test="${login!=null}">    
		<div class="capaCentro">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="login.htm">Login</a></div>
			
			<!-- Mensaje que se muestra cuando un usuario se ha registrado satisfactoriamente y ve la página login.htm -->
			<c:if test="${registro_exito==null}" var="noRegistroExito"/>    
			<c:if test="${not noRegistroExito}">
				<div id="mensaje_login_exito_registro">${registro_exito}</div>
			</c:if>
			
			<!-- Mensaje que se muestra cuando falla el login -->
			<c:if test="${not empty param.login_error}">
		      	<div id="mensaje_cabecera_error">
			        La dirección de correo electrónico o la contraseña son incorrectas.<br/> Por favor, vuelva a intentarlo. 
		     	</div> 
		    </c:if>
		    
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/>Identificación</div>

			<sec:authorize ifAllGranted="ROLE_ANONYMOUS">
			
				<div id="login">
	
			      	<form method="POST" action="<c:url value='/j_spring_security_check'/>">
					    <div class="campo_input">
			    		<label id="label_email_login" for="email_login">Email:</label>
						<input type="text" name="j_username" id="email_login" value='${username}<c:if test="${not empty param.login_error}"><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:if>' /> <span class="erroresform"></span>
						</div>
						
			    		<div class="campo_input">	
			    		<label id="label_password_login" for="password_login">Contraseña:</label>					
						<input type="password" name="j_password" id="password_login" /> <span class="erroresform"></span>
			    		</div>	  
			    		
			    		  		
						<div id="recordar_password"><input type="checkbox" name="_spring_security_remember_me" />Recordar contraseña en este equipo</div>
						
						<input type="submit" id="login_submit" value="Identificarse" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1; ">			
						
			    	</form>	
			      
		    	</div>	
	    	
	    	</sec:authorize>
	    	
	    	<sec:authorize ifAllGranted="ROLE_USER">	    	
	    		<div id="login_logueado">
	    			Ya se encuentra identificado. <br> Si desea hacer login de nuevo primero debe <a href="<c:url value='/j_spring_security_logout'/>">Desconectarse</a>
	    		</div>	    		
	    	</sec:authorize>
	    
		</div>
	</c:if>
	
	
	<!-- VISTA CARRITO -->
	
	<!-- VISTA CARRITRO > RESUMEN -->		
	
	<c:if test="${carrito!=null}">    
		<div class="capaCentro" id="cesta_resumen">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="micesta.htm">Mi cesta</a></div>
			
			<div class="cabecera_cuenta_cesta">
				<span class="micesta_cabecera_resumen"><span class="cabecera_negrita"><a href="micesta.htm"><img src="img/flecha_menu.png"/> Resumen</a></span></span>
				<span class="micesta_cabecera_direccion"><img src="img/flecha_menu.png"/> Dirección</span>
				<span class="micesta_cabecera_pago"><img src="img/flecha_menu.png"/> Pago</span>			
			</div>
			
			<c:if test="${fn:length(producto_agotado) > 0}">
		      	<div id="mensaje_cabecera_error">
			        Lo sentimos no quedan existencias de este producto.
		     	</div> 
			</c:if>
		    
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/><span>Mi cesta</span></div>
			
			<!-- LISTA DE PRODUCTOS EN MI CARRITO -->
			
			<c:if test="${fn:length(productos_carrito) > 0}">			
			
				<div class="cabecera_carrito">
					<span id="cabecera_carrito_titulo">Título</span><span>Autor</span><span>Precio</span><span>Cantidad</span><span>Importe</span>
				</div>
			
				<ul>
					<c:forEach items="${productos_carrito}" var="producto" varStatus="status">
						<li class="<c:if test="${status.count % 2 == 0}">par</c:if>">
							<div class="libro_carrito" id="carrito">		
							
								<div class="imagen_libro_portada">
									<a href="info_producto.htm?id_producto=${producto.producto.idproductos}">			
										<c:if test="${producto.producto.URL_portada!=null and producto.producto.URL_portada!=''}">  
											<img src="${producto.producto.URL_portada}"/>
										</c:if>
										<c:if test="${producto.producto.URL_portada==null or producto.producto.URL_portada==''}">
											<img src="img/portadas_libros/portada_no_disponible.jpg"/>
										</c:if>
									</a>								
								</div>
																		
								<div class="datos_libro">
									 <div class="titulo_libro">${producto.producto.producto}</div>
	    					   		 <div class="autor_libro">${producto.producto.autor}</div>	
									 <div class="precio_libro">${producto.producto.precio}</div>												 								 								 
									 <div class="cantidad_libro"><div>${producto.cantidad}</div><div id="add_cesta"><a href="add_cesta.htm?idproductos=${producto.producto.idproductos}"><img src="img/cant_up.gif" title="Añadir"/></a></div><div id="restar_cesta"><a href="restar_cesta.htm?idproductos=${producto.producto.idproductos}"><img src="img/cant_down.gif" title="Restar"/></a></div></div>
									 <div class="importe_libro">${producto.importeProducto} &#8364;</div>		
									 <span id="borrar_cesta"><a href="borrar_producto.htm?idproductos=${producto.producto.idproductos}"><img src="img/borrar_carrito.gif"  title="Borrar"/></a></span>			 
								</div>						
							</div>	
						</li>
					</c:forEach>																				
				</ul>
				<div class="botones_pie">
				<a class="boton_siguiente" href="micesta.htm?paso=1" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">Siguiente »</a>
				</div>
			</c:if>
			
			<c:if test="${fn:length(productos_carrito) == 0}">
			<div class="sin_productos">Su cesta esta vacía.</div>
			</c:if>
			
			<div class="botones_pie">
				<a class="boton_seguir_comprando"  href="index.htm" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">« Seguir comprando</a>
			</div>
			
		</div>
	</c:if>
		
		
	<!-- VISTA CARRITO > MI DIRECCIÓN -->		
	
	<c:if test="${midireccion!=null}" >    
        
   		<div class="capaCentro" id="cesta_direccion">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="micesta.htm">Mi cesta</a><span> » </span><a href="micesta.htm?paso=1">Mi dirección</a></div>
			
			<div class="cabecera_cuenta_cesta">
				<span class="micesta_cabecera_resumen"><img src="img/flecha_menu.png"/> Resumen</span>
				<span class="micesta_cabecera_direccion"><span class="cabecera_negrita"><a href="micesta.htm?paso=1"><img src="img/flecha_menu.png"/> Dirección</a></span></span>
				<span class="micesta_cabecera_pago"><img src="img/flecha_menu.png"/> Pago</span>			
			</div>
		    
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/><span>Mi dirección</span></div>     
    		
    		<div id="direccion_usuario">
    			<div class="header">Mi dirección</div>
    			<div id="direccion_usuario_campos">	
	    			<ul>
						<li>											 								 
							<span class="dir_campos_c">Nombre: </span><span class="dir_campos_v">${direccion_entrega.nombre} ${direccion_entrega.apellidos}</span>														
						</li>
						
						<li>											 								 
							<span class="dir_campos_c">Dirección: </span><span class="dir_campos_v"> ${direccion_entrega.direccion}</span>														
						</li>							
						
						<li>											 								 
							<span class="dir_campos_c">CP:</span><span class="dir_campos_v"> ${direccion_entrega.codigo_postal} ${direccion_entrega.provincia}</span>														
						</li>	
							
						<li>											 								 
							<span class="dir_campos_c">Pais:</span><span class="dir_campos_v">${direccion_entrega.pais}</span>															
						</li>																																		
					</ul>   
					<span class="dir_campos_a">» <a href="micuenta.htm">Actualizar</a> « </span>	 
				</div>		
    		</div>
    
   			<div class="botones_pie">
   				<a class="boton_atras" href="micesta.htm" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">« Anterior </a>
				<a class="boton_siguiente" href="micesta.htm?paso=2" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">Siguiente »</a>
			</div>
       </div> 

	</c:if>	

	<!-- VISTA CARRITO > PAGO -->		
	
	<c:if test="${pago!=null}">    
        
   		<div class="capaCentro" id="cesta_pago">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="micesta.htm">Mi cesta</a><span> » </span><a href="micesta.htm?paso=2">Pago</a></div>
			
			<div class="cabecera_cuenta_cesta">
				<span class="micesta_cabecera_resumen"><img src="img/flecha_menu.png"/> Resumen</span>
				<span class="micesta_cabecera_direccion"><img src="img/flecha_menu.png"/> Dirección</span>
				<span class="micesta_cabecera_pago"><span class="cabecera_negrita"><a href="micesta.htm?paso=2"><img src="img/flecha_menu.png"/> Pago</a></span></span>			
			</div>
		    
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/><span>Pago</span></div>     
    
    		<div id="pagar_pedido">Como pagar su pedido:</div>
    		<div id="pagar_pedido_input">

	    		<label id="label_pagar" for="radio_pagar"> <span class="pagar_pedido_indicador"> » </span>Tranferencia bancaria</label>
	    		<input type="radio" id="radio_pagar" checked />
		    		
    		</div>
    		
    		<div id="pagar_pedido_info"><span class="pagar_pedido_indicador">*</span> Su pedido será enviado a su domicio en un plazo de 72 horas a partir de que realice el pago del importe del mismo con un coste adicional de 5.22 &#8364;</div>
    		
   			<div class="botones_pie">
   				<a class="boton_atras" href="micesta.htm?paso=1" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">« Anterior </a>
				<a class="boton_siguiente" href="micesta.htm?paso=confirmar" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">Confirmar</a>
			</div>
       </div> 

	</c:if>		
	
	<!-- VISTA CARRITO > CONFIRMAR PEDIDO -->
	
	<c:if test="${confirmar_pedido!=null}">    
              
   		<div class="capaCentro" id="cesta_pago">
		
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="micesta.htm">Mi cesta</a><span> » </span><span id="resultado_compra">Resultado de la compra</span></div>		
		    
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/><span>Resultado de la compra</span></div>     
	
			<div id="resultado_compra_mensaje">
				Su pedido se ha realizado correctamente.<br><br>
				Para realizar el pago del mismo debe efectuar un ingreso de ${carrito_importe_confirmado} &#8364; en la cuenta BANKINTER-0114-0612-51-0310415086<br><br>
				Pulse <a href="mispedidos.htm">aquí</a> para ver sus pedidos		
			</div>
	
	
		</div>
		
	</c:if>
	
	<!-- VISTA MI CUENTA -->	

	<!-- VISTA MI CUENTA > DATOS PERSONALES -->	
		
	<c:if test="${miCuenta!=null}" >    
	
		<jsp:include page="micuenta.jsp" />
		
	</c:if>	
	
	
	<!-- VISTA MI CUENTA > MIS PEDIDOS -->	
	
	<c:if test="${misPedidos!=null}">    
        
        <div class="capaCentro" id="pedidos_resumen">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="micuenta.htm">Mi cuenta</a><span> » </span><a href="mispedidos.htm">Mis Pedidos</a></div>
			
			<div class="cabecera_cuenta_cesta">
				<span class="micuenta_cabecera_datos_personales"><a href="micuenta.htm"><img src="img/flecha_menu.png"/> Datos personales</a></span>
				<span class="micuenta_cabecera_mis_pedidos"><span class="cabecera_negrita"><a href="mispedidos.htm"><img src="img/flecha_menu.png"/> Mis pedidos</a></span></span>
			</div>
			
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/><span>Mis Pedidos</span></div>
			
			<!-- LISTA DE PEDIDOS -->
			
			<c:if test="${fn:length(misPedidos) > 0}">			
				
				<div class="cabecera_pedido">
			    	<span id="cabecera_pedido_titulo">Nº Pedido</span><span>Fecha</span><span>Nº Libros</span><span>Importe</span>
				</div>
			
				<ul>
					<c:forEach items="${misPedidos}" var="pedido" varStatus="status">
						<li class="<c:if test="${status.count % 2 == 0}">par</c:if>">
							<div class="libro_carrito">																
								<div class="imagen_libro_portada">								
									<c:forEach items="${pedido.lineasPedido}" var="lineapedido" varStatus="status">
										<c:if test="${status.count <= 4}">																				
											 <a class="toggleborder" href="info_producto.htm?id_producto=${lineapedido.producto.idproductos}">
											 	<c:if test="${lineapedido.producto.URL_portada!=null and lineapedido.producto.URL_portada!=''}"> 											 
											 		<img src="${lineapedido.producto.URL_portada}"
											 		<c:if test="${status.count !=1}">style="position:relative; right:${(status.count-1)*32}px; top:${(status.count-1) *4}px;"</c:if> /> 
											 	</c:if>
											 	<c:if test="${lineapedido.producto.URL_portada==null or lineapedido.producto.URL_portada==''}"> 
											 		<img src="img/portadas_libros/portada_no_disponible.jpg"
											 		<c:if test="${status.count !=1}">style="position:relative; right:${(status.count-1)*32}px; top:${(status.count-1) *4}px;"</c:if> /> 
											 	</c:if>
											 </a>										
										</c:if>								
									</c:forEach>
								</div>
								<div class="datos_libro">
									 <div class="id_pedido">${pedido.idpedido}</div>
									 <div class="fecha_pedido">${pedido.fecha}</div>	
									 <div class="num_libros">${pedido.cantidadPedido}</div>
									 <span class="importe_pedido">${pedido.importePedido} &#8364;</span> 
									 
									 <div class="consultar"><a href="mispedidos.htm?idpedido=${pedido.idpedido}"><img src="img/flecha_menu.png"/> Consultar</a></div>							 
								</div>						
							</div>	
						</li>
					</c:forEach>																				
				</ul>
				
				<div class="paginas">					
					<c:if test="${paginaActual!=1}">    
						<a class="avance_retroceso" href="mispedidos.htm?pagina=${paginaActual-1}" title="Página anterior">&lt;&lt;&nbsp;Anterior&nbsp;&nbsp;</a>
					</c:if>
					
					<c:forEach var="i" begin="${pagina_inicial_bloque}" end="${pagina_final_bloque}" step="1">
						
						<c:if test="${i <= numDePaginas}">
						
							<c:if test="${i == paginaActual}">
			                	<span class="paginaActual"> <a href="mispedidos.htm?pagina=${i}">${i}</a> </span>
			      			</c:if>
			      
			      			<c:if test="${i != paginaActual}">
			                	 <a href="mispedidos.htm?pagina=${i}">${i}</a>
			                </c:if>
		                              
		                </c:if>
	     			</c:forEach>			
					
					<c:if test="${paginaActual!=numDePaginas}">   
						<a class="avance_retroceso" href="mispedidos.htm?pagina=${paginaActual+1}" title="Página siguiente">&nbsp;&nbsp;Siguiente&nbsp;&gt;&gt;</a>
					</c:if>					
				</div>
				
			</c:if>
			
			<c:if test="${fn:length(misPedidos) == 0}">
				<div class="sin_productos">No ha realizado ningún pedido.</div>
			</c:if>
			
        </div>
        
	</c:if>
	
	<!-- VISTA MI CUENTA > MIS PEDIDOS > DETALLE PEDIDO -->	
	
	<c:if test="${detalle_pedido!=null}">    
        
        <div class="capaCentro" id="pedidos_detalle">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="micuenta.htm">Mi cuenta</a><span> » </span><a href="mispedidos.htm">Mis Pedidos</a><span> » </span><a href="mispedidos.htm?idpedido=${id_pedido}">Pedido</a></div>
			
			<div class="cabecera_cuenta_cesta">
				<span class="micuenta_cabecera_datos_personales"><a href="micuenta.htm"><img src="img/flecha_menu.png"/> Datos personales</a></span>
				<span class="micuenta_cabecera_mis_pedidos"><span class="cabecera_negrita"><a href="mispedidos.htm"><img src="img/flecha_menu.png"/> Mis pedidos</a></span></span>
			</div>
			
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/><span>Mis Pedidos</span></div>
			
			<!-- LISTA DE PRODUCTOS QUE COMPONEN EL PEDIDO -->
			
			<c:if test="${fn:length(detalle_pedido) > 0}">			
					
				<div class="cabecera_detalle_pedido">
					<span id="cabecera_detalle_pedido_titulo">Título</span><span>Autor</span><span>Precio</span><span>Cantidad</span><span id="importe_detalle_pedido">Importe</span>
				</div>
			
				<ul>
					<c:forEach items="${detalle_pedido}" var="producto" varStatus="status">
						<li class="<c:if test="${status.count % 2 == 0}">par</c:if>">
							<div class="libro_carrito">			
							
								<div class="imagen_libro_portada">
									<a href="info_producto.htm?id_producto=${producto.producto.idproductos}">			
										<c:if test="${producto.producto.URL_portada!=null and producto.producto.URL_portada!=''}">  
											<img src="${producto.producto.URL_portada}"/>
										</c:if>
										<c:if test="${producto.producto.URL_portada==null or producto.producto.URL_portada==''}">
											<img src="img/portadas_libros/portada_no_disponible.jpg"/>
										</c:if>
									</a>								
								</div>
								
								<div class="datos_libro">
									<div class="titulo_libro">${producto.producto.producto}</div>
		    					    <div class="autor_libro_detalle_pedido">${producto.producto.autor}</div>	
									<div class="precio_libro_detalle_pedido">${producto.producto.precio}</div>												 								 								 
									<div class="cantidad_libro_detalle_pedido">${producto.cantidad}</div>
									<span class="importe_libro_pedido">${producto.importeProducto} &#8364;</span>		
								</div>						
							</div>	
						</li>
					</c:forEach>																				
				</ul>
				
				<div class="coste_envio">Costes de envío: <span class="cantidad_coste_envio"> 5.22 &#8364;</span></div>
				<div class="importe_total">Total: <span class="cantidad_importe_total">${detalle_pedido_pedido.importePedido}</span></div>
			</c:if>
			
			<div class="boton_atras_div">
			  		<a class="boton_atras" href="javascript:history.back()" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">« Atrás </a>
			</div>
		</div>
	</c:if>
	
	<!-- VISTA RESULTADOS DE BÚSQUEDA -->
	
	<c:if test="${resultado_busqueda!=null}">   
	
		<div class="capaCentro">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="buscar.htm">Buscar</a></div>
			    
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/>Resultados de la búsqueda <span class="resultados_busqueda">( ${cantidad_producto_busqueda} resultados )</span></div>
	
				<c:if test="${fn:length(resultado_busqueda) > 0}">
					<ul>
						<c:forEach items="${resultado_busqueda}" var="producto" varStatus="status">
							<li>
								<div class="libro">												
									<div class="imagen_libro_portada">	
										<a href="info_producto.htm?id_producto=${producto.idproductos}">			
											<c:if test="${producto.URL_portada!=null and producto.URL_portada!=''}">  
												<img src="${producto.URL_portada}"/>
											</c:if>
											<c:if test="${producto.URL_portada==null or producto.URL_portada==''}">
												<img src="img/portadas_libros/portada_no_disponible.jpg"/>
											</c:if>
										</a>
										
									</div>
									<div class="datos_libro">
										<div class="titulo_libro"><a href="info_producto.htm?id_producto=${producto.idproductos}">${producto.producto}</a></div>
										<div class="autor_libro">${producto.autor}</div>
										<div class="fecha_editorial_libro">${producto.fecha_edicion}<c:if test="${producto.fecha_edicion!=null and producto.fecha_edicion!='' and producto.editorial!=null and producto.editorial!=''}">,</c:if> ${producto.editorial}</div>
										<div class="precio_libro">${producto.precio}&#8364;</div>	
										<div class="disponiblidad">		
											<c:if test="${producto.cantidad > 0}">
												<img src="img/button_verde.jpg"/><span class="disponible">Disponible</span>
											</c:if>
											<c:if test="${producto.cantidad == 0}">
												<img src="img/button_rojo.jpg"/><span class="no_disponible">No disponible</span>
											</c:if>
								    	</div>			
									</div>		
									<div class="imagen_AddCesta"><a href="add_cesta.htm?idproductos=${producto.idproductos}"><img src="img/AddCesta.jpg" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;"/></a></div>								
								</div>	
							</li>
						</c:forEach>																				
					</ul>
					
					<div class="paginas">					
						<c:if test="${paginaActual!=1}">    
							<a class="avance_retroceso" href="buscar.htm?campo_busqueda=${parametro_busqueda}&pagina=${paginaActual-1}" title="Página anterior">&lt;&lt;&nbsp;Anterior&nbsp;&nbsp;</a>
						</c:if>
						
						<c:forEach var="i" begin="${pagina_inicial_bloque}" end="${pagina_final_bloque}" step="1">
							
							<c:if test="${i <= numDePaginas}">
							
								<c:if test="${i == paginaActual}">
				                	<span class="paginaActual"> <a href="buscar.htm?campo_busqueda=${parametro_busqueda}&pagina=${i}">${i}</a> </span>
				      			</c:if>
				      
				      			<c:if test="${i != paginaActual}">
				                	 <a href="buscar.htm?campo_busqueda=${parametro_busqueda}&pagina=${i}">${i}</a>
				                </c:if>
			                              
			                </c:if>
		     			</c:forEach>			
						
						<c:if test="${paginaActual!=numDePaginas}">    
							<a class="avance_retroceso" href="buscar.htm?campo_busqueda=${parametro_busqueda}&pagina=${paginaActual+1}" title="Página siguiente">&nbsp;&nbsp;Siguiente&nbsp;&gt;&gt;</a>
						</c:if>					
					</div>
					
				</c:if>
	
		</div>
	
	</c:if>
	
	<!-- VISTA RESULTADOS DE BÚSQUEDA DE CATEGORÍAS -->
	
	<c:if test="${resultado_busqueda_categoria!=null}">   
	
		<div class="capaCentro">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="buscar.htm">Buscar</a></div>
			    
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/>Resultados de la búsqueda <span class="resultados_busqueda">( ${cantidad_producto_busqueda_categoria} resultados )</span></div>
	
			<c:if test="${fn:length(resultado_busqueda_categoria) > 0}">
				<ul>
					<c:forEach items="${resultado_busqueda_categoria}" var="producto" varStatus="status">
						<li>
							<div class="libro">									
								<div class="imagen_libro_portada">
									<a href="info_producto.htm?id_producto=${producto.idproductos}">			
										<c:if test="${producto.URL_portada!=null and producto.URL_portada!=''}">  
											<img src="${producto.URL_portada}"/>
										</c:if>
										<c:if test="${producto.URL_portada==null or producto.URL_portada==''}">
											<img src="img/portadas_libros/portada_no_disponible.jpg"/>
										</c:if>
									</a>								
								</div>
								<div class="datos_libro">
									<div class="titulo_libro"><a href="info_producto.htm?id_producto=${producto.idproductos}">${producto.producto}</a></div>
									<div class="autor_libro">${producto.autor}</div>
									<div class="fecha_editorial_libro">${producto.fecha_edicion}<c:if test="${producto.fecha_edicion!=null and producto.fecha_edicion!='' and producto.editorial!=null and producto.editorial!=''}">,</c:if> ${producto.editorial}</div>
									<div class="precio_libro">${producto.precio}&#8364;</div>	
									<div class="disponiblidad">		
										<c:if test="${producto.cantidad > 0}">
											<img src="img/button_verde.jpg"/><span class="disponible">Disponible</span>
										</c:if>
										<c:if test="${producto.cantidad == 0}">
											<img src="img/button_rojo.jpg"/><span class="no_disponible">No disponible</span>
										</c:if>
							    	</div>			
								</div>		
								<div class="imagen_AddCesta"><a href="add_cesta.htm?idproductos=${producto.idproductos}"><img src="img/AddCesta.jpg" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;"/></a></div>								
							</div>	
						</li>
					</c:forEach>																				
				</ul>
				
				<div class="paginas">					
					<c:if test="${paginaActual!=1}">    
						<a class="avance_retroceso" href="buscar.htm?categoria=${categoria}&pagina=${paginaActual-1}" title="Página anterior">&lt;&lt;&nbsp;Anterior&nbsp;&nbsp;</a>
					</c:if>
					
					<c:forEach var="i" begin="${pagina_inicial_bloque}" end="${pagina_final_bloque}" step="1">
						
						<c:if test="${i <= numDePaginas}">
						
							<c:if test="${i == paginaActual}">
			                	<span class="paginaActual"> <a href="buscar.htm?categoria=${categoria}&pagina=${i}">${i}</a> </span>
			      			</c:if>
			      
			      			<c:if test="${i != paginaActual}">
			                	 <a href="buscar.htm?categoria=${categoria}&pagina=${i}">${i}</a>
			                </c:if>
		                              
		                </c:if>
	     			</c:forEach>			
					
					<c:if test="${paginaActual!=numDePaginas}">   
						<a class="avance_retroceso" href="buscar.htm?categoria=${categoria}&pagina=${paginaActual+1}" title="Página siguiente">&nbsp;&nbsp;Siguiente&nbsp;&gt;&gt;</a>
					</c:if>					
				</div>
				
			</c:if>
	
		</div>
	
	</c:if>
	
	
	<!-- VISTA FORMULARIO DE BUSQUEDA AVANZADA -->
	
	<c:if test="${avanzada!=null}">   
	
		<div class="capaCentro">
		
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="avanzada.htm">Búsqueda avanzada</a></div>
			    
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/>Búsqueda avanzada</div>
			
			<div id="avanzada">

		      	<form method="GET" action="avanzada.htm">
				    <div class="campo_input">
		    		<label for="email_login">Título:</label>
					<input type="text" name="titulo" id="titulo" value="${titulo}" /> 
					</div>
					
		    		<div class="campo_input">	
		    		<label for="autor">Autor:</label>					
					<input type="text" name="autor" id="autor" value="${autor}" /> 
		    		</div>	 
		    		
		    		<div class="campo_input">
		    		<label for="ISBN">ISBN:</label>
					<input type="text" name="ISBN" id="ISBN" value="${ISBN}"  /> 
					</div>
					
		    		<div class="campo_input">	
		    		<label for="Editorial">Editorial:</label>					
					<input type="text" name="editorial" id="Editorial" value="${editorial}" /> 
		    		</div>	 	    		 
					
					<input type="submit" id="buscar_submit" value="Consultar" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1; ">			
					
		    	</form>	
		      
	    	</div>	
	    	
	    	<c:if test="${busqueda_onsubmit}">
	    		<c:if test="${fn:length(resultado_busqueda_avanzada) == 0}">
		    		<div class="cabecera_resultados">Lo sentimos, no se han obtenido resultados.</div>
	    		</c:if>
	    	</c:if>

	    	<c:if test="${busqueda_onsubmit}">
	
				<c:if test="${fn:length(resultado_busqueda_avanzada) > 0}">
				
					<div class="cabecera_resultados">Se han encontrado <span class="resultados_busqueda">${cantidad_producto_busqueda_avanzada} resultados</span></div>
					<ul>
						<c:forEach items="${resultado_busqueda_avanzada}" var="producto" varStatus="status">
							<li>
								<div class="libro">									
									<div class="imagen_libro_portada">
										<a href="info_producto.htm?id_producto=${producto.idproductos}">			
											<c:if test="${producto.URL_portada!=null and producto.URL_portada!=''}">  
												<img src="${producto.URL_portada}"/>
											</c:if>
											<c:if test="${producto.URL_portada==null or producto.URL_portada==''}">
												<img src="img/portadas_libros/portada_no_disponible.jpg"/>
											</c:if>
										</a>									
									</div>
									<div class="datos_libro">
										<div class="titulo_libro"><a href="info_producto.htm?id_producto=${producto.idproductos}">${producto.producto}</a></div>
										<div class="autor_libro">${producto.autor}</div>
										<div class="fecha_editorial_libro">${producto.fecha_edicion}<c:if test="${producto.fecha_edicion!=null and producto.fecha_edicion!='' and producto.editorial!=null and producto.editorial!=''}">,</c:if> ${producto.editorial}</div>
										<div class="precio_libro">${producto.precio}&#8364;</div>	
										<div class="disponiblidad">		
											<c:if test="${producto.cantidad > 0}">
												<img src="img/button_verde.jpg"/><span class="disponible">Disponible</span>
											</c:if>
											<c:if test="${producto.cantidad == 0}">
												<img src="img/button_rojo.jpg"/><span class="no_disponible">No disponible</span>
											</c:if>
								    	</div>			
									</div>		
									<div class="imagen_AddCesta"><a href="add_cesta.htm?idproductos=${producto.idproductos}"><img src="img/AddCesta.jpg" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;"/></a></div>								
								</div>	
							</li>
						</c:forEach>																				
					</ul>
					
					<div class="paginas">					
						<c:if test="${paginaActual!=1}">   
							<a class="avance_retroceso" href="avanzada.htm?titulo=${titulo}&autor=${autor}&ISBN=${ISBN}&editorial=${editorial}&pagina=${paginaActual-1}" title="Página anterior">&lt;&lt;&nbsp;Anterior&nbsp;&nbsp;</a>
						</c:if>
						
						<c:forEach var="i" begin="${pagina_inicial_bloque}" end="${pagina_final_bloque}" step="1">
							
							<c:if test="${i <= numDePaginas}">
							
								<c:if test="${i == paginaActual}">
				                	<span class="paginaActual"> <a href="avanzada.htm?titulo=${titulo}&autor=${autor}&ISBN=${ISBN}&editorial=${editorial}&pagina=${i}">${i}</a> </span>
				      			</c:if>
				      
				      			<c:if test="${i != paginaActual}">
				                	 <a href="avanzada.htm?titulo=${titulo}&autor=${autor}&ISBN=${ISBN}&editorial=${editorial}&pagina=${i}">${i}</a>
				                </c:if>
			                              
			                </c:if>
		     			</c:forEach>			
						
						<c:if test="${paginaActual!=numDePaginas}">  
							<a class="avance_retroceso" href="avanzada.htm?titulo=${titulo}&autor=${autor}&ISBN=${ISBN}&editorial=${editorial}&pagina=${paginaActual+1}" title="Página siguiente">&nbsp;&nbsp;Siguiente&nbsp;&gt;&gt;</a>
						</c:if>					
					</div>
					
				</c:if>
			</c:if>				
		</div>
	
	</c:if>
	
	
	<!-- CAPA DERECHA -->
	
	<div id="capaDerecha">
	
		<!-- CARRITO -->
		
		<div class="carrito">
			<div id="cabecera_carrito">
				<h4>MI CESTA </h4>
				<img src="img/carrito_logo.png" title="logo de carrito" alt="logo de carrito"/>
			</div>
			<div class="bloque_contenido">
				<div id="articulos_carrito">
					${cantidad_libros_carrito} libros
				</div>
				<div id="precio_pago">
					Total ${carrito_importe} &#8364;
					<a href="micesta.htm"><img src="img/icono_compra.png" title="compra" alt="compra" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;"/></a>
				</div>
			</div>
		</div>	
		
		<!-- PRODUCTOS DE OFERTA -->
		
		<div class="bloques_tags">
			<h4>OFERTAS</h4>	
			<div class="contenido_ofertas">
				<c:set var="numero" value="${fn:length(ofertasList)}"/>
				<c:if test="${numero > 0}">
					<!-- DEBE HABER UN NUMERO PAR DE PRODUCTOS -->
					<c:set var="modulo" value="${numero % 2 == 0}"/>			
					<c:if test="${not modulo}"><c:set var="numero" value="${numero-1}"/></c:if>
					<ul>
						<c:set var="contador" value="0"/>
						<c:forEach items="${ofertasList}" var="producto" varStatus="status">						
							<c:if test="${contador<numero}">
						        <c:set var="flotante" value="${status.count % 2 == 0}"/>
								<li class="<c:if test="${not flotante}">flotante_izq</c:if><c:if test="${flotante}">flotante_der</c:if>">
									<a href="info_producto.htm?id_producto=${producto.idproductos}">			
										<c:if test="${producto.URL_portada!=null and producto.URL_portada!=''}">  
											<img src="${producto.URL_portada}"/>
										</c:if>
										<c:if test="${producto.URL_portada==null or producto.URL_portada==''}">
											<img src="img/portadas_libros/portada_no_disponible.jpg"/>
										</c:if>
									</a>
									<div class="ofertas_texto_flotante">
										<div class="titulo_ofertas"><a href="info_producto.htm?id_producto=${producto.idproductos}">${producto.producto}</a></div> 
										<div class="fecha_ofertas">${producto.fecha_edicion}</div>
										<div class="precio_libro">${producto.precio}&#8364;</div>
									</div>	 
								</li>
								<c:set var="contador" value="${contador+1}"/>
							</c:if>	
						</c:forEach>																		
					</ul>	
				</c:if>
			</div>					
		</div>
	</div>
	<div id="pie">
	<a href="mailto:contacta@LibreriaVirtual.com">Contacta con nosotros</a>
</div>
</div>


</body>
</html>