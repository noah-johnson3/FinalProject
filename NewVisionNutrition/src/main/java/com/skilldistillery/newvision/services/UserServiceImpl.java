package com.skilldistillery.newvision.services;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public User getUserById(int id) {
		User user = null;
		Optional<User> op = userRepo.findById(id);
		if(op.isPresent()) {
			user = op.get();
		}
		return user;
	}

	@Override
	public boolean deactivate(String username, int id) {
		boolean isActive = true;
		Optional<User> op = userRepo.findById(id);
		if(op.isPresent()) {
			User deactivatedUser = op.get();
			deactivatedUser.setActive(false);
			userRepo.saveAndFlush(deactivatedUser);
			isActive = false;
		}
		return isActive;
	}

	@Override
	public User updateUser(User user, int id, String username) {
		Optional<User> op = userRepo.findById(id);
		if(op.isPresent()) {
			user.setId(id);
			userRepo.saveAndFlush(user);
		}else {
			user = null;
		}
		return user;
	}

	@Override
	public List<User> index() {
		return userRepo.findAll();
	}

	@Override
	public User findByUsernameEquals(String username) {
		return userRepo.findByUsernameEquals(username);
	}
	
	

}
