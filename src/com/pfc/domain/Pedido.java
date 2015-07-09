package com.pfc.domain;

import java.util.*;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;
import javax.persistence.FetchType;

@Entity
@Table(name="pedidos")

public class Pedido {
	
	int idpedido;
	String fecha;
	boolean confirmado;
	Usuario usuario;
	private List<LineaPedido> lineasPedido;
	double importePedido;
	int cantidadPedido;
	
	@Id
	@GeneratedValue
	@Column(name="idpedido")
	public int getIdpedido() {
		return this.idpedido;
	}
	public void setIdpedido(int idpedido) {
		this.idpedido = idpedido;
	}

	
	@Column(name="fecha")
	public String getFecha() {
		return this.fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	
	
	@Column(name="confirmado", nullable = false)
	public boolean getConfirmado() {
		return this.confirmado;
	}
	public void setConfirmado(boolean confirmado) {
		this.confirmado = confirmado;
	}
	

	@ManyToOne
	public Usuario getUsuario() {
		return this.usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	

	@OneToMany (mappedBy="pedido", fetch=FetchType.EAGER)
	public List<LineaPedido> getLineasPedido() {
		return this.lineasPedido;
	}
	public void setLineasPedido(List<LineaPedido> lineasPedido) {
		this.lineasPedido = lineasPedido;
	} 
	
	
	public void addLineaPedido(LineaPedido lineapedido) {
	    lineapedido.setPedido(this);
	    if (getLineasPedido()==null){
	    	List<LineaPedido> lineasPedido=new ArrayList();
	    	lineasPedido.add(lineapedido);
	    	setLineasPedido(lineasPedido);
	    }else	    
	    	getLineasPedido().add(lineapedido);
	}
	
	@Transient
	public double getImportePedido(){
		importePedido=0;
		for(LineaPedido lp:getLineasPedido()){
			importePedido=importePedido + lp.getPrecio()*lp.getCantidad();
		}
		
		long importePedidoTrunc=(long)((importePedido+5.22)*100);	
		return (double)importePedidoTrunc/100;
	}
	
	public void setImportePedido(double importePedido){
		this.importePedido=importePedido;
	}
	
	
	@Transient
	public int getCantidadPedido(){
		cantidadPedido=0;
		for(LineaPedido lp:getLineasPedido()){
			cantidadPedido=cantidadPedido + lp.getCantidad();
		}
		
		return cantidadPedido;
	}
	
	
	public void setCantidadPedido(int cantidadPedido){
		this.cantidadPedido=cantidadPedido;
	}
}
