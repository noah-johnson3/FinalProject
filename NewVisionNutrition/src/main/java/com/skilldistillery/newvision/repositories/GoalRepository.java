package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.Goal;

public interface GoalRepository extends JpaRepository<Goal, Integer>{
	
	List<Goal> findByUser_UsernameEquals(String username);
	List<Goal> findByAchievedEqualsAndUser_UsernameEquals(@Param("achieved")boolean achieved,
	@Param("username")String username);

}
