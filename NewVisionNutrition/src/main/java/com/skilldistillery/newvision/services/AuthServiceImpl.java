package com.skilldistillery.newvision.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.UserRepository;


@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private UserRepository ur;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Override
	public User register(User user) {
		 String encodedPW = encoder.encode(user.getPassword());
		    user.setPassword(encodedPW); // only persist encoded password

		    // set other fields to default values
		    user.setActive(true);
		    user.setRole("standard");
		    ur.saveAndFlush(user);
		    return user;
	}

	@Override
	public User getUserByUsername(String username) {
		return ur.findByUsernameEquals(username);
	}

	
	
}
