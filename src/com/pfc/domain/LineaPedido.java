package com.pfc.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="LineaPedido")

public class LineaPedido {

	int idlineaPedido;
	int cantidad;
	double precio;
	Pedido pedido;
	Producto producto;
	double importeProducto;
	double sum_cantidad;

	@Id
	@GeneratedValue
	@Column(name="idlineaPedido")
	public int getIdlineaPedido() {
		return this.idlineaPedido;
	}
	public void setIdlineaPedido(int idlineaPedido) {
		this.idlineaPedido = idlineaPedido;
	}
	
	
	@Column(name="cantidad",nullable = false)
	public int getCantidad() {
		return this.cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	

	@Column(name="precio",nullable = false)
	public double getPrecio() {
		return this.precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	

	@ManyToOne
	public Pedido getPedido() {
		return this.pedido;
	}
	public void setPedido(Pedido pedido) {
		this.pedido = pedido;
	}

	@ManyToOne
	public Producto getProducto() {
		return this.producto;
	}
	public void setProducto(Producto producto) {
		this.producto = producto;
	}
	
	@Transient
	public double getImporteProducto(){
		importeProducto=getPrecio()*getCantidad();		
		long importeProductoTrunc=(long)(importeProducto*100);	
		return (double)importeProductoTrunc/100;
	}
	
	public void setImporteProducto(double importeProducto){
		this.importeProducto=importeProducto;
	}

	@Transient
	public double getSum_cantidad(){
		return this.sum_cantidad;
	}
	
	public void setSum_cantidad(double sum_cantidad){
		this.sum_cantidad=sum_cantidad;
	}
	
}
