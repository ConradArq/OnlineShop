package com.pfc.domain;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.*;

@Entity
@Table(name="users")
public class Usuario {
	
	String username;
	String password;
	String nombre;
	String apellidos;
	String sexo;
	String dia_nacimiento;
	String mes_nacimiento;
	String ano_nacimiento;	
	String telefono;
	String pais;
	String provincia;
	String codigo_postal;
	String direccion;
	boolean enabled;  	
	private Set<Autoridades> rolesAutoridades;
	private List<Pedido> pedidos;
	
	@Id
	@Column(name="username",nullable = false)
	public String getUsername() {
		return this.username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	@Column(name="password",nullable = false)
	public String getPassword() {
		return this.password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Column(name="nombre",nullable = false)
	public String getNombre() {
		return this.nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	@Column(name="apellidos",nullable = false)
	public String getApellidos() {
		return this.apellidos;
	}
	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}
	
	@Column(name="sexo")
	public String getSexo() {
		return this.sexo;
	}
	public void setSexo(String sexo) {
		this.sexo= sexo;
	}
	
	@Column(name="dia_nacimiento")
	public String getDia_nacimiento() {
		return this.dia_nacimiento;
	}
	public void setDia_nacimiento(String dia_nacimiento) {
		this.dia_nacimiento = dia_nacimiento;
	}
	
	@Column(name="mes_nacimiento")
	public String getMes_nacimiento() {
		return this.mes_nacimiento;
	}
	public void setMes_nacimiento(String mes_nacimiento) {
		this.mes_nacimiento = mes_nacimiento;
	}
	
	@Column(name="ano_nacimiento")
	public String getAno_nacimiento() {
		return this.ano_nacimiento;
	}
	public void setAno_nacimiento(String ano_nacimiento) {
		this.ano_nacimiento = ano_nacimiento;
	}
	
	@Column(name="telefono")
	public String getTelefono() {
		return this.telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	
	@Column(name="pais",nullable = false)
	public String getPais() {
		return this.pais;
	}
	public void setPais(String pais) {
		this.pais = pais;
	}
	
	@Column(name="provincia")
	public String getProvincia() {
		return this.provincia;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	
	@Column(name="codigo_postal",nullable = false)
	public String getCodigo_postal() {
		return this.codigo_postal;
	}
	public void setCodigo_postal(String codigo_postal) {
		this.codigo_postal = codigo_postal;
	}
	
	@Column(name="direccion",nullable = false)
	public String getDireccion() {
		return this.direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	@Column(name="enabled",nullable = false)
	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	

	@OneToMany (mappedBy="username")	
	public Set<Autoridades> getRolesAutoridades() {
		return this.rolesAutoridades;
	}
	public void setRolesAutoridades(Set<Autoridades> rolesAutoridades) {
		this.rolesAutoridades = rolesAutoridades;
	} 


	@OneToMany (mappedBy="usuario")	
	public List<Pedido> getPedidos() {
		return this.pedidos;
	}
	public void setPedidos(List<Pedido> pedidos) {
		this.pedidos = pedidos;
	} 
	
	
	public void addPedido(Pedido pedido) {
	    pedido.setUsuario(this);
	    if (getPedidos()==null){
	    	List<Pedido> pedidos=new ArrayList();
	    	pedidos.add(pedido);
	    	setPedidos(pedidos);	    	
	    }else
	    	getPedidos().add(pedido);
	}
}
