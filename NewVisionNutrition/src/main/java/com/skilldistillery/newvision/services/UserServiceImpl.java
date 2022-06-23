package com.skilldistillery.newvision.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserRepository ur;

	@Override
	public User getUserById(int id) {
		User user = null;
		Optional<User> op = ur.findById(id);
		if(op.isPresent()) {
			user = op.get();
		}
		return user;
	}

	@Override
	public User deactivateUser(User user) {
		return null;
	}

	@Override
	public User updateUser(User user, int id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
