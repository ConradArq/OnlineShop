package com.pfc.dao;

import java.util.List;
import com.pfc.domain.Usuario;

public interface UsuarioDAO {
	public void saveUser(Usuario usuario);
	public List<Usuario> listUser(String username);
	public void updateUser(Usuario usuario);
}