package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Goal;

public interface GoalRepository extends JpaRepository<Goal, Integer>{

}
