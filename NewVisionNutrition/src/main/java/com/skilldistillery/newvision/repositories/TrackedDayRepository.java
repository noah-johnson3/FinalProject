package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.TrackedDay;

public interface TrackedDayRepository extends JpaRepository<TrackedDay, Integer>{

	TrackedDay findByUser_UsernameEquals(@Param("Username") String username);
	
}
