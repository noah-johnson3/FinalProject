package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.skilldistillery.newvision.entities.User;

public interface UserRepository  extends JpaRepository<User, Integer>{

	User findByUsernameEquals(String username);

	
	
}
