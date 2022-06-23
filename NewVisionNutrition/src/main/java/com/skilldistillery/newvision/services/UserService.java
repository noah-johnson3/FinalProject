package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.User;

public interface UserService {

	User getUserById(int id);
	boolean deactivate(String username, int id);
	User updateUser(User user, int id);
	List<User> index();
	
}
