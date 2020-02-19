package com.nhj.springProjectmelon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.nhj.springProjectmelon.model.user.User;
import com.nhj.springProjectmelon.repository.UserRepository;

@Service
public class MyUserDetailService implements UserDetailsService {

	@Autowired
	private UserRepository userRepository;

	private User user;

	public User getPrincipal() {
		return user;
	}

	// 패스워드는 간직하고 있고 유저네임만 전달 해준다.
	// 유저프로바이더는 유저디테일을 만든다.
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//여기에 진입하면 세션이 만들어진다. 근데 모든페이지에서 리턴받을 수는 없으니까 @서비스니까 싱글톤으로 뜬다 유저를 이제 땡겨와서 사용하면된다
		user = userRepository.authentication(username);
		if (user == null) {
			throw new UsernameNotFoundException("해당 유저가 없습니다. ");
		}
		return user;
	}
}
