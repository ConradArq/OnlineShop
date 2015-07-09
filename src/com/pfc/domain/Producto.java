package com.pfc.domain;

import java.util.HashSet;
import java.util.Set;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="productos")
public class Producto {
	
	int idproductos;
	String producto;
	String descripcion;
	double precio;
	String fecha_edicion;
	int cantidad;
	String autor;
	String editorial;
	String categoria;
	String ISBN;
	String URL_portada;
	private Set<LineaPedido> lineasPedido;

	@Id
	@GeneratedValue
	@Column(name="idproductos")
	public int getIdproductos() {
		return this.idproductos;
	}
	public void setIdproductos(int idproductos) {
		this.idproductos = idproductos;
	}
	
	@Column(name="producto",nullable = false)
	public String getProducto() {
		return this.producto;
	}
	public void setProducto(String producto) {
		this.producto = producto;
	}
	
	@Column(name="descripcion", columnDefinition="TEXT")
	public String getDescripcion() {
		return this.descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	@Column(name="precio",nullable = false)
	public double getPrecio() {
		return this.precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	
	@Column(name="fecha_edicion")
	public String getFecha_edicion() {
		return this.fecha_edicion;
	}
	public void setFecha_edicion(String fecha_edicion) {
		this.fecha_edicion = fecha_edicion;
	}
	
	@Column(name="cantidad",nullable = false)
	public int getCantidad() {
		return this.cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	
	@Column(name="autor", nullable = false)
	public String getAutor() {
		return this.autor;
	}
	public void setAutor(String autor) {
		this.autor = autor;
	}
	
	@Column(name="editorial")
	public String getEditorial() {
		return this.editorial;
	}
	public void setEditorial(String editorial) {
		this.editorial = editorial;
	}
	
	@Column(name="categoria")
	public String getCategoria() {
		return this.categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	
	@Column(name="ISBN")
	public String getISBN() {
		return this.ISBN;
	}
	public void setISBN(String ISBN) {
		this.ISBN = ISBN;
	}

	@Column(name="URL_portada")
	public String getURL_portada() {
		return this.URL_portada;
	}
	public void setURL_portada(String URL_portada) {
		this.URL_portada = URL_portada;
	}
	
	@OneToMany (mappedBy="producto")	
	public Set<LineaPedido> getLineasPedido() {
		return this.lineasPedido;
	}
	public void setLineasPedido(Set<LineaPedido> lineasPedido) {
		this.lineasPedido = lineasPedido;
	} 
	
	
	public void addLineaPedido(LineaPedido lineapedido) {
	    lineapedido.setProducto(this);
	    if (getLineasPedido()==null){
	    	Set<LineaPedido> lineasPedido=new HashSet();
	    	lineasPedido.add(lineapedido);
	    	setLineasPedido(lineasPedido);
	    }else	    
	    	getLineasPedido().add(lineapedido);
	}

}
