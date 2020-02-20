package com.nhj.springProjectmelon.config;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nhj.springProjectmelon.model.RespCM;
import com.nhj.springProjectmelon.service.MyUserDetailService;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true) // 진입되기 직전에 메모리에 띄울 것 이다.
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Bean
	public BCryptPasswordEncoder encoded() {
		return new BCryptPasswordEncoder();
	}

	@Autowired
	private MyUserDetailService myUserDetailService;

	@Override
	protected void configure(HttpSecurity http) throws Exception { // 모든 요청을 받는다.
		http.csrf().disable();

		http.authorizeRequests().antMatchers("/music/**").permitAll().and().formLogin().loginPage("/user/login")
				.loginProcessingUrl("/user/login") // POST만 낚아 챔
				.successHandler(new AuthenticationSuccessHandler() {

					@Override
					public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
							Authentication authentication) throws IOException, ServletException {
						PrintWriter out = response.getWriter();

						ObjectMapper mapper = new ObjectMapper();
						// String으로 저장
						String jsonString = mapper.writeValueAsString(new RespCM(200, "ok"));
						out.print(jsonString);
						out.flush();

					}
				}).and().logout().logoutRequestMatcher(new AntPathRequestMatcher("/user/logout"))
			.logoutSuccessUrl("/").invalidateHttpSession(true);
//		
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(myUserDetailService).passwordEncoder(encoded());
	}
}