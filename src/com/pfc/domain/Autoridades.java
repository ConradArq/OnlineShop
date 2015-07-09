package com.pfc.domain;

import java.util.Set;

import javax.persistence.*;


@Entity
@Table(name = "authorities", uniqueConstraints = { @UniqueConstraint( columnNames = { "username", "authority" } ) } )
public class Autoridades {

    private String authority;
    private String username;

    
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name="idautoridades")
	long idautoriades;
	
	public Autoridades(String authority, String username){
		this.authority=authority;
		this.username=username;
	}
	
	public Autoridades(){
	
	}

    @Column(name="authority")
	public String getAuthority() {
		return this.authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
	@Column (name="username")
	public String getUsername(){
		return this.username;
	}
	
	public void  setUsername(String username){
		this.username = username;
	}
	
}