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
		User updatedUser = userRepo.findByUsernameEquals(username);
		if(user.equals(updatedUser)) {
			updatedUser.setActive(user.isActive());
			updatedUser.setActivityLevel(user.getActivityLevel());
			updatedUser.setDateOfBirth(user.getDateOfBirth());
			updatedUser.setEmail(user.getEmail());
			updatedUser.setFirstName(user.getFirstName());
			updatedUser.setGender(user.getGender());
			updatedUser.setHeight(user.getHeight());
			updatedUser.setImageUrl(user.getImageUrl());
			updatedUser.setLastName(user.getLastName());
			updatedUser.setPublicProfile(user.isPublicProfile());
			updatedUser.setWeight(user.getWeight());
			updatedUser = userRepo.saveAndFlush(updatedUser);
		}else {
			user = null;
		}
		return updatedUser;
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
