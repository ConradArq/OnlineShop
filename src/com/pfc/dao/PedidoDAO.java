package com.pfc.dao;
import java.util.List;
import com.pfc.domain.Pedido;
import com.pfc.domain.Producto;
import com.pfc.domain.LineaPedido;

public interface PedidoDAO {
	
	public List<LineaPedido> masComprados();
	public Pedido getPedidoByIdpedido(int idpedido);
	public List<Pedido> listPedidos(String username);
	public List<Pedido> listaPagPedidos(String username, int paginaActual, int resultadosPorPagina);
	public Pedido getPedidoCarrito(String username);
	public void addProductosCarrito(String username, int idproducto);
	public void restaProductosCarrito(String username, int idproducto);
	public void borrarProductosCarrito(String username, int idproducto);
	public void addPedido(String username, String fecha);
}
