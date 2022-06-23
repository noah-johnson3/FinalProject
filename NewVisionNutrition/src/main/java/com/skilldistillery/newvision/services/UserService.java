package com.skilldistillery.newvision.services;

import com.skilldistillery.newvision.entities.User;

public interface UserService {

	User getUserById(int id);
	User deactivateUser(User user);
	User updateUser(User user, int id);
	
}
