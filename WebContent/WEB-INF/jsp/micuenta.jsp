<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 


		<script type="text/javascript">
		
			window.onload=function(){

				//Funciones para cargar el formulario con los datos del usuario que haya en la base de datos
				
				for (i=0;i<=document.form_micuenta.mcprovincia.length;i++){
					
					
					if(i<document.form_micuenta.mcmes_nacimiento.length){
						
						if(document.form_micuenta.mcmes_nacimiento[i].value=="${datos_usuario.mes_nacimiento}")							
							document.form_micuenta.mcmes_nacimiento[i].selected='selected';
						
					}
					
					if(i<document.form_micuenta.mcpais.length){
					
						if(document.form_micuenta.mcpais[i].value=="${datos_usuario.pais}"){
							document.form_micuenta.mcpais[i].selected='selected';
						
							//Sólo mostramos provincias si el país seleccionado es España
							if(document.form_micuenta.mcpais[i].value=="España")
								document.getElementById("mcid_provincia").style.visibility="visible";
							else{
								document.getElementById("mcid_provincia").style.visibility="hidden";
								document.getElementById("mcsolo_espana_msg").innerHTML = '(Sólo España)';
							}
						}
					}
					
					if(document.form_micuenta.mcprovincia[i].value=="${datos_usuario.provincia}")
						document.form_micuenta.mcprovincia[i].selected='selected';
				}
				
			};			
			
			
			//Sólo mostramos provincias si el país seleccionado es España
			
			cambia_provincia=function(){

			    var pais;
			    pais = document.form_micuenta.mcpais[document.form_micuenta.mcpais.selectedIndex].value;
			    if (pais == 'España') {
					document.getElementById("mcid_provincia").style.visibility="visible";
					document.getElementById("mcsolo_espana_msg").innerHTML = '';
			    }else{
				   document.form_micuenta.mcprovincia[0].selected="selected"; 
				   document.getElementById("mcid_provincia").style.visibility="hidden";
				   document.getElementById("mcsolo_espana_msg").innerHTML = '(Sólo España)';
			    }
			};			
			
		</script>
			
			
		<div class="capaCentro">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="micuenta.htm">Mi cuenta</a></div>
			
			<div class="cabecera_cuenta_cesta">
				<span class="micuenta_cabecera_datos_personales"><span class="cabecera_negrita"><a href="micuenta.htm"><img src="img/flecha_menu.png"/> Datos personales</a></span></span>
				<span class="micuenta_cabecera_mis_pedidos"><a href="mispedidos.htm"><img src="img/flecha_menu.png"/> Mis pedidos</a></span>
			</div>
			
			<!-- Mensaje que se muestra cuando un usuario edita sus datos satisfactoriamente y ve la página micuenta.htm -->
			<c:if test="${modificar_micuenta_exito==null}" var="noModificar_micuenta_exito"/>    
			<c:if test="${not noModificar_micuenta_exito}">
				<div id="mensaje_editarcuenta_exito">${modificar_micuenta_exito}</div>
			</c:if>
			
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/><span>Mi cuenta</span></div>
			<!-- FORMULARIO MI CUENTA -->
			<div id="micuenta">
				<form:form name="form_micuenta" method="POST" commandName="usuario" action="micuenta_onsubmit.htm">
			    	<fieldset>	
			    	<legend align="center">Datos de acceso</legend>
			    		<div class="datos_acceso">
				    		<div class="campo_input">
				    		<label id="mclabel_email" for="mcemail">Email:</label>
							<input name="username" id="mcemail" value="${datos_usuario.username}" readonly /> <span class="erroresform">* ${email_usado}</span>
							<form:errors path="username" cssClass="erroresform" />
							</div>	
	
				    		<div class="campo_input">	
				    		<label id="label_apassword" for="apassword">Contraseña actual:</label>					
							<input type="password" id="apassword" name="apassword" /> <span class="erroresform">*</span>
							<span class="erroresform">${apassword}</span>
				    		</div>	
				    								
				    		<div class="campo_input">	
				    		<label id="mclabel_password" for="mcpassword">Contraseña nueva:</label>					
							<form:password path="password" id="mcpassword"/> <span class="erroresform">*</span>
							<form:errors path="password" cssClass="erroresform" />
				    		</div>	
				    									
				    		<div class="campo_input">	
				    		<label id="mclabel_cpassword" for="mccpassword">Confirmar contraseña:</label>					
							<input type="password" id="mccpassword" name="cpassword"/> <span class="erroresform">*</span>
							<span class="erroresform">${cpassword}</span>
				    		</div>		    		
			    		</div>
			    	</fieldset>	
			    	<fieldset>	
			    	<legend align="center">Información personal</legend>
			    		<div class="informacion_personal">		    		
				    		<div class="campo_input">			   
				    		<label id="mcabel_nombre" for="mcnombre">Nombre:</label> 		
							<input name="nombre" id="mcnombre" value="${datos_usuario.nombre}"/> <span class="erroresform">*</span>
							<form:errors path="nombre" cssClass="erroresform" />
				    		</div>						
							
							
				    		<div class="campo_input">		
				    		<label id="mclabel_apellidos" for="mcapellidos">Apellidos:</label>				
							<input name="apellidos" id="mcapellidos" value="${datos_usuario.apellidos}"/> <span class="erroresform">*</span>
							<form:errors path="apellidos" cssClass="erroresform" />
				    		</div>			
							 	
				    		<div class="campo_input">					
				    		<label id="mclabel_sexo" for="mcsexo">Sexo:</label>
				    		<label id="mclabel_hl" for="mclabel_h" >H</label>		
				    		
				    		<c:if test="${datos_usuario.sexo=='H'}"> <c:set var="checkedH" value="checked='checked'"/> </c:if>
				    		<c:if test="${datos_usuario.sexo=='M'}"> <c:set var="checkedM" value="checked='checked'"/> </c:if>
				    		
							<input type="radio" name="sexo" id="mclabel_h" value="H" ${checkedH} /> 
							<label id="mclabel_ml" for="mclabel_m">M</label>	
							<input type="radio" name="sexo" id="mclabel_m" value="M" ${checkedM} />
				    		</div>						
													
							
				    		<div class="campo_input">
				    		<label id="mclabel_dia_nacimiento" for="mcdia_nacimiento">Fecha de nacimiento:</label>					
							<select name="dia_nacimiento" id="mcdia_nacimiento"> 
								<option value="">-  </option>					
								<c:forEach var="i" begin="1" end="31" step="1">			
              			 	    	<option value="${i}" <c:if test="${datos_usuario.dia_nacimiento==i}"> selected='selected' </c:if> >${i}  </option>
     						    </c:forEach>			
							</select> 				
						
							<select name="mes_nacimiento" id="mcmes_nacimiento"> 
								<option value="">-  </option>					
								<option value="Enero">Enero  </option>
								<option value="Febrero">Febrero  </option>
								<option value="Marzo">Marzo  </option>
								<option value="Abril">Abril  </option>
								<option value="Mayo">Mayo  </option>
								<option value="Junio">Junio  </option>
								<option value="Julio">Julio  </option>
								<option value="Agosto">Agosto  </option>
								<option value="Septiembre">Septiembre  </option>
								<option value="Octubre">Octubre  </option>
								<option value="Noviembre">Noviembre  </option>				
								<option value="Diciembre">Diciembre  </option>				
							</select> 
							
							<select name="ano_nacimiento" id="mcano_nacimiento"> 
								<option value="">-  </option>						
								<c:forEach var="i" begin="1900" end="2001" step="1">
              			 	    	<option value="${i}" <c:if test="${datos_usuario.ano_nacimiento==i}"> selected='selected' </c:if> >${i}  </option>
     						    </c:forEach>				
							</select>					
							
				    		</div>		
							
							<div id ="mcid_pais" class="campo_input">						
				    		<label id="mclabel_pais" for="mcpais">Pais:</label>
							<select name="pais" id="mcpais" onchange="cambia_provincia()"> 
								<option value="">-  </option>								
								<option value="Alemania">Alemania  </option>								
								<option value="Argentina">Argentina  </option>
								<option value="España">España  </option>
								<option value="Francia">Francia  </option>
								<option value="Italia">Italia  </option>
								<option value="Portugal">Portugal  </option>															
							</select> <span class="erroresform">*</span>
							<form:errors path="pais" cssClass="erroresform" />					
				    		</div>	
		
				    		<div class="campo_input">
				    			<label id="mclabel_provincia" for="mcprovincia">Provincia:</label>	
					    		<span id="mcsolo_espana_msg"></span>
					    		<div id="mcid_provincia">			    			
									<form:select path="provincia" id="mcprovincia" > 
										<form:option value="" label="-  " />
										<option value="Alava">Alava  </option>
										<form:option value="Albacete" label="Albacete  " />
										<form:option value="Alicante" label="Alicante  " />
										<form:option value="Almeria" label="Almería  " />
										<form:option value="Asturias" label="Asturias  " />
										<form:option value="Avila" label="Ávila  " />
										<form:option value="Badajoz" label="Badajoz  " />	
										<form:option value="Barcelona" label="Barcelona  " />
										<form:option value="Burgos" label="Burgos  " />
										<form:option value="Caceres" label="Cáceres  " />
										<form:option value="Cadiz" label="Cádiz  " />	
										<form:option value="Cantabria" label="Cantabria  " />
										<form:option value="Castellon" label="Castellón  " />
										<form:option value="Ciudad Real" label="Ciudad Real  " />
										<form:option value="La Coruna" label="La Coruña  " />	
										<form:option value="Cuenca" label="Cuenca  " />
										<form:option value="Gerona" label="Gerona  " />
										<form:option value="Granada" label="Granada  " />
										<form:option value="Guadalajara" label="Guadalajara  " />
										<form:option value="Guipúzcoa" label="Guipúzcoa  " />
										<form:option value="Huelva" label="Huelva  " />
										<form:option value="Huesca" label="Huesca  " />
										<form:option value="Islas Baleares " label="Islas Baleares  " />	
										<form:option value="Jaen" label="Jaén  " />
										<form:option value="Leon" label="León  " />
										<form:option value="Lerida" label="Lérida  " />
										<form:option value="Lugo" label="Lugo  " />	
										<form:option value="Madrid" label="Madrid  " />
										<form:option value="Malaga" label="Málaga  " />
										<form:option value="Murcia" label="Murcia  " />
										<form:option value="Navarra" label="Navarra  " />	
										<form:option value="Orense" label="Orense  " />
										<form:option value="Palencia" label="Palencia  " />
										<form:option value="Las Palmas" label="Las Palmas  " />
										<form:option value="Pontevedra" label="Pontevedra  " />
										<form:option value="La Rioja" label="La Rioja  " />
										<form:option value="Salamanca" label="Salamanca  " />
										<form:option value="Segovia" label="Segovia  " />
										<form:option value="Sevilla" label="Sevilla  " />
										<form:option value="Soria" label="Soria  " />
										<form:option value="Tarragona" label="Tarragona  " />
										<form:option value="S.C. de Tenerife" label="S.C. de Tenerife  " />	
										<form:option value="Teruel" label="Teruel  " />
										<form:option value="Toledo" label="Toledo  " />
										<form:option value="Valencia" label="Valencia  " />
										<form:option value="Valladolid" label="Valladolid  " />		
										<form:option value="Vizcaya" label="Vizcaya  " />
										<form:option value="Zamora" label="Zamora  " />
										<form:option value="Zaragoza" label="Zaragoza  " />																																																																			
									</form:select> 
									<span class="erroresform">*</span>
									<form:errors path="provincia" cssClass="erroresform" />																		
								</div>								
				    		</div>		
							
				    		<div class="campo_input">			
				    		<label id="mclabel_telefono" for="mctelefono">Teléfono:</label>		    				
							<input name="telefono" id="mctelefono" value="${datos_usuario.telefono}" /> 					
				    		</div>	
		
				    		<div class="campo_input">	
				    		<label id="mclabel_codigo_postal" for="mccodigo_postal">Código Postal:</label>
							<input name="codigo_postal" id="mccodigo_postal" value="${datos_usuario.codigo_postal}" /> <span class="erroresform">*</span>
							<form:errors path="codigo_postal" cssClass="erroresform" />
				    		</div>						
							
				    		<div class="campo_input">		
				    		<label id="mclabel_direccion" for="mcdireccion">Dirección:</label>				
							<input name="direccion" id="mcdireccion" value="${datos_usuario.direccion}"/> <span class="erroresform">*</span>
							<form:errors path="direccion" cssClass="erroresform" />
				    		</div>										
							
			    		</div>
			    	</fieldset>
			    							
						<div class="erroresform">* Campos Obligatorios</div>	
								
						<input type="submit" id="aceptar_submit" value="Aceptar" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">
					
				</form:form>
			</div>
		</div>	
