package com.nhj.springProjectmelon.model.user;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User implements UserDetails {
	private int id;
	private String username;
	private String name;
	private String password;
	private String email;
	private String profile;
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
		}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	//계정이 잠겨있는지 체크하여 리턴한다(true:잠기지 않음)
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	//비밀번호가 만료되었는지 체크하여 리턴한다.(true:만료안됨)
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	//해당 계정이 활성화 되어있느지 체크하여 리턴한다(true:활성화)
	@Override
	public boolean isEnabled() {
		return true;
	}

}
