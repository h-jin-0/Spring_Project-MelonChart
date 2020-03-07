package com.nhj.springProjectmelon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.nhj.springProjectmelon.model.user.User;
import com.nhj.springProjectmelon.model.user.dto.ReqJoinDto;
import com.nhj.springProjectmelon.model.user.dto.ReqLoginDto;
import com.nhj.springProjectmelon.model.user.dto.ReqProfileDto;
import com.nhj.springProjectmelon.repository.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepository;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Autowired
	private MyUserDetailService myUserDetailService;

	@Value("${file.path}")
	private String fileRealPath;// 서버에 배포하면 경로 변경해야함!!!!!

	public int join(ReqJoinDto reqJoinDto) {
		try {
			// 패스워드 암호화 하기!
			String encodePassword = passwordEncoder.encode(reqJoinDto.getPassword());
			reqJoinDto.setPassword(encodePassword);// 암호화되서 들어간다.토큰이 알아서 바꿔서해준다.
			return userRepository.save(reqJoinDto);

		} catch (Exception e) {
			throw new RuntimeException();
		}

	}

	public int doubleCheck(String checkId) {
		return userRepository.findByUsername(checkId);
	}

	public User login(ReqLoginDto reqLoginDto) {
		return userRepository.findByUsernameAndPassword(reqLoginDto);
	}

	public int profile(ReqProfileDto reqProfileDto) {
		try {
			// 패스워드 암호화 하기!
			String encodePassword = passwordEncoder.encode(reqProfileDto.getPassword());
			reqProfileDto.setPassword(encodePassword);// 암호화되서 들어간다.토큰이 알아서 바꿔서해준다.
			int result= userRepository.update(reqProfileDto);
			if(result==1) {
				User principal=myUserDetailService.getPrincipal();//여기서 세션을 들고옴
				principal.setPassword(encodePassword);
				principal.setProfile(reqProfileDto.getProfile());
				return 1;
			}else {
				return -1;
			}
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}
}
