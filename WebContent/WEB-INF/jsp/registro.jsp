<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 


		<script>
			
			window.onload=function(){
			
			    var pais;
			    pais = document.form_registro.pais[document.form_registro.pais.selectedIndex].value;
				if(pais == 'España')
					document.getElementById("id_provincia").style.visibility="visible";
				else{
					document.getElementById("id_provincia").style.visibility="hidden";
					document.getElementById("solo_espana_msg").innerHTML = '(Sólo España)';
				}

			};
			
			cambia_provincia=function(){

			    var pais;
			    pais = document.form_registro.pais[document.form_registro.pais.selectedIndex].value;
			    if (pais == 'España') {
					document.getElementById("id_provincia").style.visibility="visible";
					document.getElementById("solo_espana_msg").innerHTML = '';
			    }else{
				   document.form_registro.provincia[0].selected="selected"; 
				   document.getElementById("id_provincia").style.visibility="hidden";
				   document.getElementById("solo_espana_msg").innerHTML = '(Sólo España)';
			    }
			};			
			
		</script>
			
			
		<div class="capaCentro">
			<div class="ruta"><a href="index.htm"> Inicio</a><span> » </span><a href="registro.htm">Registro</a></div>
			<div class="cabeceraform"><img src="img/flecha_abajo.jpg"/><span>Registro de nuevo usuario</span></div>
			<!-- FORMULARIO REGISTRO -->
			<div id="registro">
				<form:form name="form_registro" method="POST" commandName="usuario" action="registro_onsubmit.htm">
			    	<fieldset>	
			    	<legend align="center">Datos de acceso</legend>
			    		<div class="datos_acceso">
				    		<div class="campo_input">
				    		<label id="label_email" for="email">Email:</label>
							<form:input path="username" id="email"/> <span class="erroresform">* ${email_usado}</span>
							<form:errors path="username" cssClass="erroresform" />
							</div>
							
				    		<div class="campo_input">	
				    		<label id="label_password" for="password">Contraseña:</label>					
							<form:password path="password" id="password"/> <span class="erroresform">*</span>
							<form:errors path="password" cssClass="erroresform" />
				    		</div>
							
				    		<div class="campo_input">	
				    		<label id="label_cpassword" for="cpassword">Confirmar contraseña:</label>					
							<input type="password" id="cpassword" name="cpassword"/> <span class="erroresform">*</span>
							<span class="erroresform">${cpassword}</span>
				    		</div>		    		
			    		</div>
			    	</fieldset>	
			    	<fieldset>	
			    	<legend align="center">Información personal</legend>
			    		<div class="informacion_personal">		    		
				    		<div class="campo_input">			   
				    		<label id="label_nombre" for="nombre">Nombre:</label> 		
							<form:input path="nombre" id="nombre"/> <span class="erroresform">*</span>
							<form:errors path="nombre" cssClass="erroresform" />
				    		</div>						
							
							
				    		<div class="campo_input">		
				    		<label id="label_apellidos" for="apellidos">Apellidos:</label>				
							<form:input path="apellidos" id="apellidos"/> <span class="erroresform">*</span>
							<form:errors path="apellidos" cssClass="erroresform" />
				    		</div>			
							 	
				    		<div class="campo_input">					
				    		<label id="label_sexo" for="sexo">Sexo:</label>
				    		<label id="label_hl" for="label_h">H</label>		
							<form:radiobutton path="sexo" id="label_h" value="H" /> 
							<label id="label_ml" for="label_m">M</label>	
							<form:radiobutton path="sexo" id="label_m" value="M" />
				    		</div>						
							
      
				    		<div class="campo_input">
				    		<label id="label_dia_nacimiento" for="dia_nacimiento">Fecha de nacimiento:</label>					
							<form:select path="dia_nacimiento" id="dia_nacimiento"> 
								<form:option value="" label="-  " />		
						        <c:forEach var="i" begin="1" end="31" step="1">
              			 	    	<form:option value="${i}" label="${i}  " />
     						    </c:forEach>								
							</form:select> 				
						
							<form:select path="mes_nacimiento" id="mes_nacimiento"> 
								<form:option value="" label="-  " />					
								<form:option value="Enero" label="Enero  " />
								<form:option value="Febrero" label="Febrero  " />
								<form:option value="Marzo" label="Marzo  " />
								<form:option value="Abril" label="Abril  " />
								<form:option value="Mayo" label="Mayo  " />
								<form:option value="Junio" label="Junio  " />
								<form:option value="Julio" label="Julio  " />
								<form:option value="Agosto" label="Agosto  " />
								<form:option value="Septiembre" label="Septiembre  " />
								<form:option value="Octubre" label="Octubre  " />
								<form:option value="Noviembre" label="Noviembre  " />						
								<form:option value="Diciebre" label="Diciembre  " />					
							</form:select> 
							
							<form:select path="ano_nacimiento" id="ano_nacimiento"> 
								<form:option value="" label="-  " />		
								<c:forEach var="i" begin="1900" end="2001" step="1">
              			 	    	<form:option value="${i}" label="${i}  " />
     						    </c:forEach>						
							</form:select>					
							
				    		</div>		
							
							<div id ="id_pais" class="campo_input">						
				    		<label id="label_pais" for="pais">Pais:</label>
							<form:select path="pais" id="pais" onchange="cambia_provincia()"> 
								<form:option value="" label="-" />								
								<form:option value="Alemania" label="Alemania" />								
								<form:option value="Argentina" label="Argentina" />
								<form:option value="España" label="España" />
								<form:option value="Francia" label="Francia" />
								<form:option value="Italia" label="Italia" />	
								<form:option value="Portugal" label="Portugal" />															
							</form:select> <span class="erroresform">*</span>
							<form:errors path="pais" cssClass="erroresform" />					
				    		</div>	
		
				    		<div class="campo_input">
				    			<label id="label_provincia" for="provincia">Provincia:</label>	
					    		<span id="solo_espana_msg"></span>
					    		<div id="id_provincia">			    			
									<form:select path="provincia" id="provincia" > 
										<form:option value="" label="-  " />
										<form:option value="Alava" label="Álava  " />
										<form:option value="Albacete" label="Albacete  " />
										<form:option value="Alicante" label="Alicante  " />
										<form:option value="Almeria" label="Almería  " />
										<form:option value="Asturias" label="Asturias  " />
										<form:option value="Madrid" label="Madrid  " />
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
				    		<label id="label_telefono" for="telefono">Teléfono:</label>		    				
							<form:input path="telefono" id="telefono" /> 					
				    		</div>	
		
				    		<div class="campo_input">	
				    		<label id="label_codigo_postal" for="codigo_postal">Código Postal:</label>
							<form:input path="codigo_postal" id="codigo_postal"/> <span class="erroresform">*</span>
							<form:errors path="codigo_postal" cssClass="erroresform" />
				    		</div>						
							
				    		<div class="campo_input">		
				    		<label id="label_direccion" for="direccion">Dirección:</label>				
							<form:input path="direccion" id="direccion" /> <span class="erroresform">*</span>
							<form:errors path="direccion" cssClass="erroresform" />
				    		</div>										
							
			    		</div>
			    	</fieldset>
			    							
						<div class="erroresform">* Campos Obligatorios</div>	
								
						<input type="submit" id="registro_submit" value="Registrar" style="filter:alpha(opacity=100)" onMouseover="makevisible(this,1);this.style.opacity=0.8;" onMouseout="makevisible(this,0);this.style.opacity=1;">
					
				</form:form>
			</div>
		</div>	
