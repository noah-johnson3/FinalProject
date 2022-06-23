package com.skilldistillery.newvision.services;

import java.security.Principal;
import java.util.List;

import com.skilldistillery.newvision.entities.User;

public interface UserService {

	User getUserById(int id);
	boolean deactivate(String username, int id);
	User updateUser(User user, int id, String username);
	List<User> index();
	User findByUsernameEquals(String username);
	
}
