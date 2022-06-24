package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.TrackedDay;

public interface TrackedDayRepository extends JpaRepository<TrackedDay, Integer>{

	List<TrackedDay> findByUser_UsernameEquals(@Param("Username") String username);
	
}
