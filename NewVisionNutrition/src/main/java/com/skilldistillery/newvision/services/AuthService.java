package com.skilldistillery.newvision.services;

import com.skilldistillery.newvision.entities.User;

public interface AuthService {

	public User register(User user);
	public User getUserByUsername(String username);
	
}
