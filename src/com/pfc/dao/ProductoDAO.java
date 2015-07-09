package com.pfc.dao;
import com.pfc.domain.Producto;

import java.util.List;

public interface ProductoDAO {
	
	public List<Producto> listProducto();
	public List<Producto> ofertasProducto();
	public List<Producto> listaPagProducto(int paginaActual, int resultadosPorPagina) ;
	public Producto getProducto(int idproductos);
	public List<Producto> listaProductoPorCategoria(String categoria);
	public List<Producto> listaProductoPorCategoriaCarousel(String categoria);
	public List<Producto> listaPagProductoPorCategoria(String categoria, int paginaActual, int resultadosPorPagina);
	public List<Producto> buscarProducto(String parametro_busqueda);
	public List<Producto> listaPagBuscarProducto(String parametro_busqueda, int paginaActual, int resultadosPorPagina);
	public List<Producto> buscarProductoAvanzada(String titulo, String autor, String ISBN, String editorial);
	public List<Producto> listaPagbuscarProductoAvanzada(String titulo, String autor, String ISBN, String editorial, int paginaActual, int resultadosPorPagina);
}
